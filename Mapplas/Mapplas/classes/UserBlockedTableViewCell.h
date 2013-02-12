//
//  UserBlockedTableViewCell.h
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App.h"

#import "ImageLoaderFactory.h"
#import "AsynchronousImageDownloader.h"

#import "AppActivityRequest.h"
#import "AppBlockRequest.h"
#import "AppOrderedList.h"
#import "Constants.h"

@interface UserBlockedTableViewCell : UITableViewCell <AsynchronousImageDownloaderProtocol> {
    ImageLoader *imageLoader;
    
    AppActivityRequest *activityRequest;
    AppBlockRequest *blockRequest;
}

@property (nonatomic, strong) App *app;
@property (nonatomic, strong) NSMutableArray *blockedApps;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) AppOrderedList *modelAppOrderedList;
@property (nonatomic) NSUInteger positionInList;

@property (nonatomic, strong) IBOutlet UIImageView *appLogo;
@property (nonatomic, strong) IBOutlet UIImageView *appBackgroundLogo;
@property (nonatomic, strong) IBOutlet UILabel *appTitle;
@property (nonatomic, strong) IBOutlet UIButton *appUnblockButton;
@property (nonatomic, strong) IBOutlet UILabel *appUnblockActionLabel;

- (void)loadData;
- (IBAction)unblockApp:(id)sender;
@end
