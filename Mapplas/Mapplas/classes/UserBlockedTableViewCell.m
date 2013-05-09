//
//  UserBlockedTableViewCell.m
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserBlockedTableViewCell.h"

@implementation UserBlockedTableViewCell

@synthesize app, blockedApps, user, location, modelAppOrderedList, positionInList;

@synthesize appLogo;
@synthesize appBackgroundLogo;
@synthesize appTitle;
@synthesize appUnblockButton;
@synthesize appUnblockActionLabel;

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
    
    self.appTitle.text = app.name;
    
    self.appUnblockActionLabel.text = NSLocalizedString(@"user_list_blocked_cell_unblock_text", @"User screen block cell unblock label text");
}

- (IBAction)unblockApp:(id)sender {
    blockRequest = [[AppBlockRequest alloc] init];
    [blockRequest doRequestWithAppId:self.app.appId userId:self.user.userId action:ACTION_LIKE_REQUEST_UNBLOCK];
    
    // Remove 
    [self.blockedApps removeObject:self.app];
    [self.modelAppOrderedList addObject:self.app];
    
    // Set environment variable of change to yes
    [[Environment sharedInstance] setAppSomethingChangedInDetail:YES];
    
    // Remove row in table for selected app
    UITableView *table = (UITableView *)self.superview;
    [table deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.positionInList inSection:0]] withRowAnimation:UITableViewRowAnimationMiddle];
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
