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

#import "ScrollViewOfViews.h"

@interface AppDetailViewController : UIViewController <AsynchronousImageDownloaderProtocol> {
    App *_app;
    
    ImageLoader *imageLoader;
    NSMutableDictionary *imagesArray;
    NSUInteger downloadedImages;
    
    ScrollViewOfViews *scrollViewConfigurator;
}

- (id)initWithApp:(App *)app;

@property (nonatomic, strong) App *app;

@property (nonatomic, strong) IBOutlet UIScrollView *scroll;

@property (nonatomic, strong) IBOutlet UIView *topBar;
@property (nonatomic, strong) IBOutlet UIImageView *logo;
@property (nonatomic, strong) IBOutlet UILabel *name;
@property (nonatomic, strong) IBOutlet UIImageView *priceBackground;
@property (nonatomic, strong) IBOutlet UILabel *priceLabel;

@property (nonatomic, strong) IBOutlet UIView *actionBar;
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

@property (nonatomic, strong) IBOutlet UIView *galleryView;
@property (nonatomic, strong) IBOutlet UIView *galleryBackground;
@property (nonatomic, strong) IBOutlet UIScrollView *galleryScroll;

@property (nonatomic, strong) IBOutlet UIView *descriptionView;
@property (nonatomic, strong) IBOutlet UILabel *descriptionText;
@property (nonatomic, strong) IBOutlet UIButton *morebutton;

@property (nonatomic, strong) IBOutlet UIView *supportView;
@property (nonatomic, strong) IBOutlet UILabel *developerLabel;
@property (nonatomic, strong) IBOutlet UIButton *devWebButton;
@property (nonatomic, strong) IBOutlet UIButton *devEmailButton;
@property (nonatomic, strong) IBOutlet UIButton *asistencyButton;

@end
