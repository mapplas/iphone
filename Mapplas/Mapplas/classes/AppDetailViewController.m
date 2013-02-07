//
//  AppDetailViewController.m
//  Mapplas
//
//  Created by Belén  on 29/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppDetailViewController.h"

@interface AppDetailViewController ()
- (void)downloadGalleryImages;
- (void)initLayout;
- (void)configureGallery;
- (void)showAppSmallDescription;
- (void)showAppCompleteDescription;
- (void)adjustLabel:(CGSize)max_label_size;
- (void)initPinActionLayout;
@end

@implementation AppDetailViewController

@synthesize app = _app, user = _user, currentLocation = _current_location, model = _model;

//@synthesize commentsViewController = _commentsViewController;

@synthesize scroll;

@synthesize topBar, logo, name, priceBackground, priceLabel, ratingView, ratingViewButton;
@synthesize actionBar, pinButton, pinLabel, rateButton, rateLabel, blockButton, blockLabel, shareButton, shareLabel, phoneButton, phoneLabel;
@synthesize actionBarWithoutTeleph, pinWithoutPhoneButton, pinWithoutPhoneLabel, rateWithoutPhoneLabel, blockWithoutPhoneLabel, shareWithoutPhoneLabel;
@synthesize galleryView, galleryBackground, galleryScroll, pageControl;
@synthesize descriptionView, descriptionText, morebutton, moreBigButton;
@synthesize supportView, developerLabel, devWebButton, devEmailButton, asistencyButton;
@synthesize supportModalView, actionView;

