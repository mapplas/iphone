//
//  SuperModel.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "User.h"
#import "AppOrderedList.h"
#import "NotificationList.h"

@interface SuperModel : NSObject {
    NSString *_currentLocation;
    CLLocation *_location;
    User *_user;
    NSString *_currentRadius;
    NSString *_currentImei;
    NSString *_currentDescriptiveGeoLoc;
    AppOrderedList *_appList;
    NotificationList *_notificationList;
    bool _operationError;
    NSString *_errorText;
    NSMutableArray *_notificationRawList;
}

@property (nonatomic, strong) NSString *currentLocation;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *currentRadius;
@property (nonatomic, strong) NSString *currentImei;
@property (nonatomic, strong) NSString *currentDescriptiveGeoLoc;
@property (nonatomic, strong) AppOrderedList *appList;
@property (nonatomic, strong) NotificationList *notificationList;
@property (nonatomic) bool operationError;
@property (nonatomic, strong) NSString *errorText;
@property (nonatomic, strong) NSMutableArray *notificationRawList;

- (id)init;

@end