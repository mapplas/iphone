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
#import "ImageLoaderFactory.h"
#import "AsynchronousImageDownloader.h"
#import "AppPinRequest.h"
#import "AppBlockRequest.h"
#import "Constants.h"
#import "AppOrderedList.h"
#import "PriceImageLabelHelper.h"
#import "RatingHelper.h"
#import "DYRateView.h"

#import "SharingHelper.h"

@class AppsViewController;

@interface AppCell : UITableViewCell <AsynchronousImageDownloaderProtocol, UIGestureRecognizerDelegate> {
    UIView *cellPressed;
    UIView *cellUnpressed;
    
    App *_app;
    NSString *_userId;
    NSString *_currentLocation;
    AppOrderedList *_modelList;
    NSMutableArray *_appsList;
    int _positionInList;
    AppsViewController *_viewController;
    ImageLoader *imageLoader;
    BOOL _pressed;
    
    AppPinRequest *pinRequester;
    AppBlockRequest *blockRequester;
    
    SharingHelper *sharingHelper;
}

@property (nonatomic, strong) IBOutlet UIView *cellContent;
@property (nonatomic, strong) IBOutlet UIView *cellPressed;
@property (nonatomic, strong) IBOutlet UIView *cellUnpressed;

@property (nonatomic, strong) IBOutlet UIImageView *imageLogo;
@property (nonatomic, strong) IBOutlet UIImageView *imageRoundView;
@property (nonatomic, strong) IBOutlet UILabel *appName;
@property (nonatomic, strong) IBOutlet UIImageView *priceImage;
@property (nonatomic, strong) IBOutlet UILabel *appPrice;
@property (nonatomic, strong) IBOutlet UILabel *pinsUnpressedText;
@property (nonatomic, strong) IBOutlet UIView *ratingView;
@property (nonatomic, strong) IBOutlet UILabel *ratingLabel;

@property (nonatomic, strong) IBOutlet UIButton *pinPressedImage;
@property (nonatomic, strong) IBOutlet UILabel *pinPressedText;
@property (nonatomic, strong) IBOutlet UILabel *ratePressedText;
@property (nonatomic, strong) IBOutlet UILabel *blockPressedText;
@property (nonatomic, strong) IBOutlet UILabel *sharePressedText;

@property (nonatomic, strong) App *app;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *currentLocation;
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
- (IBAction)rateApp:(id)sender;

@end
