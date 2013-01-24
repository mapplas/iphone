//
//  AppCell.h
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App.h"

@interface AppCell : UITableViewCell {
    UIImageView *_imageLogo;
    UIImageView *_imageRoundView;
    
    App *_app;
}

@property (nonatomic, strong) IBOutlet UIImageView *imageLogo;
@property (nonatomic, strong) IBOutlet UIImageView *imageRoundView;
@property (nonatomic, strong) App *app;

- (void)loadData;

@end
