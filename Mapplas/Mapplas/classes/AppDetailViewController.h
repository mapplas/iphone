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
#import "User.h"

#import "ImageLoaderFactory.h"
#import "AsynchronousImageDownloader.h"
#import "PriceImageLabelHelper.h"
#import "ImageResizer.h"

#import "ScrollViewOfViews.h"

#import "AppDetailCommentsViewController.h"

#import "AppPinRequest.h"
#import "Constants.h"

@interface AppDetailViewController : UIViewController <AsynchronousImageDownloaderProtocol, UIScrollViewDelegate> {
    App *_app;
    User *_user;
    NSString *_current_location;
    
    ImageLoader *imageLoader;
    NSMutableDictionary *imagesArray;
    NSUInteger downloadedImages;
    
    ScrollViewOfViews *scrollViewConfigurator;
    
    BOOL descriptionOpened;
    
    AppPinRequest *pinRequest;
    
//    AppDetailCommentsViewController *_commentsViewController;
}

- (id)initWithApp:(App *)app user:(User *)user andLocation:(NSString *)current_location;

@property (nonatomic, strong) App *app;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *currentLocation;

//@property (nonatomic, strong) AppDetailCommentsViewController *commentsViewController;

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
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) IBOutlet UIView *descriptionView;
@property (nonatomic, strong) IBOutlet UILabel *descriptionText;
@property (nonatomic, strong) IBOutlet UIButton *morebutton;
@property (nonatomic, strong) IBOutlet UIButton *moreBigButton;

@property (nonatomic, strong) IBOutlet UIView *supportView;
@property (nonatomic, strong) IBOutlet UILabel *developerLabel;
@property (nonatomic, strong) IBOutlet UIButton *devWebButton;
@property (nonatomic, strong) IBOutlet UIButton *devEmailButton;
@property (nonatomic, strong) IBOutlet UIButton *asistencyButton;

@end
