//
//  UserListTableViewCell.h
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App.h"

#import "ImageLoaderFactory.h"
#import "AsynchronousImageDownloader.h"

@interface UserListTableViewCell : UITableViewCell <AsynchronousImageDownloaderProtocol> {
    ImageLoader *imageLoader;
}

@property (nonatomic, strong) App *app;

@property (nonatomic, strong) IBOutlet UIImageView *appLogo;
@property (nonatomic, strong) IBOutlet UIImageView *appBackgroundLogo;
@property (nonatomic, strong) IBOutlet UILabel *appTitle;
@property (nonatomic, strong) IBOutlet UILabel *appGeoLocation;
@property (nonatomic, strong) IBOutlet UIButton *appUnpinButton;
@property (nonatomic, strong) IBOutlet UILabel *appPinActionLabel;

- (void)loadData;

@end
