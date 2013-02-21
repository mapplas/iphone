//
//  NotificationDBInserter.m
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "NotificationDBInserter.h"

@implementation NotificationDBInserter

- (id)initWithModel:(SuperModel *)_model viewController:(UIViewController *)view_controller {
    self = [super init];
    if (self) {        
        model = _model;
        viewController = view_controller;
        notificationTable = [[NotificationTable alloc] init];
        
        flagAnimate = NO;
        numberOfAnimations = 2;
        animationCount = 0;
    }
    
    return self;
}

- (void)insertNotificationsToDB {
    model.notificationRawList = [self modelNotificationRawList];
    
    JSONToNotificationMapper *notificationMapper = [[JSONToNotificationMapper alloc] init];
    Notification *notification = nil;
    
    NSTimeInterval date = [[NSDate date] timeIntervalSince1970];
    int count = 0;
    
    NSMutableArray *notificationRaw = model.notificationRawList;
    for (int i = 0; i < notificationRaw.count; i++) {
        NSArray *currentAppNotifications = [notificationRaw objectAtIndex:i];
        for (int j = 0; j < currentAppNotifications.count; j++) {
            count ++;
            
            NSDictionary *currentNotification = [currentAppNotifications objectAtIndex:j];
            notification = [notificationMapper map:currentNotification];
            
            App *notificationApp = [self getAppForId:notification.appId];
            
            notification.arrivalTimestamp = [NSNumber numberWithInt:(int)date];
            notification.auxApp = notificationApp;
            notification.currentLocation = model.currentLocation;
            notification.dateInMs = [NSNumber numberWithInt:[self getMsForDate:notification.date andHour:notification.hour]];
            
            [model.notificationList.list addObject:notification];
            
            // Insert notification into DB
            [notificationTable saveBatch:notification];
            
            // Check if exist same app in DB before yesterday
            [self checkSameApps:notification];
        }
    }
    
    if (count != 0) {
        buttonAnimationTimer = [NSTimer scheduledTimerWithTimeInterval:0.65f target:self selector:@selector(animate) userInfo:nil repeats:YES];
    }
    
    [notificationTable flush];
    
    [self deleteNotificationsUpTo];
}

- (NSMutableArray *)modelNotificationRawList {
    NSMutableArray *notificationsRaw = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < model.appList.count; i++) {
        NSArray *appNotifications = [[model.appList objectAtIndex:i] notificationRaw];
        if (appNotifications.count > 0) {
            [notificationsRaw addObject:appNotifications];
        }
    }
    return notificationsRaw;
}

- (App *)getAppForId:(NSString *)appId {
    for (App *app in model.appList.list) {
        if ([app.appId isEqualToString:appId]) {
            return app;
        }
    }
    return nil;
}

- (int)getMsForDate:(NSString *)_date andHour:(NSString *)_hour {
    NSArray *dateSplitted = [_date componentsSeparatedByString:@"-"];
    NSString *year = [dateSplitted objectAtIndex:0];
    NSString *month = [dateSplitted objectAtIndex:1];
    NSString *day = [dateSplitted objectAtIndex:2];
    NSArray *hourSplitted = [_hour componentsSeparatedByString:@":"];
    NSString *hours = [hourSplitted objectAtIndex:0];
    NSString *mins = [hourSplitted objectAtIndex:1];
    
    // Seconds! Not ms
    NSUInteger ms = [mins intValue] * 60;
    ms += [hours intValue] * 60 * 60;
    ms += [day intValue] * 24 * 60 * 60;
    ms += [month intValue] * 30 * 24 * 60 * 60;
    ms += [year intValue] * 12 * 30 * 24 * 60 * 60;
    return ms;
}

- (void)deleteNotificationsUpTo {
    int numberOfNotificationsInTable = [notificationTable numberOfRows];
    
    if (numberOfNotificationsInTable > maxNotificationsInDB) {
        // Delete rows up to defined number
        [notificationTable deleteRowsUpTo:maxNotificationsInDB withModel:model];
        [notificationTable flush];
    }
}

- (void)checkSameApps:(Notification *)notification {
    [notificationTable removeDuplicateNotificationsFor:notification];
}

-(void)animate {
    if (flagAnimate == 0 && animationCount < numberOfAnimations) {
        UIImage *notificationImage = [UIImage imageNamed:@"ic_menu_notifications_alert.png"];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:notificationImage style:UIBarButtonItemStyleBordered target:viewController action:@selector(pushNotificationScreen)];
        flagAnimate = 1;
    } else if (flagAnimate == 1) {
        UIImage *notificationImage = [UIImage imageNamed:@"ic_menu_notifications.png"];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:notificationImage style:UIBarButtonItemStyleBordered target:viewController action:@selector(pushNotificationScreen)];
        flagAnimate = 0;
        animationCount ++;
    } else if (animationCount == numberOfAnimations) {
        [buttonAnimationTimer invalidate];
        buttonAnimationTimer = nil;
    }
}

@end