- (id)initWithApp:(App *)app user:(User *)user model:(SuperModel *)super_model andLocation:(NSString *)current_location {
    self = [super initWithNibName:@"AppDetailViewController" bundle:nil];
    if (self) {
        self.app = app;
        self.user = user;
        self.currentLocation = current_location;
        self.model = super_model;
        
        imagesArray = [[NSMutableDictionary alloc] init];
        downloadedImages = 0;
        descriptionOpened = NO;
        somethingChangedOnApp = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *viewsToAddToScroll = nil;
//    if (self.app.auxCommentsArray.count > 0) {
//        self.commentsViewController = [[AppDetailCommentsViewController alloc] initWithApp:self.app];
//        viewsToAddToScroll = [[NSMutableArray alloc] initWithObjects:self.topBar, self.actionBar, self.galleryView, self.descriptionView, self.commentsViewController, self.supportView, nil];
//    }
//    else {
    
    // Telephone icon or not
    UIView *whatActionBar = self.actionBar;
    if ([self.app.phone isEqualToString:@""]) {
        whatActionBar = self.actionBarWithoutTeleph;
    }
    viewsToAddToScroll = [[NSMutableArray alloc] initWithObjects:self.topBar, whatActionBar, self.galleryView, self.descriptionView, self.supportView, nil];

    
    scrollViewConfigurator = [[ScrollViewOfViews alloc] initWithViews:viewsToAddToScroll inScrollView:self.scroll delegate:self];
    
    [self downloadGalleryImages];
    [self initLayout];
    [self configureGallery];
    
    [scrollViewConfigurator organize];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (somethingChangedOnApp) {
        [[Environment sharedInstance] setAppSomethingChangedInDetail:somethingChangedOnApp];
        somethingChangedOnApp = NO;
    }
}

- (void)downloadGalleryImages {
    ImageLoaderFactory *factory = [[ImageLoaderFactory alloc] init];
    AsynchronousImageDownloader *downloader = [[AsynchronousImageDownloader alloc] initWithDelegate:self];
    imageLoader = [factory createUsingCacheFolderWithDownloader:downloader];
    
    for (Photo *currenPhoto in self.app.auxPhotosArray) {
        UIImage *currentImage = [imageLoader load:currenPhoto.photo withSaveName:[NSString stringWithFormat:@"%@.%d", self.app.appId, [currenPhoto.photoId intValue]]];
        if (currentImage == nil) {
            [imagesArray setValue:@"" forKey:[NSString stringWithFormat:@"%@.%d", self.app.appId, [currenPhoto.photoId intValue]]];
        }
        else {
            [imagesArray setValue:currentImage forKey:[NSString stringWithFormat:@"%@.%d", self.app.appId, [currenPhoto.photoId intValue]]];
        }
    }
}

- (void)initLayout {
    // Set app logo
    UIImage *image = [imageLoader load:self.app.appLogo withSaveName:self.app.appId];
    if (image != nil) {
        [self.logo setImage:image];
    }
    
    // Set app name
    self.name.text = self.app.name;
    
    // Price label and image
    PriceImageLabelHelper *priceHelper = [[PriceImageLabelHelper alloc] initWithApp:self.app];
    self.priceLabel.text = [priceHelper getPriceText];
    self.priceBackground.image = [priceHelper getImage];
    
    // Rating
    RatingHelper *ratingHelper = [[RatingHelper alloc] init];
    [self.topBar addSubview:[ratingHelper getRatingViewForView:self.ratingView andApp:self.app]];

    // Action layout
    [self initPinActionLayout];
    
    NSString *rateLabelText = NSLocalizedString(@"rate_singular_text", @"Rate singular text");
    self.rateLabel.text = rateLabelText;
    self.rateWithoutPhoneLabel.text = rateLabelText;
    
    NSString *blockLabelText = NSLocalizedString(@"block_text", @"Block text");
    self.blockLabel.text = blockLabelText;
    self.blockWithoutPhoneLabel.text = blockLabelText;
    
    NSString *shareLabelText = NSLocalizedString(@"share_text", @"Share text");
    self.shareLabel.text = shareLabelText;
    self.shareWithoutPhoneLabel.text = shareLabelText;
    
    self.phoneLabel.text = NSLocalizedString(@"call_text", @"Detail screen call text");
    
    // Description
    [self showAppSmallDescription];
    
    // Support
    self.developerLabel.text = NSLocalizedString(@"app_detail_developer_label_text", @"App detail - developer text");
    
    [self.devWebButton setTitle:NSLocalizedString(@"app_detail_developer_web_button", @"App detail - developer web") forState:UIControlStateNormal];
    [self.devEmailButton setTitle:NSLocalizedString(@"app_detail_developer_email_button", @"App detail - developer email") forState:UIControlStateNormal];
    [self.asistencyButton setTitle:NSLocalizedString(@"app_detail_developer_support_button", @"App detail - support button") forState:UIControlStateNormal];
}

- (void)configureGallery {
	CGFloat contentOffset = 0.0f;
    ImageResizer *resizer = [[ImageResizer alloc] initWithScroll:self.galleryScroll];
    
    NSArray *keys = [imagesArray allKeys];
    
    self.galleryScroll.clipsToBounds = NO;
	self.galleryScroll.pagingEnabled = YES;
    self.galleryScroll.showsHorizontalScrollIndicator = NO;
    self.galleryScroll.delegate = self;
    
    self.pageControl.numberOfPages = keys.count;
    self.pageControl.currentPage = 0;
    
    if (keys.count > 0) {
        for (NSString *currentKey in keys) {
            
            if ([imagesArray objectForKey:currentKey] != nil && ![[imagesArray objectForKey:currentKey] isKindOfClass:[NSString class]]) {
                UIImageView *imageView = [resizer getImageViewForImage:[imagesArray objectForKey:currentKey] contentOffset:contentOffset background:self.galleryBackground container:self.galleryView];
                
                imageView.image = [resizer resizeImage:[imagesArray objectForKey:currentKey]];
                imageView.contentMode = UIViewContentModeCenter;
                
                [self.galleryScroll addSubview:imageView];
                
                contentOffset += imageView.frame.size.width;
                self.galleryScroll.contentSize = CGSizeMake(contentOffset, self.galleryScroll.frame.size.height);
            }
        }
    }
    else {
        [scrollViewConfigurator removeView:self.galleryView];
        [scrollViewConfigurator organize];
    }
}

- (void)showAppSmallDescription {
    CGSize maximumLabelSize = CGSizeMake(self.descriptionText.frame.size.width, 110);
    [self adjustLabel:maximumLabelSize];
}

- (void)showAppCompleteDescription {
    CGSize maximumLabelSize = CGSizeMake(self.descriptionText.frame.size.width, FLT_MAX);
    [self adjustLabel:maximumLabelSize];
}

- (void)adjustLabel:(CGSize)max_label_size {
    CGSize expectedLabelSize = [self.app.appDescription sizeWithFont:self.descriptionText.font
                                                   constrainedToSize:max_label_size
                                                       lineBreakMode:self.descriptionText.lineBreakMode];
    // Adjust label to the new height.
    self.descriptionText.numberOfLines = 0;
    CGRect newFrame = self.descriptionText.frame;
    newFrame.size.height = expectedLabelSize.height;
    self.descriptionText.frame = newFrame;
    CGRect viewFrame = CGRectMake(self.descriptionText.frame.origin.x, self.descriptionText.frame.origin.y, self.descriptionText.frame.size.width, self.descriptionText.frame.size.height + 30);
    self.descriptionView.frame = viewFrame;
    self.moreBigButton.frame = viewFrame;
    
    self.descriptionText.text = self.app.appDescription;
}

- (IBAction)showCompleteDescription:(id)sender {
    
    if (descriptionOpened) {
        descriptionOpened = NO;
        [self showAppSmallDescription];
    }
    else {
        descriptionOpened = YES;
        [self showAppCompleteDescription];
    }
    
    [scrollViewConfigurator organize];
}

#pragma mark - UIScrollViewDelegate methods - PageControl
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.galleryScroll.frame.size.width;
    int page = floor((self.galleryScroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}

- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= [imagesArray allKeys].count) return;
}

