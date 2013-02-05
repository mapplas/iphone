//
//  AppCell.m
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppCell.h"
#import "AppsViewController.h"

@implementation AppCell

@synthesize cellPressed, cellUnpressed, cellContent;
@synthesize imageLogo, imageRoundView, appName, appPrice, pinsUnpressedText, ratingView, ratingLabel;
@synthesize pinPressedImage, pinPressedText, ratePressedText, blockPressedText, sharePressedText;
@synthesize priceImage;

@synthesize app = _app, userId = _userId, currentLocation = _currentLocation, modelList = _modelList, appsList = _appsList, positionInList = _positionInList, viewController = _viewController, pressed = _pressed;

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

- (void)resetState {
    self.pressed = NO;
    [self.cellContent addSubview:self.cellUnpressed];
    [self.cellPressed removeFromSuperview];
}

- (void)loadData {
    [self loadUnpressedCellData];
    [self loadPressedCellData];
}

- (void)loadUnpressedCellData {
    // Unpressed data
    self.appName.text = self.app.name;
    
    // Unpressed data - Set app logo
    ImageLoaderFactory *factory = [[ImageLoaderFactory alloc] init];
    AsynchronousImageDownloader *downloader = [[AsynchronousImageDownloader alloc] initWithDelegate:self];
    imageLoader = [factory createUsingCacheFolderWithDownloader:downloader];
    
    UIImage *image = [imageLoader load:self.app.appLogo withSaveName:self.app.appId];
    if (image != nil) {
        [self.imageLogo setImage:image];
    }
    else {
        [self.imageLogo setImage:[UIImage imageNamed:@"ic_template.png"]];
    }
    
    // Unpressed data - Set image round view
    if ([self.app.auxPin isEqualToString:@"1"]) {
        [self.imageRoundView setImage:[UIImage imageNamed:@"img_roundc_pinup.png"]];
    }
    else {
        [self.imageRoundView setImage:[UIImage imageNamed:@"img_roundc_btn.png"]];
    }
    
    // Unpressed data - pins
    NSNumber *pins = self.app.auxTotalPins;
    NSString *pinText = NSLocalizedString(@"pin_plural_text", @"Pin plural text");
 
    if (pins == [NSNumber numberWithInt:1]) {
        pinText = NSLocalizedString(@"pin_sing_text", @"Pin singular text");
    }
    self.pinsUnpressedText.text = [NSString stringWithFormat:@"%@ %@", pins, pinText];
    
    // Price label and image
    PriceImageLabelHelper *priceHelper = [[PriceImageLabelHelper alloc] initWithApp:self.app];
    self.appPrice.text = [priceHelper getPriceText];
    self.priceImage.image = [priceHelper getImage];

    [self.cellContent addSubview:self.cellUnpressed];
    
    // Rating
//    rating = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(self.ratingView.frame.origin.x, self.ratingView.frame.origin.y + 5, self.ratingView.frame.size.width, self.ratingView.frame.size.height)
// andStars:5 isFractional:YES];
//    rating.delegate = self;
//	rating.backgroundColor = [UIColor clearColor];
//	rating.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
//	rating.rating = [self.app.auxTotalRate doubleValue];
//    rating.userInteractionEnabled = NO;
//	[self.cellUnpressed addSubview:rating];
//    
//    NSString *ratingText = NSLocalizedString(@"app_rating_unrated", @"Rating - unrated app");
//    switch ((int)ceil([self.app.auxTotalRate doubleValue])) {
//        case 1:
//            ratingText = NSLocalizedString(@"app_rating_poor_app", @"Rating - poor app");
//            break;
//        case 2:
//            ratingText = NSLocalizedString(@"app_rating_below_avg_app", @"Rating - below average app");
//            break;
//        case 3:
//            ratingText = NSLocalizedString(@"app_rating_avg_app", @"Rating - average app");
//            break;
//        case 4:
//            ratingText = NSLocalizedString(@"app_rating_above_avg_app", @"Rating - above average app");
//            break;
//        case 5:
//            ratingText = NSLocalizedString(@"app_rating_excellent_app", @"Rating - excellent app");
//            break;
//        default:
//            break;
//    }
//    self.ratingLabel.text = ratingText;
}

- (void)newRating:(DLStarRatingControl *)control :(float)rating {
    // Empty
}

- (void)loadPressedCellData {
    // Pin
    if ([self.app.auxPin isEqualToString:@"0"]) {
        self.pinPressedImage.imageView.image = [UIImage imageNamed:@"ic_action_pinup.png"];
        self.pinPressedText.text = NSLocalizedString(@"pin_sing_text", @"Pin singular text");
    }
    else {
        self.pinPressedImage.imageView.image = [UIImage imageNamed:@"ic_action_unpinup.png"];
        self.pinPressedText.text = NSLocalizedString(@"un_pin_up", @"Pin unpin text");
    }
    
    // Rate
    self.ratePressedText.text = NSLocalizedString(@"rate_singular_text", @"Rate singular text");
    
    // Block
    self.blockPressedText.text = NSLocalizedString(@"block_text", @"Block text"); 
    
    // Share
    self.sharePressedText.text = NSLocalizedString(@"share_text", @"Share text");
}

- (void)imageDownloaded:(DownloadedImageSuccess *)download withSaveName:(NSString *)save_name {
    UIImage *downloadedImage = download.image;
    if (downloadedImage != nil) {
        [self.imageLogo setImage:downloadedImage];
        [imageLoader saveImageInCache:downloadedImage path:self.app.appId];
    }
}

- (void)imageNotDownloaded:(DownloadedImageError *)error withSaveName:(NSString *)save_name {}

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

- (IBAction)pinUnpinApp:(id)sender {
    NSString *action = @"";
    if ([self.app.auxPin isEqualToString:@"0"]) {
        action = ACTION_PIN_REQUEST_PIN;
        self.app.auxPin = @"1";
    }
    else {
        action = ACTION_PIN_REQUEST_UNPIN;
        self.app.auxPin = @"0";
    }
    
    // Pin/unpin request
    pinRequester = [[AppPinRequest alloc] init];
    [pinRequester doRequestWithAppId:self.app.appId userId:self.userId action:action andLocation:self.currentLocation];

    // Sort table and reload
    [self.modelList sort];
    [self.viewController reloadTableDataAndScrollTop:YES];
}

- (IBAction)blockUnblockApp:(id)sender {
    // Block request
    blockRequester = [[AppBlockRequest alloc] init];
    [blockRequester doRequestWithAppId:self.app.appId userId:self.userId action:ACTION_LIKE_REQUEST_BLOCK];
    
    // Pin/unpin request
    pinRequester = [[AppPinRequest alloc] init];
    [pinRequester doRequestWithAppId:self.app.appId userId:self.userId action:ACTION_PIN_REQUEST_UNPIN andLocation:self.currentLocation];
    
    // Remove app from app list
    [self.modelList deleteApp:self.app];
    [self.appsList removeObject:self.app];
    
    // Remove row in table for selected app
    UITableView *table = (UITableView *)self.superview;
    [table deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.positionInList inSection:0]] withRowAnimation:UITableViewRowAnimationMiddle];
    
    [self.viewController reloadTableDataAndScrollTop:NO];
}

@end
