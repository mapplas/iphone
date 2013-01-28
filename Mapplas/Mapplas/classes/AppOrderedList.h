//
//  AppOrderedList.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "App.h"
#import <CoreLocation/CoreLocation.h>

@interface AppOrderedList : NSObject {
    NSMutableArray *_list;
    NSString *_currentLocation;
}

@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, strong) NSString *currentLocation;

- (id)init;
- (void)addObject:(App *)app;
- (NSUInteger)count;
- (App *)objectAtIndex:(NSUInteger)index;
- (void)sort;

@end