#pragma mark - AsynchronousImageDownloadedProtocol methods
- (void)imageDownloaded:(DownloadedImageSuccess *)download withSaveName:(NSString *)save_name {
    [imageLoader saveImageInCache:download.image path:save_name];

    if ([save_name isEqualToString:self.app.appId]) {
        [self.logo setImage:download.image];
    }
    else {
        downloadedImages++;
        [imagesArray setValue:download.image forKey:save_name];
    }
    
    if (downloadedImages == [imagesArray allKeys].count) {
        [self configureGallery];
        [scrollViewConfigurator organize];
    }
}

- (void)imageNotDownloaded:(DownloadedImageError *)error withSaveName:(NSString *)save_name {
    downloadedImages++;
}

#pragma action bar actions
- (IBAction)pinUp:(id)sender {
    NSString *action = @"";
    if ([self.app.auxPin isEqualToString:@"1"]) {
        action = ACTION_PIN_REQUEST_UNPIN;
        self.app.auxPin = @"0";
        self.app.auxTotalPins = [NSNumber numberWithInt:[self.app.auxTotalPins intValue] - 1];
    }
    else {
        action = ACTION_PIN_REQUEST_PIN;
        self.app.auxPin = @"1";
        self.app.auxTotalPins = [NSNumber numberWithInt:[self.app.auxTotalPins intValue] + 1];
    }
    
    somethingChangedOnApp = YES;

    pinRequest = [[AppPinRequest alloc] init];
    [pinRequest doRequestWithAppId:self.app.appId userId:self.user.userId action:action andLocation:self.currentLocation];
    
    [self initPinActionLayout];
}

- (void)initPinActionLayout {
    if ([self.app.auxPin isEqualToString:@"1"]) {
        self.pinButton.selected = YES;
        self.pinWithoutPhoneButton.selected = YES;
        
        NSString *pinLabelText = NSLocalizedString(@"un_pin_up", @"Pin unpin text");
        self.pinLabel.text = pinLabelText;
        self.pinWithoutPhoneLabel.text = pinLabelText;
    }
    else {
        self.pinButton.selected = NO;
        self.pinWithoutPhoneButton.selected = NO;
        
        NSString *pinLabelText = NSLocalizedString(@"pin_sing_text", @"Pin singular text");
        self.pinLabel.text = pinLabelText;
        self.pinWithoutPhoneLabel.text = pinLabelText;
    }
}

