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
#import "Photo.h"
#import "User.h"
#import "SuperModel.h"

#import "ImageLoaderFactory.h"
#import "AsynchronousImageDownloader.h"
#import "PriceImageLabelHelper.h"
#import "ImageResizer.h"

#import "ScrollViewOfViews.h"

#import "AppDetailCommentsViewController.h"
#import "SCAppUtils.h"

#import "Constants.h"
#import "AppPinRequest.h"
#import "AppBlockRequest.h"
#import "AppActivityRequest.h"

#import "RatingHelper.h"
#import "RatingModalViewController.h"

#import "SharingHelper.h"

@interface AppDetailViewController : UIViewController <AsynchronousImageDownloaderProtocol, UIScrollViewDelegate, MFMailComposeViewControllerDelegate> {
    App *_app;
    User *_user;
    NSString *_current_location;
    SuperModel *_model;
    
    ImageLoader *imageLoader;
    NSMutableDictionary *imagesArray;
    NSUInteger downloadedImages;
    
    ScrollViewOfViews *scrollViewConfigurator;
    
    BOOL descriptionOpened;
    
    BOOL somethingChangedOnApp;
    AppPinRequest *pinRequest;
    AppBlockRequest *blockRequest;
    AppActivityRequest *activityRequest;
    
    SharingHelper *sharingHelper;
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
@property (nonatomic, strong) IBOutlet UIImageView *priceBackground;
@property (nonatomic, strong) IBOutlet UILabel *priceLabel;
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
@property (nonatomic, strong) IBOutlet UIButton *phoneButton;
@property (nonatomic, strong) IBOutlet UILabel *phoneLabel;

@property (nonatomic, strong) IBOutlet UIView *actionBarWithoutTeleph;
@property (nonatomic, strong) IBOutlet UIButton *pinWithoutPhoneButton;
@property (nonatomic, strong) IBOutlet UILabel *pinWithoutPhoneLabel;
@property (nonatomic, strong) IBOutlet UILabel *rateWithoutPhoneLabel;
@property (nonatomic, strong) IBOutlet UILabel *blockWithoutPhoneLabel;
@property (nonatomic, strong) IBOutlet UILabel *shareWithoutPhoneLabel;

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

@property (nonatomic, strong) IBOutlet UIView *supportModalView;
@property (nonatomic, strong) IBOutlet UIView *actionView;

- (IBAction)pinUp:(id)sender;
- (IBAction)block:(id)sender;
- (IBAction)rate:(id)sender;
- (IBAction)share:(id)sender;
- (IBAction)call:(id)sender;

- (IBAction)toToDeveloperWeb:(id)sender;
- (IBAction)toDeveloperMail:(id)sender;
- (IBAction)sendAsistency:(id)sender;

@end
