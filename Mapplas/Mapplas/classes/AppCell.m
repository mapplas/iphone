//
//  AppCell.m
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppCell.h"

@implementation AppCell

@synthesize cellPressed;
@synthesize cellUnpressed;
@synthesize cellContent;

@synthesize imageLogo;
@synthesize imageRoundView;
@synthesize appName;
@synthesize appPrice;
@synthesize pinsUnpressedText;

@synthesize pinPressedImage;
@synthesize pinPressedText;
@synthesize ratePressedText;
@synthesize blockPressedText;
@synthesize sharePressedText;

@synthesize priceImage;

@synthesize app = _app;
@synthesize userId = _userId;
@synthesize currentLocation = _currentLocation;
@synthesize list = _list;
@synthesize pressed = _pressed;

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
    
    NSString *currency = @"";
    if (self.app.locationCurrency == EURO) {
        currency = NSLocalizedString(@"currency_euro", @"Euro currency");
    }
    else {
        currency = NSLocalizedString(@"currency_dollar", @"Dollar currency");
    }
    
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
    
    // Price image
    if ([self.app.appPrice isEqualToString:@"0"]) {
        self.appPrice.text = NSLocalizedString(@"free_text", @"Free");
        self.priceImage.image = [UIImage imageNamed:@"ic_badge_free.png"];
    }
    else {
        self.appPrice.text = [NSString stringWithFormat:@"%@ %@", currency, self.app.appPrice];
        self.priceImage.image = [UIImage imageNamed:@"ic_badge_price.png"];
    }

    [self.cellContent addSubview:self.cellUnpressed];
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
    self.ratePressedText.text = NSLocalizedString(@"share_text", @"Share text");
}

- (void)imageDownloaded:(DownloadedImageSuccess *)download {
    UIImage *downloadedImage = download.image;
    if (downloadedImage != nil) {
        [self.imageLogo setImage:downloadedImage];
        [imageLoader saveImageInCache:downloadedImage path:self.app.appId];
    }
}

- (void)imageNotDownloaded:(DownloadedImageError *)error {}

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
    [self.list sort];
    UITableView *table = (UITableView *)self.superview;
    [table reloadData];
}

- (IBAction)blockUnblockApp:(id)sender {
    blockRequester = [[AppBlockRequest alloc] init];
    [blockRequester doRequestWithAppId:self.app.appId userId:self.userId action:ACTION_LIKE_REQUEST_BLOCK];
    
//    (fade out animation)
}

@end