- (IBAction)block:(id)sender {
    self.app.auxBlocked = @"1";
    somethingChangedOnApp = YES;
    
    [self.model.appList deleteApp:self.app];
    
    blockRequest = [[AppBlockRequest alloc] init];
    [blockRequest doRequestWithAppId:self.app.appId userId:self.user.userId action:ACTION_LIKE_REQUEST_BLOCK];
    
    pinRequest = [[AppPinRequest alloc] init];
    [pinRequest doRequestWithAppId:self.app.appId userId:self.user.userId action:ACTION_PIN_REQUEST_UNPIN andLocation:self.currentLocation];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)rate:(id)sender {
    RatingModalViewController *ratingController = [[RatingModalViewController alloc] initWithAppId:self.app.appId userId:self.user.userId location:self.model.currentLocation descriptiveGeoLoc:self.model.currentDescriptiveGeoLoc andView:self.view];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:ratingController];
    [SCAppUtils customizeNavigationController:navController];
    ratingController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentModalViewController:navController animated:YES];
}

- (IBAction)share:(id)sender {
    sharingHelper = [[SharingHelper alloc] initWithApp:self.app navigationController:self.navigationController];
    
    // If device has ios6 and up
	if ([UIActivityViewController class]) {
		NSMutableArray *itemsToShare = [[NSMutableArray alloc] initWithObjects:[sharingHelper getShareMessage], nil];

		UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
		activityViewController.excludedActivityTypes = @[UIActivityTypePostToWeibo, UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePrint, UIActivityTypeSaveToCameraRoll];
        
		[self presentViewController:activityViewController animated:YES completion:nil];
	}
	else {
        // iOS 5
		NSString *cancelButton = NSLocalizedString(@"ios5_sharing_action_sheet_cancel_button", @"iOS5 sharing action sheet cancel button - twitter sharing");
		NSString *twitterButton = NSLocalizedString(@"ios5_sharing_action_sheet_twitter_button", @"iOS5 sharing action sheet twitter button - twitter sharing");
        
		UIActionSheet *alertView = [[UIActionSheet alloc] initWithTitle:nil delegate:sharingHelper cancelButtonTitle:cancelButton destructiveButtonTitle:nil otherButtonTitles:twitterButton, @"Share via SMS", @"Share via email", nil];
		[alertView showInView:self.view];
	}
}

- (IBAction)call:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", self.app.phone]]];
}

- (IBAction)toDeveloperMail:(id)sender {
    NSString *developerMail = @"";
    NSString *subject = NSLocalizedString(@"app_developer_email_contact", @"Email app developer contact email subject");
    
    NSString *mailString = [NSString stringWithFormat:@"mailto:?to=%@&subject=%@&body=%@", developerMail, subject, @""];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailString]];
    
    // If mail does not exist TOAST
}

// Developer email delegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"share_email_error", @"Email sharing error") delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"ok_message", @"OK message"), nil];
    UIAlertView *okAlert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"share_email_ok_message", @"Email sharing ok message") delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"ok_message", @"OK message"), nil];
    
	switch (result) {
		case MessageComposeResultCancelled:
			break;
		case MessageComposeResultFailed:
            [errorAlert show];
			break;
		case MessageComposeResultSent:
            [okAlert show];
			break;
		default:
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)toToDeveloperWeb:(id)sender {
    if (![self.app.appUrl isEqualToString:@""]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.app.appUrl]];
    }
    else {
        Toast *errorToast = [[Toast alloc] initAndShowIn:self.view withText:@"Developer website is not avaliable"];
        [errorToast show];
    }
}

- (IBAction)sendAsistency:(id)sender {
    self.scroll.scrollEnabled = NO;
    self.supportModalView.frame = self.scroll.bounds;
    [self.supportModalView addSubview:self.actionView];
    [self.supportModalView bringSubviewToFront:self.actionView];
    [self.view addSubview:self.supportModalView];
}

@end
