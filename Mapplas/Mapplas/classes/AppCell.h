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

@interface AppCell : UITableViewCell <AsynchronousImageDownloaderProtocol, UIGestureRecognizerDelegate> {
    UIView *cellPressed;
    UIView *cellUnpressed;
    
    App *_app;
    ImageLoader *imageLoader;
    BOOL _pressed;
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

@property (nonatomic, strong) IBOutlet UIImageView *pinPressedImage;
@property (nonatomic, strong) IBOutlet UILabel *pinPressedText;
@property (nonatomic, strong) IBOutlet UILabel *ratePressedText;
@property (nonatomic, strong) IBOutlet UILabel *blockPressedText;
@property (nonatomic, strong) IBOutlet UILabel *sharePressedText;

@property (nonatomic, strong) App *app;
@property (nonatomic) BOOL pressed;

- (void)loadData;
- (IBAction)animate:(id)sender;
- (void)resetState;

@end
