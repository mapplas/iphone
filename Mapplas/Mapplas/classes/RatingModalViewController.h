//
//  RatingModalViewController.h
//  Mapplas
//
//  Created by Belén  on 05/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingHelper.h"
#import "AppRateRequest.h"

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@interface RatingModalViewController : UIViewController <DYRateViewDelegate, UITextFieldDelegate> {
    NSNumber *actualRate;
    
    NSString *appId;
    NSString *userId;
    NSString *currentLocation;
    NSString *descriptiveGeoloc;
    
    CGFloat animatedDistance;
    AppRateRequest *rateRequester;
}

- (id)initWithAppId:(NSString *)app_id userId:(NSString *)user_id location:(NSString *)location andDescriptiveGeoLoc:(NSString *)descr_geoloc;

@property (nonatomic, strong) IBOutlet UILabel *rateItLabel;
@property (nonatomic, strong) IBOutlet UIView *ratingView;
@property (nonatomic, strong) IBOutlet UILabel *ratingLabel;

@property (nonatomic, strong) IBOutlet UITextField *titleField;
@property (nonatomic, strong) IBOutlet UITextField *commentField;

@end
