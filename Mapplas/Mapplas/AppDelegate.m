//
//  AppDelegate.m
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppDelegate.h"
#import "SCAppUtils.h"
#import "NSString+UUID.h"

@implementation AppDelegate

@synthesize navigationController = _navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initComponents];
    
    return YES;
}

- (void)initComponents {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Set user unique identifier in defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:UUID_USER_DEFAULTS_KEY] == nil) {
        [defaults setObject:[NSString uuid] forKey:UUID_USER_DEFAULTS_KEY];
        [defaults synchronize];
    }
    
    if ([defaults objectForKey:APP_HAS_TO_RESTART] == nil) {
        [defaults setBool:NO forKey:APP_HAS_TO_RESTART];
        [defaults synchronize];
    }
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // Set navigationController
    AppsViewController *rootViewController = [[AppsViewController alloc] init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    [SCAppUtils customizeNavigationController:self.navigationController];
    self.window.rootViewController = self.navigationController;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:APP_HAS_TO_RESTART]) {
        [self initComponents];
        [defaults setBool:NO forKey:APP_HAS_TO_RESTART];
        [defaults synchronize];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
