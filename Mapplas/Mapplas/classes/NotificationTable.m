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
					   [[SQLiteColumn alloc] initWithName:@"autoIncrementIdentifier" type:@"int-as-string" column:@"id"],
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

- (void)deleteRowsUpTo:(int)maxNotificationsInDB withModel:(SuperModel *)model {
    
}

@end
