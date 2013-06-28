//
//  AppDetailViewController.m
//  Mapplas
//
//  Created by Belén  on 29/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppDetailViewController.h"
#import "AppDetailRequester.h"
#import "UIButton+Extensions.h"

@interface AppDetailViewController ()
- (void)downloadGalleryImages;
- (void)initLayout;
- (void)configureGallery;
- (void)showAppSmallDescription;
- (void)showAppCompleteDescription;
- (void)adjustLabel:(CGSize)max_label_size;
- (void)initPinActionLayout;
- (void)toDeveloperWeb:(NSString *)url;
@end

@implementation AppDetailViewController

@synthesize app = _app, user = _user, currentLocation = _current_location, model = _model;

//@synthesize commentsViewController = _commentsViewController;

@synthesize scroll;

@synthesize topBar, logo, name, priceButton, ratingView, ratingViewButton;
@synthesize actionBar, pinButton, pinLabel, rateButton, rateLabel, blockButton, blockLabel, shareButton, shareLabel;
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
    
    NavigationControllerStyler *styler = [[NavigationControllerStyler alloc] init];
    [styler style:self.navigationController.navigationBar andItem:self.navigationItem];
    NSDictionary *dict = [styler styleNavBarButtonToBlue:YES];
    [[UIBarButtonItem appearance] setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    NSMutableArray *viewsToAddToScroll = nil;
    viewsToAddToScroll = [[NSMutableArray alloc] initWithObjects:self.topBar, self.actionBar, nil];

    scrollViewConfigurator = [[MutableScrollViewOfViews alloc] initWithViews:viewsToAddToScroll inScrollView:self.scroll delegate:self];
    
    ImageLoaderFactory *factory = [[ImageLoaderFactory alloc] init];
    AsynchronousImageDownloader *downloader = [[AsynchronousImageDownloader alloc] initWithDelegate:self];
    imageLoader = [factory createUsingCacheFolderWithDownloader:downloader];
    
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
    
    NSUInteger numberOfImages = self.app.auxPhotosArray.count;
    NSUInteger numberOfDownloadedImages = 0;
    NSEnumerator *keys = imagesArray.keyEnumerator;
    
    for (NSString *key in keys) {
        if ([imagesArray objectForKey:key] != [NSString class]) {
            numberOfDownloadedImages++;
        }
    }
    
    if (numberOfImages == numberOfDownloadedImages) {
        [self configureGallery];
        
        [scrollViewConfigurator addView:self.galleryView];
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
    [self.priceButton setTitle:[priceHelper getPriceText] forState:UIControlStateNormal];
    [self.priceButton setBackgroundImage:[priceHelper getImage] forState:UIControlStateNormal];
    [self.priceButton setBackgroundImage:[priceHelper getHighlightedImages] forState:UIControlStateHighlighted];

    // Action layout
    [self initPinActionLayout];
    
    self.rateLabel.text = NSLocalizedString(@"rate_singular_text", @"Rate singular text");
    self.blockLabel.text = NSLocalizedString(@"block_text", @"Block text");
    self.shareLabel.text = NSLocalizedString(@"share_text", @"Share text");
    
    // Set buttons hit area biggerç// Hit area bigger
    [self.pinButton setHitTestEdgeInsets:UIEdgeInsetsMake(-self.pinButton.frame.origin.y, -self.pinButton.frame.origin.x, -(self.actionBar.frame.size.height - self.pinButton.frame.size.height - self.pinButton.frame.origin.y), -24)];
    [self.rateButton setHitTestEdgeInsets:UIEdgeInsetsMake(-self.rateButton.frame.origin.y, -24, -(self.actionBar.frame.size.height - self.rateButton.frame.size.height - self.rateButton.frame.origin.y), -24)];
    [self.blockButton setHitTestEdgeInsets:UIEdgeInsetsMake(-self.blockButton.frame.origin.y, -24, -(self.actionBar.frame.size.height - self.blockButton.frame.size.height - self.blockButton.frame.origin.y), -24)];
    [self.shareButton setHitTestEdgeInsets:UIEdgeInsetsMake(-self.shareButton.frame.origin.y, -24, -(self.actionBar.frame.size.height - self.shareButton.frame.size.height - self.shareButton.frame.origin.y), -(self.actionBar.frame.size.width - self.shareButton.frame.size.width - self.shareButton.frame.origin.x))];
}

- (void)configureGallery {
    CGFloat offsetMargin = 50.0f;
	CGFloat contentOffset = offsetMargin;
    
    ImageResizer *resizer = [[ImageResizer alloc] init];
    
    NSArray *keys = [imagesArray allKeys];
    
    self.galleryScroll.clipsToBounds = NO;
	self.galleryScroll.pagingEnabled = YES;
    self.galleryScroll.showsHorizontalScrollIndicator = NO;
    self.galleryScroll.delegate = self;
    
    self.pageControl.numberOfPages = keys.count;
    self.pageControl.currentPage = 0;
        
    if (keys.count > 0) {
        for (NSString *currentKey in keys) {
            UIImage *currentImage = [imagesArray objectForKey:currentKey];
            
            if (currentImage != nil && ![currentImage isKindOfClass:[NSString class]]) {
                UIImageView *imageView = [resizer getImageViewForImage:currentImage contentOffset:contentOffset scroll:self.galleryScroll andMargin:offsetMargin];
                
                if (currentImage.size.height < currentImage.size.width) {
                    currentImage = [currentImage imageRotatedByDegrees:270.0];
                }
                
                imageView.image = [resizer resizeImage:currentImage];
                
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                
                [self.galleryScroll addSubview:imageView];
            
                contentOffset = contentOffset + imageView.frame.size.width + (2 * offsetMargin);
            }
        }
        self.galleryScroll.contentSize = CGSizeMake(contentOffset, self.galleryScroll.frame.size.height);
    } else {
        [scrollViewConfigurator removeView:self.galleryView];
    }
}

- (void)showAppSmallDescription {
    CGSize maximumLabelSize = CGSizeMake(self.descriptionText.frame.size.width, 110);
    [self adjustLabel:maximumLabelSize];
    
    // If description fits minimum size, hide 'more description' button.
    // Dummy check
    CGSize maximumLabelSizeDummy = CGSizeMake(self.descriptionText.frame.size.width, FLT_MAX);
    CGSize expectedLabelSizeDummy = [self.app.appDescription sizeWithFont:self.descriptionText.font
                                                   constrainedToSize:maximumLabelSizeDummy
                                                       lineBreakMode:self.descriptionText.lineBreakMode];
    
    UILabel *descriptionTextDummy = [[UILabel alloc] initWithFrame:CGRectMake(10, 24, 302, 20)];
    descriptionTextDummy.numberOfLines = 0;
    CGRect newFrameDummy = descriptionTextDummy.frame;
    newFrameDummy.size.height = expectedLabelSizeDummy.height;
    descriptionTextDummy.frame = newFrameDummy;
    CGRect viewFrameDummy = CGRectMake(descriptionTextDummy.frame.origin.x, descriptionTextDummy.frame.origin.y, descriptionTextDummy.frame.size.width, descriptionTextDummy.frame.size.height + 30);
    UIView *descriptionViewDummy = [[UIView alloc] init];
    descriptionViewDummy.frame = viewFrameDummy;
    
    descriptionTextDummy.text = self.app.appDescription;
    
    if (descriptionTextDummy.frame.size.height <= maximumLabelSize.height) {
        self.morebutton.hidden = YES;
    }
    else {
        self.morebutton.hidden = NO;
    }
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
        self.morebutton.hidden = YES;
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
        
        [scrollViewConfigurator emptyFromPosition:2];
        [scrollViewConfigurator addView:self.galleryView];
        
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
        self.pinLabel.text = NSLocalizedString(@"un_pin_up", @"Pin unpin text");
    }
    else {
        self.pinButton.selected = NO;
        self.pinLabel.text = NSLocalizedString(@"pin_sing_text", @"Pin singular text");
    }
}

