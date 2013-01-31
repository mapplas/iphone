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

@synthesize galleryScroll;

- (id)initWithApp:(App *)app {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.app = app;
        imagesArray = [[NSMutableDictionary alloc] init];
        downloadedImages = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self downloadGalleryImages];
    [self initLayout];
    [self configureGallery];
}

- (void)downloadGalleryImages {
    ImageLoaderFactory *factory = [[ImageLoaderFactory alloc] init];
    AsynchronousImageDownloader *downloader = [[AsynchronousImageDownloader alloc] initWithDelegate:self];
    imageLoader = [factory createUsingCacheFolderWithDownloader:downloader];
    
    for (Photo *currenPhoto in self.app.auxPhotosArray) {
        UIImage *currentImage = [imageLoader load:currenPhoto.photo withSaveName:[NSString stringWithFormat:@"%@.%d", self.app.appId, [currenPhoto.photoId intValue]]];
        [imagesArray setValue:currentImage forKey:[NSString stringWithFormat:@"%@.%d", self.app.appId, [currenPhoto.photoId intValue]]];
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

- (void)configureGallery {
    self.galleryScroll.clipsToBounds = NO;
	self.galleryScroll.pagingEnabled = YES;
    self.galleryScroll.showsHorizontalScrollIndicator = NO;
	
	CGFloat contentOffset = 0.0f;
    ImageResizer *resizer = [[ImageResizer alloc] initWithScroll:self.galleryScroll];
    
    NSArray *keys = [imagesArray allKeys];
    for (NSString *currentKey in keys) {
        
        if ([imagesArray objectForKey:currentKey] != nil) {
            CGRect imageViewFrame = CGRectMake(contentOffset, 0, self.galleryScroll.frame.size.width, self.galleryScroll.frame.size.height);
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
            
            imageView.image = [resizer resizeImage:[imagesArray objectForKey:currentKey]];
            imageView.contentMode = UIViewContentModeCenter;
            
            [self.galleryScroll addSubview:imageView];
            
            contentOffset += imageView.frame.size.width;
            self.galleryScroll.contentSize = CGSizeMake(contentOffset, self.galleryScroll.frame.size.height);
        }
    }
}

#pragma mark - AsynchronousImageDownloadedProtocol methods
- (void)imageDownloaded:(DownloadedImageSuccess *)download withSaveName:(NSString *)save_name {
    [imageLoader saveImageInCache:download.image path:save_name];

    if ([save_name isEqualToString:self.app.appId]) {
        [self.logo setImage:download.image];
    }
    else {
        downloadedImages++;
        NSArray *photoId = [save_name componentsSeparatedByString:@"."];
        [imagesArray setValue:download.image forKey:[photoId objectAtIndex:1]];
    }
    
    if (downloadedImages == [imagesArray allKeys].count) {
        [self configureGallery];
    }
}

- (void)imageNotDownloaded:(DownloadedImageError *)error withSaveName:(NSString *)save_name {
    downloadedImages++;
}

@end
