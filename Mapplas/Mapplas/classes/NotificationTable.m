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
//					   [[SQLiteColumn alloc] initWithName:@"arrivalTimestamp" type:@"int"],
					   [[SQLiteColumn alloc] initWithName:@"currentLocation" type:@"text"],
//					   [[SQLiteColumn alloc] initWithName:@"dateInMs" type:@"int"],
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
    NSUInteger rows = 0;
    	
	if(![self connect]) {
		return NO;
	}
	
	if(loadNumberOfRows == nil) {
		loadNumberOfRows = [SQLitePrepareStatment prepare:[NSString stringWithFormat:@"SELECT COUNT(*) FROM %@", table] database:db];
	}
	
	BOOL result = [self executeStatment:loadNumberOfRows andReset:YES];
	
	sqlite3_reset(loadNumberOfRows);
    
    return rows;
}

- (BOOL)deleteRowsUpTo:(int)maxNotificationsInDB withModel:(SuperModel *)model {
    NSMutableArray *firstNotifications;
    
    if (![self connect]) {
        return NO;
    }
    
    if (selectNotificationsUpTo == nil) {
        selectNotificationsUpTo = [SQLitePrepareStatment prepare:[NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY %@ LIMIT %d", table, @"dateInMs", maxNotificationsInDB] database:db];
    }
    
    BOOL result = [self executeStatment:selectNotificationsUpTo andReset:YES];
    	
	if(result) {
		SQLiteQueryMapper *mapper = [[SQLiteQueryMapper alloc] init];
		[mapper mapToObject:selectNotificationsUpTo object:firstNotifications columns:columns];
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

@end
