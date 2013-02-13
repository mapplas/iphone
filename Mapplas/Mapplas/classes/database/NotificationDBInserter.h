//
//  NotificationDBInserter.h
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "JSONToNotificationMapper.h"
#import "SuperModel.h"

@interface NotificationDBInserter : NSObject {
    SuperModel *model;
}

- (id)initWithModel:(SuperModel *)_model;
- (void)insertNotificationsToDB;

@end
