//
//  AppCell.h
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "App.h"
#import "User.h"
#import "ImageLoaderFactory.h"
#import "AsynchronousImageDownloader.h"
#import "AppPinRequest.h"
#import "AppBlockRequest.h"
#import "Constants.h"
#import "AppOrderedList.h"
#import "PriceImageLabelHelper.h"

#import "DYRateView.h"

#import "SharingHelper.h"
#import "RatingHelper.h"
#import "UIButton+Extensions.h"

@class AppsViewController;

@interface AppCell : UITableViewCell <AsynchronousImageDownloaderProtocol, UIGestureRecognizerDelegate> {
    UIView *cellPressed;
    UIView *cellUnpressed;
    
    App *_app;
    User *_user;
    NSString *_currentLocation;
    NSString *_currentDescriptiveGeoLoc;
    AppOrderedList *_modelList;
    NSMutableArray *_appsList;
    int _positionInList;
    AppsViewController *_viewController;
    ImageLoader *imageLoader;
    BOOL _pressed;
    
    AppPinRequest *pinRequester;
    AppBlockRequest *blockRequester;
    
    RatingHelper *rateHelper;
    SharingHelper *sharingHelper;
    AppShareRequest *appShareRequester;
}

@property (nonatomic, strong) IBOutlet UIView *cellContent;
@property (nonatomic, strong) IBOutlet UIView *cellPressed;
@property (nonatomic, strong) IBOutlet UIView *cellUnpressed;

@property (nonatomic, strong) IBOutlet UIImageView *imageLogo;
@property (nonatomic, strong) IBOutlet UIImageView *imageRoundView;
@property (nonatomic, strong) IBOutlet UILabel *appName;
@property (nonatomic, strong) IBOutlet UIButton *priceButton;
@property (nonatomic, strong) IBOutlet UILabel *description;

@property (nonatomic, strong) IBOutlet UIButton *pinPressedImage;
@property (nonatomic, strong) IBOutlet UIButton *ratePressedImage;
@property (nonatomic, strong) IBOutlet UIButton *blockPressedImage;
@property (nonatomic, strong) IBOutlet UIButton *sharePressedImage;

@property (nonatomic, strong) IBOutlet UILabel *pinPressedText;
@property (nonatomic, strong) IBOutlet UILabel *ratePressedText;
@property (nonatomic, strong) IBOutlet UILabel *blockPressedText;
@property (nonatomic, strong) IBOutlet UILabel *sharePressedText;

@property (nonatomic, strong) App *app;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *currentLocation;
@property (nonatomic, strong) NSString *currentDescriptiveGeoLoc;
@property (nonatomic, strong) AppOrderedList *modelList;
@property (nonatomic, strong) NSMutableArray *appsList;
@property (nonatomic) int positionInList;
@property (nonatomic, strong) AppsViewController *viewController;
@property (nonatomic) BOOL pressed;

- (void)loadData;
- (IBAction)animate:(id)sender;
- (void)resetState;

- (IBAction)pinUnpinApp:(id)sender;
- (IBAction)blockUnblockApp:(id)sender;
- (IBAction)shareApp:(id)sender;
- (IBAction)rateApp:(id)sender;
- (IBAction)launchApp:(id)sender;

@end
