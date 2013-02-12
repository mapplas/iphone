//
//  UserListTableViewCell.h
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App.h"
#import "Constants.h"
#import "AppOrderedList.h"

#import "ImageLoaderFactory.h"
#import "AsynchronousImageDownloader.h"

#import "AppActivityRequest.h"
#import "AppPinRequest.h"

@interface UserListTableViewCell : UITableViewCell <AsynchronousImageDownloaderProtocol> {
    ImageLoader *imageLoader;
    
    AppActivityRequest *activityRequest;
    AppPinRequest *unpinRequest;
}

@property (nonatomic, strong) App *app;
@property (nonatomic, strong) NSMutableArray *pinnedApps;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) AppOrderedList *modelAppOrderedList;
@property (nonatomic) NSUInteger positionInList;

@property (nonatomic, strong) IBOutlet UIImageView *appLogo;
@property (nonatomic, strong) IBOutlet UIImageView *appBackgroundLogo;
@property (nonatomic, strong) IBOutlet UILabel *appTitle;
@property (nonatomic, strong) IBOutlet UILabel *appGeoLocation;
@property (nonatomic, strong) IBOutlet UIButton *appUnpinButton;
@property (nonatomic, strong) IBOutlet UILabel *appPinActionLabel;

- (void)loadData;
- (IBAction)unpinApp:(id)sender;

@end
