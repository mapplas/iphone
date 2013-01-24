//
//  AppCell.h
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App.h"
#import "ImageLoaderFactory.h"
#import "AsynchronousImageDownloader.h"

@interface AppCell : UITableViewCell <AsynchronousImageDownloaderProtocol> {
    UIView *cellPressed;
    UIView *cellUnpressed;
    
    UIImageView *_imageLogo;
    UIImageView *_imageRoundView;
    
    App *_app;
    ImageLoader *imageLoader;
}

@property (nonatomic, strong) IBOutlet UIImageView *imageLogo;
@property (nonatomic, strong) IBOutlet UIImageView *imageRoundView;
@property (nonatomic, strong) App *app;

- (void)loadData;

@end
