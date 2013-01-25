//
//  AppCell.m
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppCell.h"

@implementation AppCell

@synthesize cellPressed;
@synthesize cellUnpressed;
@synthesize cellContent;

@synthesize imageLogo = _imageLogo;
@synthesize imageRoundView = _imageRoundView;
@synthesize app = _app;
@synthesize pressed = _pressed;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.pressed = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadData {
    self.appName.text = self.app.name;
    self.appPrice.text = self.app.appPrice;
    
    // Set app logo
    ImageLoaderFactory *factory = [[ImageLoaderFactory alloc] init];
    AsynchronousImageDownloader *downloader = [[AsynchronousImageDownloader alloc] initWithDelegate:self];
    imageLoader = [factory createUsingCacheFolderWithDownloader:downloader];
    
    UIImage *image = [imageLoader load:self.app.appLogo withSaveName:self.app.appId];
    if (image != nil) {
        [self.imageLogo setImage:image];
    }
    
    // Set image round view
    if (self.app.auxPin == [NSNumber numberWithInt:1]) {
        [self.imageRoundView setImage:[UIImage imageNamed:@"img_roundc_pinup.png"]];
    }
    else {
        [self.imageRoundView setImage:[UIImage imageNamed:@"img_roundc_btn.png"]];
    }

    [self.cellContent addSubview:self.cellUnpressed];
}

- (void)imageDownloaded:(DownloadedImageSuccess *)download {
    UIImage *downloadedImage = download.image;
    if (downloadedImage != nil) {
        [self.imageLogo setImage:downloadedImage];
        [imageLoader saveImageInCache:downloadedImage path:self.app.appId];
    }
}

- (void)imageNotDownloaded:(DownloadedImageError *)error {}

- (IBAction)animate:(id)sender {
    CATransition *pushTransition = [CATransition animation];
    pushTransition.type = kCATransitionPush;
    
    if (self.pressed) {
        self.pressed = NO;
        pushTransition.subtype = kCATransitionFromRight;
        [self.cellContent.layer addAnimation:pushTransition forKey:@""];
        [self.cellContent addSubview:self.cellUnpressed];
        [self.cellPressed removeFromSuperview];
    }
    else {
        self.pressed = YES;
        pushTransition.subtype = kCATransitionFromLeft;
        [self.cellContent.layer addAnimation:pushTransition forKey:@""];
        [self.cellContent addSubview:self.cellPressed];
        [self.cellUnpressed removeFromSuperview];
    }
    
}

@end
