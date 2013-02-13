//
//  NotificationDBInserter.m
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "NotificationDBInserter.h"

@implementation NotificationDBInserter

- (id)initWithModel:(SuperModel *)_model {
    self = [super init];
    if (self) {
        model = _model;
    }
    return self;
}

- (void)insertNotificationsToDB {
    model.notificationRawList = [self modelNotificationRawList];
    
    JSONToNotificationMapper *notificationMapper = [[JSONToNotificationMapper alloc] init];
    Notification *notification = nil;
    
    long currentTimestamp = (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]) * 1000;
    int count = 0;
    
    NSMutableArray *notificationRaw = model.notificationRawList;
    for (int i = 0; i < notificationRaw.count; i++) {
        NSArray *currentAppNotifications = [notificationRaw objectAtIndex:i];
        for (int j = 0; j < currentAppNotifications.count; j++) {
            count ++;
            
            NSDictionary *currentNotification = [currentAppNotifications objectAtIndex:j];
            notification = [notificationMapper map:currentNotification];
            
            App *notificationApp = [self getAppForId:notification.appId];
            
            notification.auxApp = notificationApp;
            notification.arrivalTimestamp = currentTimestamp;
            notification.currentLocation = model.currentLocation;
            notification.dateInMs = [self getMsForDate:notification.date andHour:notification.hour];
            
            [model.notificationList.list addObject:notification];
            
            // Insert notification into DB
            
        }
    }
    
    // Delete notifications up to 100 from DB
    
    // Flush
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

- (long)getMsForDate:(NSString *)_date andHour:(NSString *)_hour {
    NSArray *dateSplitted = [_date componentsSeparatedByString:@"-"];
    NSString *year = [dateSplitted objectAtIndex:0];
    NSString *month = [dateSplitted objectAtIndex:1];
    NSString *day = [dateSplitted objectAtIndex:2];
    NSArray *hourSplitted = [_hour componentsSeparatedByString:@":"];
    NSString *hours = [hourSplitted objectAtIndex:0];
    NSString *mins = [hourSplitted objectAtIndex:1];
    
    NSUInteger ms = [mins intValue] * 60 * 1000;
    ms += [hours intValue] * 60 * 60 * 1000;
    ms += [day intValue] * 24 * 60 * 60 * 1000;
    ms += [month intValue] * 30 * 24 * 60 * 60 * 1000;
    ms += [year intValue] * 12 * 30 * 24 * 60 * 60 * 1000;
    return ms;
}

@end
