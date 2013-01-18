//
//  UINavigationBar+SCBackgroundImage.m
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UINavigationBar+SCBackgroundImage.h"

@implementation UINavigationBar (SCBackgroundImage)

- (void)scInsertSubview:(UIView *)view atIndex:(NSInteger)index {
    [self scInsertSubview:view atIndex:index];
    
    UIView *backgroundImageView = [self viewWithTag:mapplasNavBarImageTag];
    if (backgroundImageView != nil) {
        [self scSendSubviewToBack:backgroundImageView];
    }
}

- (void)scSendSubviewToBack:(UIView *)view {
    [self scSendSubviewToBack:view];
    
    UIView *backgroundImageView = [self viewWithTag:mapplasNavBarImageTag];
    
    if (backgroundImageView != nil) {
        [self scSendSubviewToBack:backgroundImageView];
    }
}

@end
