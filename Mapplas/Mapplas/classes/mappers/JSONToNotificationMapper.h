//
//  JSONToNotificationMapper.h
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericMapper.h"
#import "ReturnMapper.h"
#import "Notification.h"

#import "KeyValueMapper.h"
#import "KeyValueScappedMapper.h"

@interface JSONToNotificationMapper : GenericMapper <ReturnMapper>

- (Notification *)map:(NSDictionary *)json;

@end
