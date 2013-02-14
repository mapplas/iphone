//
//  NotificationCell.h
//  Mapplas
//
//  Created by Belén  on 13/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App.h"
#import "Notification.h"

#import "ImageLoaderFactory.h"
#import "AsynchronousImageDownloader.h"
#import "ImageLoader.h"

@interface NotificationCell : UITableViewCell <AsynchronousImageDownloaderProtocol> {
    App *_app;
    Notification *_notification;
    
    ImageLoader *imageLoader;
}

@property (nonatomic, strong) App *app;
@property (nonatomic, strong) Notification *notification;

@property (nonatomic, strong) IBOutlet UIImageView *logo;
@property (nonatomic, strong) IBOutlet UILabel *appName;
@property (nonatomic, strong) IBOutlet UILabel *date;
@property (nonatomic, strong) IBOutlet UILabel *description;

- (void)loadData;

@end
