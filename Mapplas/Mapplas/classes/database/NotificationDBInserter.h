//
//  NotificationDBInserter.h
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "JSONToNotificationMapper.h"
#import "SuperModel.h"
#import "NotificationTable.h"

@interface NotificationDBInserter : NSObject {
    int maxNotificationsInDB;
    
    SuperModel *model;
    NotificationTable *notificationTable;
}

- (id)initWithModel:(SuperModel *)_model;
- (void)insertNotificationsToDB;

@end
