//
//  UINavigationBar+SCBackgroundImage.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCAppUtils.h"

@interface UINavigationBar (SCBackgroundImage)

- (void)scInsertSubview:(UIView *)view atIndex:(NSInteger)index;
- (void)scSendSubviewToBack:(UIView *)view;

@end
