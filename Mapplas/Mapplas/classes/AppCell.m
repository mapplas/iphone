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
@synthesize imageLogo, imageRoundView, appName, description;
@synthesize pinPressedImage, pinPressedText, ratePressedText, blockPressedText, sharePressedText;
@synthesize priceButton;

@synthesize app = _app, user = _user, currentLocation = _currentLocation, currentDescriptiveGeoLoc = _currentDescriptiveGeoLoc, modelList = _modelList, appsList = _appsList, positionInList = _positionInList, viewController = _viewController, pressed = _pressed;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.pressed = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    // Configure the view for the selected state
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 72)];
    view.backgroundColor = [UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1];
    self.selectedBackgroundView = view;
    
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
    if ([self.app.auxPin intValue] == 1) {
        [self.imageRoundView setImage:[UIImage imageNamed:@"img_roundc_pinup.png"]];
    }
    else {
        [self.imageRoundView setImage:[UIImage imageNamed:@"img_roundc_btn.png"]];
    }
    
    // Unpressed data - Description
    self.description.text = self.app.appShortDescription;

    
    // Price label and image
    PriceImageLabelHelper *priceHelper = [[PriceImageLabelHelper alloc] initWithApp:self.app];
    [self.priceButton setTitle:[priceHelper getPriceText] forState:UIControlStateNormal];
    [self.priceButton setBackgroundImage:[priceHelper getImage] forState:UIControlStateNormal];

    [self.cellContent addSubview:self.cellUnpressed];
    
    // Rating
//    RatingHelper *ratingHelper = [[RatingHelper alloc] init];
//    [self.cellUnpressed addSubview:[ratingHelper getRatingViewForView:self.ratingView andApp:self.app]];
//    self.ratingLabel.text = [ratingHelper getRatingTextForApp:self.app];
}

- (void)loadPressedCellData {
    // Pin
    if ([self.app.auxPin intValue] == 0) {
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
    NSString *pinRequestConstant = @"";
    
    if ([self.app.auxPin intValue] == 0) {
        pinRequestConstant = ACTION_PIN_REQUEST_PIN;
        self.app.auxPin = [NSNumber numberWithInt:1];
        self.app.auxTotalPins = [NSNumber numberWithInt:[self.app.auxTotalPins intValue] + 1];
    }
    else {
        pinRequestConstant = ACTION_PIN_REQUEST_UNPIN;
        self.app.auxPin = [NSNumber numberWithInt:0];
        self.app.auxTotalPins = [NSNumber numberWithInt:[self.app.auxTotalPins intValue] - 1];
    }
    
    // Pin/unpin request
    pinRequester = [[AppPinRequest alloc] init];
    [pinRequester doRequestWithAppId:self.app.appId userId:self.user.userId action:pinRequestConstant andLocation:self.currentLocation];

    // Sort table and reload
    [self.modelList sort];
    
    // Animation
    [self.viewController.table beginUpdates];
    NSInteger scroll_to = [self.modelList numberOfPins] - 1;
    if (scroll_to < 0) {
        scroll_to = 0;
    }
    [self.viewController.table moveRowAtIndexPath:[NSIndexPath indexPathForRow:self.positionInList inSection:0] toIndexPath:[NSIndexPath indexPathForRow:scroll_to inSection:0]];
    [self.viewController.table endUpdates];
    [self animate:nil];
    [self performSelector:@selector(reload) withObject:nil afterDelay:0.2];
}

- (void)reload {
    [self.viewController.table reloadData];
}

- (IBAction)blockUnblockApp:(id)sender {
    // Block request
    blockRequester = [[AppBlockRequest alloc] init];
    [blockRequester doRequestWithAppId:self.app.appId userId:self.user.userId action:ACTION_LIKE_REQUEST_BLOCK];
    
    // Pin/unpin request
    pinRequester = [[AppPinRequest alloc] init];
    [pinRequester doRequestWithAppId:self.app.appId userId:self.user.userId action:ACTION_PIN_REQUEST_UNPIN andLocation:self.currentLocation];
    
    // Remove app from app list
    [self.modelList deleteApp:self.app];
    // It is not necessary to delete again the app from the list!
    //[self.appsList removeObject:self.app];
    
    // Remove row in table for selected app
    UITableView *table = (UITableView *)self.superview;
    [table deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.positionInList inSection:0]] withRowAnimation:UITableViewRowAnimationMiddle];
    
    [self.viewController reloadTableDataAndScrollTop:NO];
}

- (IBAction)shareApp:(id)sender {
    sharingHelper = [[SharingHelper alloc] initWithApp:self.app navigationController:self.viewController.navigationController user:self.user andLocation:self.currentLocation];
    
    // If device has ios6 and up
	if ([UIActivityViewController class]) {
		NSMutableArray *itemsToShare = [[NSMutableArray alloc] initWithObjects:[sharingHelper getShareMessage], nil];
        
		UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
		activityViewController.excludedActivityTypes = @[UIActivityTypePostToWeibo, UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePrint, UIActivityTypeSaveToCameraRoll];
        
        activityViewController.completionHandler = ^(NSString *activityType, BOOL completed){
            if (completed) {
                [sharingHelper shareType:activityType];
            }
        };
        
		[self.viewController.navigationController presentViewController:activityViewController animated:YES completion:nil];
	}
	else {
        // iOS 5
		NSString *cancelButton = NSLocalizedString(@"ios5_sharing_action_sheet_cancel_button", @"iOS5 sharing action sheet cancel button - twitter sharing");
		NSString *twitterButton = NSLocalizedString(@"ios5_sharing_action_sheet_twitter_button", @"iOS5 sharing action sheet twitter button - twitter sharing");
        
		UIActionSheet *alertView = [[UIActionSheet alloc] initWithTitle:nil delegate:sharingHelper cancelButtonTitle:cancelButton destructiveButtonTitle:nil otherButtonTitles:twitterButton, @"Share via SMS", @"Share via email", nil];
		[alertView showInView:self.viewController.navigationController.view];
	}
}

- (IBAction)rateApp:(id)sender {
    rateHelper = [[RatingHelper alloc] init];
    [rateHelper rateApp:self.app];
}

- (IBAction)launchApp:(id)sender {
    NSString *urlScheme = self.app.appUrlScheme;
    if ([urlScheme isEqualToString:@""]) {
        [self goToAppStore];
    }
    else {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://", urlScheme]]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://", urlScheme]]];
        }
        else {
            [self goToAppStore];
        }
    }
}

- (void)goToAppStore {
    NSString *url = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", self.app.appId];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

@end
