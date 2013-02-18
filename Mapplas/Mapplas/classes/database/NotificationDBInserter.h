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

#define maxNotificationsInDB 100

@interface NotificationDBInserter : NSObject {
    SuperModel *model;
    UIViewController *viewController;
    NotificationTable *notificationTable;
}

- (id)initWithModel:(SuperModel *)_model viewController:(UIViewController *)view_controller;
- (void)insertNotificationsToDB;

@end
