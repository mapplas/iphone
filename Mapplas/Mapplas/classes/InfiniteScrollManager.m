//
//  InfiniteScrollManager.m
//  Mapplas
//
//  Created by Belén  on 29/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "InfiniteScrollManager.h"

@implementation InfiniteScrollManager

- (id)initWithAppList:(NSMutableArray *)app_list {
    self = [super init];
    if (self) {
        list = app_list;
    }
    return self;
}

- (void)resetAppList:(NSMutableArray *)app_list {
    list = app_list;
}

- (NSUInteger)getMaxCount {
    if (list.count % NUMBER_OF_APPS == 0) {
        return list.count / NUMBER_OF_APPS;
    }
    else {
        return (list.count /NUMBER_OF_APPS) + 1;
    }
}

- (BOOL)isRestZero {
    if (list.count % NUMBER_OF_APPS == 0) {
        return YES;
    }
    else {
        return NO;
    }
}

- (NSUInteger)getRest {
    return list.count % NUMBER_OF_APPS;
}

- (NSMutableArray *)getFirstXNumberOfApps:(SuperModel *)_model {
    NSMutableArray *appList = [[NSMutableArray alloc] init];
    int maxIndex = NUMBER_OF_APPS;
    
    if (_model.appList.count < NUMBER_OF_APPS) {
        maxIndex = _model.appList.count;
    }
    
    for (int i=0; i < maxIndex; i++) {
        [appList addObject:[_model.appList objectAtIndex:i]];
    }
    return appList;
}

@end
