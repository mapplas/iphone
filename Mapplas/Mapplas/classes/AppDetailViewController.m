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
@synthesize galleryView, galleryBackground, galleryScroll, pageControl;
@synthesize descriptionView, descriptionText, morebutton, moreBigButton;
@synthesize supportView, developerLabel, devWebButton, devEmailButton, asistencyButton;

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
    
    self.navigationController.navigationItem.backBarButtonItem.tintColor = [UIColor grayColor];
    
    NSMutableArray *viewsToAddToScroll = nil;
//    if (self.app.auxCommentsArray.count > 0) {
//        self.commentsViewController = [[AppDetailCommentsViewController alloc] initWithApp:self.app];
//        viewsToAddToScroll = [[NSMutableArray alloc] initWithObjects:self.topBar, self.actionBar, self.galleryView, self.descriptionView, self.commentsViewController, self.supportView, nil];
//    }
//    else {
        viewsToAddToScroll = [[NSMutableArray alloc] initWithObjects:self.topBar, self.actionBar, self.galleryView, self.descriptionView, self.supportView, nil];
//    }
    
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
    self.rateLabel.text = NSLocalizedString(@"rate_singular_text", @"Rate singular text");
    self.blockLabel.text = NSLocalizedString(@"block_text", @"Block text");
    self.shareLabel.text = NSLocalizedString(@"share_text", @"Share text");
    self.phoneLabel.text = NSLocalizedString(@"call_text", @"Detail screen call text");
    
    // Description
    [self showAppSmallDescription];
    
    // Support
    self.developerLabel.text = NSLocalizedString(@"app_detail_developer_label_text", @"App detail - developer text");
    self.devWebButton.titleLabel.text = NSLocalizedString(@"app_detail_developer_web_button", @"App detail - developer web");
    self.devEmailButton.titleLabel.text = NSLocalizedString(@"app_detail_developer_email_button", @"App detail - developer email");
    self.asistencyButton.titleLabel.text = NSLocalizedString(@"app_detail_developer_support_button", @"App detail - support button");
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
        self.pinLabel.text = NSLocalizedString(@"un_pin_up", @"Pin unpin text");
    }
    else {
        self.pinButton.selected = NO;
        self.pinLabel.text = NSLocalizedString(@"pin_sing_text", @"Pin singular text");
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
    
}

- (IBAction)call:(id)sender {
    
}

@end
