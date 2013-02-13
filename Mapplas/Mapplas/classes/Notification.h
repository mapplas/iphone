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
    NSString *_autoIncrementIdentifier;
    NSString *_companyId;
    NSString *_appId;
    NSString *_name;
    NSString *_description;
    NSString *_date;
    NSString *_hour;
    App *_auxApp;
    int _seen;
    int _shown;
    long _arrivalTimestamp;
    NSString *_currentLocation;
    int _dateInMs;
}

@property (nonatomic, strong) NSString *autoIncrementIdentifier;
@property (nonatomic, strong) NSString *companyId;
@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *hour;
@property (nonatomic, strong) App *auxApp;
@property (nonatomic) int seen;
@property (nonatomic) int shown;
@property (nonatomic) long arrivalTimestamp;
@property (nonatomic, strong) NSString *currentLocation;
@property (nonatomic) int dateInMs;

@end
