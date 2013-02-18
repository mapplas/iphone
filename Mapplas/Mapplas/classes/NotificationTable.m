//
//  NotificationTable.m
//  Mapplas
//
//  Created by Belén  on 13/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "NotificationTable.h"

@implementation NotificationTable

- (id)init {
	NSArray *fields = [[NSArray alloc] initWithObjects:
					   [[SQLiteColumn alloc] initWithName:@"identifier" type:@"int-as-string"],
					   [[SQLiteColumn alloc] initWithName:@"companyId" type:@"int-as-string"],
					   [[SQLiteColumn alloc] initWithName:@"appId" type:@"int-as-string"],
                        
					   [[SQLiteColumn alloc] initWithName:@"name" type:@"text"],
					   [[SQLiteColumn alloc] initWithName:@"description" type:@"text"],
					   [[SQLiteColumn alloc] initWithName:@"date" type:@"text"],
					   [[SQLiteColumn alloc] initWithName:@"hour" type:@"text"],
                        
					   [[SQLiteColumn alloc] initWithName:@"seen" type:@"boolean"],
					   [[SQLiteColumn alloc] initWithName:@"shown" type:@"boolean"],
					   [[SQLiteColumn alloc] initWithName:@"arrivalTimestamp" type:@"int"],
					   [[SQLiteColumn alloc] initWithName:@"currentLocation" type:@"text"],
					   [[SQLiteColumn alloc] initWithName:@"dateInMs" type:@"int"],
					   nil];
	
	self = [super initWithDatabase:@"Notifications.db" table:@"notifications" columns:fields];
	
	return self;
}

- (Notification *)load:(NSString *)key {
	Notification *resultingNotification = [[Notification alloc] init];
	
	if([super loadWithString:key target:resultingNotification]) {
		return resultingNotification;
	}
	else {
		return nil;
	}
}

- (NSUInteger)numberOfRows {
    NSNumber *rows = nil;
    	
	if(![self connect]) {
		return NO;
	}
	
	if(loadNumberOfRows == nil) {
		loadNumberOfRows = [SQLitePrepareStatment prepare:[NSString stringWithFormat:@"SELECT COUNT(*) FROM %@", table] database:db];
	}
    	
	BOOL result = [self executeStatment:loadNumberOfRows andReset:YES];
    
    if(result) {
        while(sqlite3_step(loadNumberOfRows) == SQLITE_ROW ){
            int count = sqlite3_column_int(loadNumberOfRows, 0);
            rows = [NSNumber numberWithInt:count];
        }
	}
	
	sqlite3_reset(loadNumberOfRows);
    
    return [rows integerValue];
}

- (BOOL)deleteRowsUpTo:(int)maxNotificationsInDB withModel:(SuperModel *)model {
    NSMutableArray *firstNotifications = [[NSMutableArray alloc] init];
    
    if (![self connect]) {
        return NO;
    }
    
    if (selectNotificationsUpTo == nil) {
        selectNotificationsUpTo = [SQLitePrepareStatment prepare:[NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY %@ DESC LIMIT %d", table, @"arrivalTimestamp", maxNotificationsInDB] database:db];
    }
    
    BOOL result = [self executeStatment:selectNotificationsUpTo andReset:YES];
    	
	if(result) {
		while ([self.executor executeMultiple:selectNotificationsUpTo database:db]) {
            Notification *notif = [[Notification alloc] init];
            notif.uniqueIdentifier = [[NSString alloc] initWithBytes:sqlite3_column_text(selectNotificationsUpTo, 0) length:sizeof(sqlite3_column_text(selectNotificationsUpTo, 0)) encoding:NSASCIIStringEncoding];
            notif = [self load:notif.uniqueIdentifier];
            
            [firstNotifications addObject:notif];
        }
	}
    
    [self empty];
    // this.notificationIds.clear();
    
    NotificationList *appNotifications = [[NotificationList alloc] init];
    for (Notification *current in firstNotifications) {
        [current setAuxApp:[self getAppForId:current.appId model:model]];
        [self saveBatch:current];
        
        [appNotifications addNotification:current];
    }
    
    model.notificationList = appNotifications;
    
    [self flush];
    
    return result;
}

- (App *)getAppForId:(NSString *)appId model:(SuperModel *)model {
    NSMutableArray *appList = model.appList.list;
    for (App *app in appList) {
        if ([app.appId isEqualToString:appId]) {
            return app;
        }
    }
    return nil;
}

- (BOOL)setNotificationsAsShown {
    if (![self connect]) {
        return NO;
    }
    
    if (notificationsShown == nil) {
        notificationsShown = [SQLitePrepareStatment prepare:[NSString stringWithFormat:@"UPDATE %@ SET shown = 1", table] database:db];
    }
    
    BOOL result = [self executeStatment:notificationsShown andReset:YES];
    
    sqlite3_reset(notificationsShown);
    
    return result;
}

- (NSMutableDictionary *)getNotificationsSeparatedByLocation {
    if (![self connect]) {
        return NO;
    }
    
//    Get different timestamp sorted from newer to older
    NSMutableArray *listOfNotificationTimestamps = [self getNotificationTimestampList];
    
//    Get ArrayLists of notifications for each diferent timestamp
    NSMutableDictionary *notificationData = [[NSMutableDictionary alloc] init];
    NSNumber *currentNotificationTimestamp = [NSNumber numberWithInt:0];
    
    for (Notification *currentNotification in listOfNotificationTimestamps) {
        NSMutableArray *listOfNotifications = [[NSMutableArray alloc] init];

        currentNotificationTimestamp = currentNotification.arrivalTimestamp;
        
        if (notificationsByTimestamps == nil) {
            notificationsByTimestamps = [SQLitePrepareStatment prepare:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = %@ GROUP BY %@", table, @"arrivalTimestamp", currentNotificationTimestamp, @"dateInMs"] database:db];
        }
        
        Notification *notif = [[Notification alloc] init];
        while ([self.executor executeMultiple:notificationsByTimestamps database:db]) {
            notif.uniqueIdentifier = [[NSString alloc] initWithBytes:sqlite3_column_text(notificationsByTimestamps, 0) length:sizeof(sqlite3_column_text(notificationsByTimestamps, 0)) encoding:NSASCIIStringEncoding];
            notif = [self load:notif.uniqueIdentifier];
            
            [listOfNotifications addObject:notif];
        }
        
        [notificationData setObject:listOfNotifications forKey:currentNotificationTimestamp];
        
        sqlite3_reset(notificationsByTimestamps);
        sqlite3_finalize(notificationsByTimestamps);
        notificationsByTimestamps = nil;
    }
    
    return notificationData;
}

- (NSMutableArray *)getNotificationTimestampList {
    NSMutableArray *timestampList = [[NSMutableArray alloc] init];
    
    if (notificationTimestamps == nil) {
        notificationTimestamps = [SQLitePrepareStatment prepare:[NSString stringWithFormat:@"SELECT DISTINCT %@ FROM %@ ORDER BY %@", @"arrivalTimestamp", table, @"arrivalTimestamp"] database:db];
    }
    
    while([self.executor executeMultiple:notificationTimestamps database:db]) {
        Notification *notif = [[Notification alloc] init];
        notif.arrivalTimestamp = [NSNumber numberWithLong:sqlite3_column_int(notificationTimestamps, 0)];
        
        [timestampList addObject:notif];
	}
    
    return timestampList;
}

@end
