//
//  AppDetailViewController.m
//  Mapplas
//
//  Created by Belén  on 29/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppDetailViewController.h"
#import "AppDetailRequester.h"

@interface AppDetailViewController ()
- (void)downloadGalleryImages;
- (void)initLayout;
- (void)configureGallery;
- (void)showAppSmallDescription;
- (void)showAppCompleteDescription;
- (void)adjustLabel:(CGSize)max_label_size;
- (void)initPinActionLayout;
- (void)toDeveloperWeb;
- (void)galleryFullscreen;
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
@synthesize developerTable;

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
    
    appDetailRequester = [[AppDetailRequester alloc] init];
    [appDetailRequester doRequestWithApp:self.app andViewController:self];
    
    // Telephone icon or not
    UIView *whatActionBar = self.actionBar;
    if ([self.app.phone isEqualToString:@""]) {
        whatActionBar = self.actionBarWithoutTeleph;
    }
    
    NSMutableArray *viewsToAddToScroll = nil;
    viewsToAddToScroll = [[NSMutableArray alloc] initWithObjects:self.topBar, whatActionBar, nil];

    scrollViewConfigurator = [[MutableScrollViewOfViews alloc] initWithViews:viewsToAddToScroll inScrollView:self.scroll delegate:self];
    
    [self initLayout];
    
    [scrollViewConfigurator organize];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (somethingChangedOnApp) {
        [[Environment sharedInstance] setAppSomethingChangedInDetail:somethingChangedOnApp];
        somethingChangedOnApp = NO;
    }
}

- (void)detailDataLoaded {
    // Gallery
    if ([self.app.auxPhotosArray count] > 0) {
        [self downloadGalleryImages];
        [self configureGallery];
        
        [scrollViewConfigurator addView:self.galleryView];
    }
    
    // Description
    if (![self.app.description isEqualToString:@""]) {
        [self showAppSmallDescription];
        [scrollViewConfigurator addView:self.descriptionView];
    }
    
    if (![self.app.appUrl isEqualToString:@""]) {
        [scrollViewConfigurator addView:self.developerTable];
    }
    
    [scrollViewConfigurator organize];
}

- (void)downloadGalleryImages {
    ImageLoaderFactory *factory = [[ImageLoaderFactory alloc] init];
    AsynchronousImageDownloader *downloader = [[AsynchronousImageDownloader alloc] initWithDelegate:self];
    imageLoader = [factory createUsingCacheFolderWithDownloader:downloader];
    
    int i = 0;
    for (NSString *currenPhoto in self.app.auxPhotosArray) {
        UIImage *currentImage = [imageLoader load:currenPhoto withSaveName:[NSString stringWithFormat:@"%@.%d", self.app.appId, i]];
        if (currentImage == nil) {
            [imagesArray setValue:@"" forKey:[NSString stringWithFormat:@"%@.%d", self.app.appId, i]];
        }
        else {
            [imagesArray setValue:currentImage forKey:[NSString stringWithFormat:@"%@.%d", self.app.appId, i]];
        }
        i++;
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
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(galleryFullscreen)];
        [galleryScroll addGestureRecognizer:tapGestureRecognizer];
    }
    else {
        [scrollViewConfigurator removeView:self.galleryView];
    }
}

- (void)galleryFullscreen {    
    UIViewController *galleryVC = [[ImageGalleryViewController alloc] initWithImagesArray:imagesArray];    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:galleryVC];
    [SCAppUtils customizeNavigationController:navController];
    
    [self presentModalViewController:navController animated:YES];
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
    NSString *pinRequestConstant = @"";
    NSString *activityRequestConstant = @"";
    
    if ([self.app.auxPin intValue] == 1) {
        pinRequestConstant = ACTION_PIN_REQUEST_UNPIN;
        activityRequestConstant = ACTION_ACTIVITY_UNPIN;
        self.app.auxPin = [NSNumber numberWithInt:0];
        self.app.auxTotalPins = [NSNumber numberWithInt:[self.app.auxTotalPins intValue] - 1];
    }
    else {
        pinRequestConstant = ACTION_PIN_REQUEST_PIN;
        activityRequestConstant = ACTION_ACTIVITY_PIN;
        self.app.auxPin = [NSNumber numberWithInt:1];
        self.app.auxTotalPins = [NSNumber numberWithInt:[self.app.auxTotalPins intValue] + 1];
    }
    
    somethingChangedOnApp = YES;
    
    // Pin/unpin request
    pinRequest = [[AppPinRequest alloc] init];
    [pinRequest doRequestWithAppId:self.app.appId userId:self.user.userId action:pinRequestConstant andLocation:self.currentLocation];
    
    [self initPinActionLayout];
}

