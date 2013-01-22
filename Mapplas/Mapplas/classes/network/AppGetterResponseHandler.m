//
//  AppGetterResponseHandler.m
//  Mapplas
//
//  Created by Belén  on 22/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppGetterResponseHandler.h"

@implementation AppGetterResponseHandler

- (void)requestFinished:(id)JSON {
    NSLog(@"REQUEST FINISHED");
    NSDictionary *jsonData = JSON;
}

- (void)requestFinishedWithErrors:(NSError *)error andReponse:(id)JSON {
    NSLog(@"Response delegate error, %@, %@", [error description], JSON);
}

@end
