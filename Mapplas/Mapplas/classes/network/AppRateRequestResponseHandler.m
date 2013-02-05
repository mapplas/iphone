//
//  AppRateRequestResponseHandler.m
//  Mapplas
//
//  Created by Belén  on 05/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppRateRequestResponseHandler.h"

@implementation AppRateRequestResponseHandler

- (id)initWithView:(UIView *)_view {
    self = [super init];
    if (self) {
        viewToShowToast = _view;
    }
    return self;
}

- (void)requestFinished:(id)JSON {
    
}

- (void)requestFinishedWithErrors:(NSError *)error andReponse:(id)JSON {
    
}

@end
