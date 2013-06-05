//
//  RatingHelper.m
//  Mapplas
//
//  Created by Belén  on 13/05/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "RatingHelper.h"

@implementation RatingHelper

- (void)rateApp:(App *)_app {
    app = _app;
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:NSLocalizedString(@"review_alert_title", @"Review alert title")
                          message:[NSString stringWithFormat:@"%@ %@?", NSLocalizedString(@"review_alert_message", @"Review alert message"), app.name]
                          delegate:self
                          cancelButtonTitle:NSLocalizedString(@"review_alert_ok_button", @"Review alert ok button title")
                          otherButtonTitles:NSLocalizedString(@"review_alert_cancel_button", @"Review alert cancel button title"), nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSString *url = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", app.appId];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

@end
