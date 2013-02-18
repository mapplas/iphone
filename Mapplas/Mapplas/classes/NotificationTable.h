//
//  NotificationTable.h
//  Mapplas
//
//  Created by Belén  on 13/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "SQLiteTableBaseObject.h"
#import "Notification.h"
#import "SuperModel.h"

@interface NotificationTable : SQLiteTableBaseObject {
    sqlite3_stmt *loadNumberOfRows;
    sqlite3_stmt *notificationsShown;
    sqlite3_stmt *selectNotificationsUpTo;
    sqlite3_stmt *notificationTimestamps;
    sqlite3_stmt *notificationsByTimestamps;
    sqlite3_stmt *removeDuplicates;
}

- (Notification *)load:(NSString *)key;
- (NSUInteger)numberOfRows;

- (BOOL)deleteRowsUpTo:(int)maxNotificationsInDB withModel:(SuperModel *)model;
- (BOOL)removeDuplicateNotificationsFor:(Notification *)notification;

- (BOOL)setNotificationsAsShown;

- (NSMutableDictionary *)getNotificationsSeparatedByLocation;

@end