- (void)initPinActionLayout {
    if ([self.app.auxPin intValue] == 1) {
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
    // TODO: sent user to appstore rating to current app
}

- (IBAction)share:(id)sender {
    sharingHelper = [[SharingHelper alloc] initWithApp:self.app navigationController:self.navigationController user:self.user andLocation:self.currentLocation];
    
    // If device has ios6 and up
	if ([UIActivityViewController class]) {
		NSMutableArray *itemsToShare = [[NSMutableArray alloc] initWithObjects:[sharingHelper getShareMessage], nil];

		UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
		activityViewController.excludedActivityTypes = @[UIActivityTypePostToWeibo, UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePrint, UIActivityTypeSaveToCameraRoll];
        
        activityViewController.completionHandler = ^(NSString *activityType, BOOL completed){
            if (completed) {
                [sharingHelper shareType:activityType];
            }
        };
        
		[self presentViewController:activityViewController animated:YES completion:nil];
	}
	else {
        // iOS 5
		NSString *cancelButton = NSLocalizedString(@"ios5_sharing_action_sheet_cancel_button", @"iOS5 sharing action sheet cancel button - twitter sharing");
		NSString *twitterButton = NSLocalizedString(@"ios5_sharing_action_sheet_twitter_button", @"iOS5 sharing action sheet twitter button - twitter sharing");
        NSString *smsButton = NSLocalizedString(@"ios5_sharing_action_sheet_sms_button", @"iOS5 sharing action sheet sms button - sms sharing");
        NSString *emailButton = NSLocalizedString(@"ios5_sharing_action_sheet_email_button", @"iOS5 sharing action sheet email button - email sharing");
        
		UIActionSheet *alertView = [[UIActionSheet alloc] initWithTitle:nil delegate:sharingHelper cancelButtonTitle:cancelButton destructiveButtonTitle:nil otherButtonTitles:twitterButton, smsButton, emailButton, nil];
		[alertView showInView:self.view];
	}
}

- (IBAction)call:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", self.app.phone]]];
}

- (void)toDeveloperMail {
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    [controller setMailComposeDelegate:self];
    
    NSString *mail = self.app.appSupportUrl;
    [controller setToRecipients:[NSArray arrayWithObject:mail]];
    NSString *subject = NSLocalizedString(@"app_developer_email_contact", @"Email app developer contact email subject");
    [controller setSubject:subject];
    
    [self presentModalViewController:controller animated:YES];
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

- (void)toDeveloperWeb {
    if (![self.app.appUrl isEqualToString:@""]) {
        WebViewViewController *webViewViewController = [[WebViewViewController alloc] initWithApp:self.app];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:webViewViewController];
        [SCAppUtils customizeNavigationController:navController];
        
        [self presentModalViewController:navController animated:YES];
        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.app.appUrl]];
    }
    else {
        Toast *errorToast = [[Toast alloc] initAndShowIn:self.view withText:@"Developer website is not avaliable"];
        [errorToast show];
    }
}

#pragma mark - UITableViewDataSource and UITableViewDelegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;

    if (![self.app.appUrl isEqualToString:@""]) {
        rows++;
    }
    
    if (![self.app.appSupportUrl isEqualToString:@""]) {
        rows++;
    }
    
    if (rows == 0) {
        [scrollViewConfigurator removeView:self.developerTable];
    }
    else {
        NSUInteger tableHeight = rows * groupedCellHeight;
        NSUInteger headerHeight = 10;
        NSUInteger margin = 50;
        
        CGRect listFrame = CGRectMake(self.developerTable.frame.origin.x, self.developerTable.frame.origin.y, self.developerTable.frame.size.width, tableHeight + headerHeight + margin);
        self.developerTable.frame = listFrame;
    }
    [scrollViewConfigurator organize];

    return rows;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *customTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 0, 300, 44)];
    titleLabel.text = NSLocalizedString(@"app_detail_developer_label_text", @"App detail - developer text");
    titleLabel.textColor = [UIColor colorWithRed:33.f/255.f green:33.f/255.f blue:33.f/255.f alpha:1];
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    titleLabel.backgroundColor = [UIColor clearColor];
    
    [customTitleView addSubview:titleLabel];
    
    return customTitleView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *groupedTableIdentifier = @"GroupedCellItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:groupedTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:groupedTableIdentifier];
    }
        
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    switch (indexPath.row) {
        case 0:
            if (![self.app.appUrl isEqualToString:@""]) {
                cell.textLabel.text = NSLocalizedString(@"app_detail_developer_web_button", @"App detail - developer web");
            }
            else if (![self.app.appSupportUrl isEqualToString:@""]) {
                cell.textLabel.text = NSLocalizedString(@"app_detail_developer_email_button", @"App detail - developer email");
            }
            break;
        
        case 1:
            cell.textLabel.text = NSLocalizedString(@"app_detail_developer_email_button", @"App detail - developer email");
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return groupedCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && ![self.app.appUrl isEqualToString:@""]) {
        // Developer web link
        [self toDeveloperWeb];
    }
    else {
        // Developer mail link
        [self toDeveloperMail];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
