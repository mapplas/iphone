//
//  AppDetailViewController.m
//  Mapplas
//
//  Created by Belén  on 29/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppDetailViewController.h"

@interface AppDetailViewController ()

- (void)initLayout;

@end

@implementation AppDetailViewController

@synthesize app = _app;

@synthesize logo;
@synthesize name;
@synthesize priceBackground;
@synthesize priceLabel;

@synthesize pinButton;
@synthesize pinLabel;
@synthesize rateButton;
@synthesize rateLabel;
@synthesize blockButton;
@synthesize blockLabel;
@synthesize shareButton;
@synthesize shareLabel;
@synthesize phoneButton;
@synthesize phoneLabel;

- (id)initWithApp:(App *)app {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.app = app;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initLayout];

}

- (void)initLayout {
    // Set app logo
    ImageLoaderFactory *factory = [[ImageLoaderFactory alloc] init];
    AsynchronousImageDownloader *downloader = [[AsynchronousImageDownloader alloc] initWithDelegate:self];
    imageLoader = [factory createUsingCacheFolderWithDownloader:downloader];
    
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

    // Action layout
    if ([self.app.auxPin isEqualToString:@"1"]) {
        self.pinButton.imageView.image = [UIImage imageNamed:@"ic_action_unpinup"];
        self.pinLabel.text = NSLocalizedString(@"un_pin_up", @"Pin unpin text");
    }
    else {
        self.pinLabel.text = NSLocalizedString(@"pin_sing_text", @"Pin singular text");
    }
    self.rateLabel.text = NSLocalizedString(@"rate_singular_text", @"Rate singular text");
    self.blockLabel.text = NSLocalizedString(@"block_text", @"Block text");
    self.shareLabel.text = NSLocalizedString(@"share_text", @"Share text");
    self.phoneLabel.text = NSLocalizedString(@"call_text", @"Detail screen call text");
}

#pragma mark - AsynchronousImageDownloadedProtocol methods

- (void)imageDownloaded:(DownloadedImageSuccess *)download {
    [self.logo setImage:download.image];
}

- (void)imageNotDownloaded:(DownloadedImageError *)error {}

@end
