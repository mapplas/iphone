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
}

- (Notification *)load:(NSString *)key;
- (NSUInteger)numberOfRows;
- (void)deleteRowsUpTo:(int)maxNotificationsInDB withModel:(SuperModel *)model;

@end
