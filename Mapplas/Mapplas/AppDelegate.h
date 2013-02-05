//
//  AppDelegate.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppsViewController.h"

#define UUID_USER_DEFAULTS_KEY @"UUID"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    UINavigationController *_navigationController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;

@end
