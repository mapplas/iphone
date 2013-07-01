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
#import "User.h"

#import "ImageLoaderFactory.h"
#import "AsynchronousImageDownloader.h"

#import "AppPinRequest.h"

#import "UIButton+Extensions.h"

@interface UserListTableViewCell : UITableViewCell <AsynchronousImageDownloaderProtocol> {
    ImageLoader *imageLoader;
    
    AppPinRequest *unpinRequest;
}

@property (nonatomic, strong) App *app;
@property (nonatomic, strong) NSMutableArray *pinnedApps;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *reverseGeocodedLocation;
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