- (IBAction)block:(id)sender {
//    self.app.auxBlocked = @"1";
    somethingChangedOnApp = YES;
    
    [self.model.appList deleteApp:self.app];
  
    blockRequest = [[AppBlockRequest alloc] init];
    [blockRequest doRequestWithAppId:self.app.appId userId:self.user.userId action:ACTION_LIKE_REQUEST_BLOCK];
    
    pinRequest = [[AppPinRequest alloc] init];
    [pinRequest doRequestWithAppId:self.app.appId userId:self.user.userId action:ACTION_PIN_REQUEST_UNPIN andLocation:self.currentLocation];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)rate:(id)sender {
    rateHelper = [[RatingHelper alloc] init];
    [rateHelper rateApp:self.app];
}

- (IBAction)share:(id)sender {
    sharingHelper = [[SharingHelper alloc] initWithApp:self.app navigationController:self.navigationController user:self.user andLocation:self.currentLocation];
    
    // If device has ios6 and up
	if ([UIActivityViewController class]) {
        NSString *text = [sharingHelper getShareMessage];
        
        NSArray *activityItems = @[text];
        UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
        
		activityController.excludedActivityTypes = @[UIActivityTypePostToWeibo, UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePrint, UIActivityTypeSaveToCameraRoll];
        
        activityController.completionHandler = ^(NSString *activityType, BOOL completed){
            if (completed) {
                [sharingHelper shareType:activityType];
            }
        };
        
        NavigationControllerStyler *styler = [[NavigationControllerStyler alloc] init];
        NSDictionary *dict = [styler styleNavBarButtonToBlue:NO];
        [[UIBarButtonItem appearance] setTitleTextAttributes:dict forState:UIControlStateNormal];
        
		[self presentViewController:activityController animated:YES completion:nil];
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

#pragma mark - Developer support email and web
- (void)toDeveloperMail {
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    [controller setMailComposeDelegate:self];
    
    NSString *mail = self.app.appSupportUrl;
    
    if ([self NSStringIsValidEmail:mail]) {
        [controller setToRecipients:[NSArray arrayWithObject:mail]];
        NSString *subject = NSLocalizedString(@"app_developer_email_contact", @"Email app developer contact email subject");
        [controller setSubject:subject];
        
        [self presentModalViewController:controller animated:YES];
    }
    else {
        [self toDeveloperWeb:mail];
    }
}

-(BOOL)NSStringIsValidEmail:(NSString *)checkString {
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
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

- (void)toDeveloperWeb:(NSString *)url {
    if (![url isEqualToString:@""]) {
        WebViewViewController *webViewViewController = [[WebViewViewController alloc] initWithUrl:url];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:webViewViewController];
        [self presentModalViewController:navController animated:YES];
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
                cell.textLabel.text = NSLocalizedString(@"app_detail_developer_email_button", @"App detail - app support");
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
        [self toDeveloperWeb:self.app.appUrl];
    }
    else {
        // Developer mail link
        [self toDeveloperMail];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)launchApp:(id)sender {
    NSString *url = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", self.app.appId];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

@end
