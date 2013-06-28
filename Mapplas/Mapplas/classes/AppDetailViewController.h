//
//  AppDetailViewController.h
//  Mapplas
//
//  Created by Belén  on 29/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import "App.h"
#import "User.h"
#import "SuperModel.h"

#import "ImageLoaderFactory.h"
#import "AsynchronousImageDownloader.h"
#import "PriceImageLabelHelper.h"
#import "ImageResizer.h"

#import "MutableScrollViewOfViews.h"

#import "NavigationControllerStyler.h"

#import "Constants.h"
#import "AppPinRequest.h"
#import "AppBlockRequest.h"

#import "RatingHelper.h"
#import "SharingHelper.h"
#import "WebViewViewController.h"
#import "UIImage+Extensions.h"

#define groupedCellHeight 44;

@class AppDetailRequester;

@interface AppDetailViewController : UIViewController <AsynchronousImageDownloaderProtocol, UIScrollViewDelegate, MFMailComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate> {
    App *_app;
    User *_user;
    NSString *_current_location;
    SuperModel *_model;
    
    ImageLoader *imageLoader;
    NSMutableDictionary *imagesArray;
    NSUInteger downloadedImages;
    
    MutableScrollViewOfViews *scrollViewConfigurator;
    
    BOOL descriptionOpened;
    
    BOOL somethingChangedOnApp;
    AppPinRequest *pinRequest;
    AppBlockRequest *blockRequest;
    
    SharingHelper *sharingHelper;
    RatingHelper *rateHelper;
    AppShareRequest *appShareRequester;
    AppDetailRequester *appDetailRequester;
}

- (id)initWithApp:(App *)app user:(User *)user model:(SuperModel *)super_model andLocation:(NSString *)current_location;

@property (nonatomic, strong) App *app;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *currentLocation;
@property (nonatomic, strong) SuperModel *model;

//@property (nonatomic, strong) AppDetailCommentsViewController *commentsViewController;

@property (nonatomic, strong) IBOutlet UIScrollView *scroll;

@property (nonatomic, strong) IBOutlet UIView *topBar;
@property (nonatomic, strong) IBOutlet UIImageView *logo;
@property (nonatomic, strong) IBOutlet UILabel *name;
@property (nonatomic, strong) IBOutlet UIButton *priceButton;
@property (nonatomic, strong) IBOutlet UIView *ratingView;
@property (nonatomic, strong) IBOutlet UIButton *ratingViewButton;

@property (nonatomic, strong) IBOutlet UIView *actionBar;
@property (nonatomic, strong) IBOutlet UIButton *pinButton;
@property (nonatomic, strong) IBOutlet UILabel *pinLabel;
@property (nonatomic, strong) IBOutlet UIButton *rateButton;
@property (nonatomic, strong) IBOutlet UILabel *rateLabel;
@property (nonatomic, strong) IBOutlet UIButton *blockButton;
@property (nonatomic, strong) IBOutlet UILabel *blockLabel;
@property (nonatomic, strong) IBOutlet UIButton *shareButton;
@property (nonatomic, strong) IBOutlet UILabel *shareLabel;

@property (nonatomic, strong) IBOutlet UIView *galleryView;
@property (nonatomic, strong) IBOutlet UIView *galleryBackground;
@property (nonatomic, strong) IBOutlet UIScrollView *galleryScroll;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) IBOutlet UIView *descriptionView;
@property (nonatomic, strong) IBOutlet UILabel *descriptionText;
@property (nonatomic, strong) IBOutlet UIButton *morebutton;
@property (nonatomic, strong) IBOutlet UIButton *moreBigButton;

@property (nonatomic, strong) IBOutlet UITableView *developerTable;

- (IBAction)pinUp:(id)sender;
- (IBAction)block:(id)sender;
- (IBAction)rate:(id)sender;
- (IBAction)share:(id)sender;

- (IBAction)launchApp:(id)sender;

- (void)detailDataLoaded;

@end
