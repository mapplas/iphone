//
//  Notification.h
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "Unit.h"
#import "App.h"

@interface Notification : Unit {
    NSUInteger _companyId;
    NSUInteger _appId;
    NSString *_name;
    NSString *_description;
    NSString *_date;
    NSString *_hour;
    App *_auxApp;
    NSUInteger _seen;
    NSUInteger _shown;
    long _arrivalTimestamp;
    NSString *_currentLocation;
    long _dateInMs;
}

@property (nonatomic) NSUInteger companyId;
@property (nonatomic) NSUInteger appId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *hour;
@property (nonatomic, strong) App *auxApp;
@property (nonatomic) NSUInteger seen;
@property (nonatomic) NSUInteger shown;
@property (nonatomic) long arrivalTimestamp;
@property (nonatomic, strong) NSString *currentLocation;
@property (nonatomic) long dateInMs;

@end
