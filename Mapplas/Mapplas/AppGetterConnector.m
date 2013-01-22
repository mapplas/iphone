//
//  AppGetterConnector.m
//  Mapplas
//
//  Created by Belén  on 22/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppGetterConnector.h"

@implementation AppGetterConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses variableListMapper:(VariableListMapper *)list_mapper responseHandler:(AppGetterResponseHandler *)response_handler {
    self = [super initWithAddresses:_addresses variableListMapper:list_mapper responseHandler:response_handler];
    if (self) {
        
    }
    return self;
}

- (void)requestWithModel:(SuperModel *)super_model andLocation:(CLLocation *)location {
    CLLocationCoordinate2D coord = location.coordinate;
    NSString *stringLocation = [NSString stringWithFormat:@"%g, %g", coord.latitude, coord.longitude];
    
    [parameters addValue:stringLocation withKey:@"l"];
    [parameters addValue:[[super_model user] userId] withKey:@"uid"];
    [parameters addValue:[NSString stringWithFormat:@"%f", location.horizontalAccuracy] withKey:@"p"];
    [parameters addValue:@"" withKey:@"ln"];
    
    [super initializeVariablesWithUrlAndSend:[self getUrl]];
}

- (NSString *)getUrl {
    return [adresses getApps];
}

@end
