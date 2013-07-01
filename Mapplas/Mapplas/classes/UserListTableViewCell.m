//
//  UserListTableViewCell.m
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserListTableViewCell.h"

@implementation UserListTableViewCell

@synthesize app, pinnedApps, user, location, modelAppOrderedList, positionInList;

@synthesize appLogo;
@synthesize appBackgroundLogo;
@synthesize appTitle;
@synthesize appGeoLocation;
@synthesize reverseGeocodedLocation;
@synthesize appUnpinButton;
@synthesize appPinActionLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];
}

- (void)loadData {
    ImageLoaderFactory *factory = [[ImageLoaderFactory alloc] init];
    AsynchronousImageDownloader *downloader = [[AsynchronousImageDownloader alloc] initWithDelegate:self];
    imageLoader = [factory createUsingCacheFolderWithDownloader:downloader];
    
    UIImage *image = [imageLoader load:self.app.appLogo withSaveName:self.app.appId];
    if (image != nil) {
        [self.appLogo setImage:image];
    }
    else {
        [self.appLogo setImage:[UIImage imageNamed:@"ic_template.png"]];
    }
    
    // Touch edge insets bigger
    [self.appUnpinButton setHitTestEdgeInsets:UIEdgeInsetsMake(-20, -20, -20, -20)];
    
    self.appTitle.text = app.name;
    self.appGeoLocation.text = app.appPinnedGeocodedLocation;
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    self.appPinActionLabel.text = NSLocalizedString(@"un_pin_up", @"Pin unpin text");
}

- (IBAction)unpinApp:(id)sender {
    // Remove app from pinned app list
    [self.pinnedApps removeObject:app];
    
    unpinRequest = [[AppPinRequest alloc] init];
    [unpinRequest doRequestWithAppId:app.appId userId:user.userId action:ACTION_PIN_REQUEST_UNPIN reverseGeocodedAddress:self.reverseGeocodedLocation andLocation:location];
    
    // Remove app from app ordered list at model
    BOOL found = NO;
    NSUInteger i = 0;
    while (!found && i < modelAppOrderedList.count) {
        App *currentApp = [modelAppOrderedList objectAtIndex:i];
        if ([currentApp.appId isEqualToString:app.appId]) {
            if ([currentApp.auxPin intValue] == 0) {
                currentApp.auxPin = [NSNumber numberWithInt:1];
            }
            else {
                currentApp.auxPin = [NSNumber numberWithInt:0];
            }
            found = YES;
        }
        i++;
    }
    
    // Set environment variable of change to yes
    [[Environment sharedInstance] setAppSomethingChangedInDetail:YES];
    
    // Remove row in table for selected app
    UITableView *table = (UITableView *)self.superview;
    [table deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.positionInList inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
    [table reloadData];
}

#pragma mark - AsynchronousImageDownloader protocol methods
- (void)imageDownloaded:(DownloadedImageSuccess *)download withSaveName:(NSString *)save_name {
    UIImage *downloadedImage = download.image;
    if (downloadedImage != nil) {
        [self.appLogo setImage:downloadedImage];
        [imageLoader saveImageInCache:downloadedImage path:self.app.appId];
    }
}

- (void)imageNotDownloaded:(DownloadedImageError *)error withSaveName:(NSString *)save_name {}

@end
