//
//  AppOrderedList.m
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppOrderedList.h"

@implementation AppOrderedList

@synthesize list = _list;
@synthesize currentLocation = _currentLocation;

- (id)init {
    self = [super init];
    if (self) {
        self.list = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addObject:(App *)app {
    [self.list addObject:app];
}

- (void)deleteApp:(App *)app {
    [self.list removeObject:app];
}

- (NSUInteger)count {
    return self.list.count;
}

- (App *)objectAtIndex:(NSUInteger)index {
    return [self.list objectAtIndex:index];
}

- (void)sort {
    NSArray *sortedArray = [self.list sortedArrayUsingComparator:
                            ^NSComparisonResult(id obj1, id obj2)
                            {
                                App *app1 = obj1;
                                App *app2 = obj2;
                                
                                if([app1.auxPin intValue] == 1 && [app2.auxPin intValue] == 0) {
                                    return NSOrderedAscending;
                                }
                                else if ([app1.auxPin intValue] == 0 && [app2.auxPin intValue] == 1) {
                                    return NSOrderedDescending;
                                }
                                else {
                                    NSArray *arrayLocation = [self.currentLocation componentsSeparatedByString:@","];
                                    
                                    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:(CLLocationDegrees)[[arrayLocation objectAtIndex:0] doubleValue] longitude:(CLLocationDegrees)[[arrayLocation objectAtIndex:1] doubleValue]];
                                    
                                    CLLocation *locationApp1 = [[CLLocation alloc] initWithLatitude:(CLLocationDegrees)[app1.latitude doubleValue] longitude:(CLLocationDegrees)[app1.longitude doubleValue]];
                                    double distance1 = [currentLocation distanceFromLocation:locationApp1] / 1000;

                                    CLLocation *locationApp2 = [[CLLocation alloc] initWithLatitude:(CLLocationDegrees)[app2.latitude doubleValue] longitude:(CLLocationDegrees)[app2.longitude doubleValue]];
                                    double distance2 = [currentLocation distanceFromLocation:locationApp2] / 1000;
                                    
                                    if (distance1 > distance2) {
                                        return NSOrderedDescending;
                                    }
                                    else if (distance2 > distance1) {
                                        return NSOrderedAscending;
                                    }
                                    else {
                                        return NSOrderedSame;
                                    }
                                }
                            }];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:sortedArray];
    self.list = array;
}

- (NSMutableArray *)getArray {
    return self.list;
}

- (NSUInteger)numberOfPins {
    
    NSUInteger pinnedApps = 0;
    NSUInteger i = 0;
    
    while (i < self.list.count) {
        App *app = [self.list objectAtIndex:i];
        if ([app.auxPin intValue] == 1) {
            pinnedApps ++;
        }
        i++;
    }
    return pinnedApps;
}

@end
