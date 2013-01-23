//
//  AppGetterResponseHandler.m
//  Mapplas
//
//  Created by Belén  on 22/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppGetterResponseHandler.h"

@implementation AppGetterResponseHandler

- (id)initWithModel:(SuperModel *)_model {
    self = [super init];
    if (self) {
        model = _model;
    }
    return self;
}
- (void)requestFinished:(id)JSON {
    NSArray *jsonObjects = JSON;
    JSONToAppMapper *appMapper = [[JSONToAppMapper alloc] init];
    
    App *app = nil;
    AppOrderedList *list = [[AppOrderedList alloc] init];
    for (int i=0; i < jsonObjects.count; i++) {
        app = [appMapper map:[jsonObjects objectAtIndex:i]];
        [list addObject:app];
    }
    
    [model setAppList:list];
}

- (void)requestFinishedWithErrors:(NSError *)error andReponse:(id)JSON {
    NSLog(@"Response delegate error, %@, %@", [error description], JSON);
}

@end
