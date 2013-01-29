//
//  InfiniteScrollManager.h
//  Mapplas
//
//  Created by Belén  on 29/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppOrderedList.h"
#import "SuperModel.h"

#define NUMBER_OF_APPS 10

@interface InfiniteScrollManager : NSObject {
    NSMutableArray *list;
}

- (id)initWithAppList:(NSMutableArray *)app_list;
- (NSUInteger)getMaxCount;
- (BOOL)isRestZero;
- (NSUInteger)getRest;
- (NSMutableArray *)getFirstXNumberOfApps:(SuperModel *)_model;

@end
