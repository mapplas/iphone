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
#define APP_HAS_TO_RESTART @"HAS_TO_RESTART"
#define APP_REQUEST_BEING_DONE @"APP_REQUEST_BEING_DONE"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    UINavigationController *_navigationController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;

@end
