//
//  NotificationCell.m
//  Mapplas
//
//  Created by Belén  on 13/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "NotificationCell.h"

@implementation NotificationCell

@synthesize app = _app;
@synthesize notification = _notification;

@synthesize logo;
@synthesize appName;
@synthesize date;
@synthesize description;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)loadData {
    ImageLoaderFactory *factory = [[ImageLoaderFactory alloc] init];
    AsynchronousImageDownloader *downloader = [[AsynchronousImageDownloader alloc] initWithDelegate:self];
    imageLoader = [factory createUsingCacheFolderWithDownloader:downloader];
    
    UIImage *image = [imageLoader load:self.app.appLogo withSaveName:self.app.appId];
    if (image != nil) {
        [self.logo setImage:image];
    }
    else {
        [self.logo setImage:[UIImage imageNamed:@"ic_template.png"]];
    }
    
    self.appName.text = self.app.name;
    self.description.text = self.notification.description;
    
    DateUtils *dateUtils = [[DateUtils alloc] init];
    self.date.text = [dateUtils formatSinceDate:self.notification.date hour:self.notification.hour];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - AsyncImageDownloadedProtocol
- (void)imageDownloaded:(DownloadedImageSuccess *)download withSaveName:(NSString *)save_name {
    UIImage *downloadedImage = download.image;
    if (downloadedImage != nil) {
        [self.logo setImage:downloadedImage];
        [imageLoader saveImageInCache:downloadedImage path:self.app.appId];
    }
}

- (void)imageNotDownloaded:(DownloadedImageError *)error withSaveName:(NSString *)save_name {}

@end
