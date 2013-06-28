//
//  NotificationList.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "Notification.h"

@interface NotificationList : NSObject {
    NSMutableArray *_list;
}

@property (nonatomic, strong) NSMutableArray *list;

- (id)init;
- (void)addNotification:(Notification *)_notification;
- (void)reset;

@end
