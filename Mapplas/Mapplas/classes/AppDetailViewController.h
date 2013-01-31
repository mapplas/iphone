//
//  AppDetailViewController.h
//  Mapplas
//
//  Created by Belén  on 29/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App.h"
#import "Photo.h"

#import "ImageLoaderFactory.h"
#import "AsynchronousImageDownloader.h"
#import "PriceImageLabelHelper.h"
#import "ImageResizer.h"

@interface AppDetailViewController : UIViewController <AsynchronousImageDownloaderProtocol> {
    App *_app;
    
    ImageLoader *imageLoader;
    NSMutableDictionary *imagesArray;
    NSUInteger downloadedImages;
}

- (id)initWithApp:(App *)app;

@property (nonatomic, strong) App *app;

@property (nonatomic, strong) IBOutlet UIImageView *logo;
@property (nonatomic, strong) IBOutlet UILabel *name;
@property (nonatomic, strong) IBOutlet UIImageView *priceBackground;
@property (nonatomic, strong) IBOutlet UILabel *priceLabel;

@property (nonatomic, strong) IBOutlet UIButton *pinButton;
@property (nonatomic, strong) IBOutlet UILabel *pinLabel;
@property (nonatomic, strong) IBOutlet UIButton *rateButton;
@property (nonatomic, strong) IBOutlet UILabel *rateLabel;
@property (nonatomic, strong) IBOutlet UIButton *blockButton;
@property (nonatomic, strong) IBOutlet UILabel *blockLabel;
@property (nonatomic, strong) IBOutlet UIButton *shareButton;
@property (nonatomic, strong) IBOutlet UILabel *shareLabel;
@property (nonatomic, strong) IBOutlet UIButton *phoneButton;
@property (nonatomic, strong) IBOutlet UILabel *phoneLabel;

@property (nonatomic, strong) IBOutlet UIScrollView *galleryScroll;

@end
