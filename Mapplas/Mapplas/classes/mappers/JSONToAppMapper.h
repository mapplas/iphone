//
//  JSONToAppMapper.h
//  Mapplas
//
//  Created by Belén  on 23/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "GenericMapper.h"
#import "ReturnMapper.h"
#import "App.h"
#import "KeyValueMapper.h"
#import "KeyValueScappedMapper.h"
#import "TargetIteratingMapper.h"
#import "JSONToCommentMapper.h"

@interface JSONToAppMapper : GenericMapper <ReturnMapper> {
    CLGeocoder *geocoder;
}

- (App *)map:(NSDictionary *)json;

@end
