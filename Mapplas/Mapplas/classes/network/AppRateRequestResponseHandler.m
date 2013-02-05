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
    Toast *okToast = [[Toast alloc] initAndShowIn:viewToShowToast withText:NSLocalizedString(@"toast_after_rate_ok", @"Toast after send rate info - OK")];
    [okToast show];
}

- (void)requestFinishedWithErrors:(NSError *)error andReponse:(id)JSON {
    Toast *okToast = [[Toast alloc] initAndShowIn:viewToShowToast withText:NSLocalizedString(@"toast_after_rate_nok", @"Toast after send rate info - NOK")];
    [okToast show];
}

@end
