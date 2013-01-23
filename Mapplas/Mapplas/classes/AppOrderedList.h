//
//  AppOrderedList.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "App.h"

@interface AppOrderedList : NSObject {
    NSMutableArray *_list;
}

@property (nonatomic, strong) NSMutableArray *list;

- (id)init;
- (void)addObject:(App *)app;
- (NSUInteger)count;
- (App *)objectAtIndex:(NSUInteger)index;

@end
