//
//  RatingHelper.m
//  Mapplas
//
//  Created by Belén  on 05/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "RatingHelper.h"

@implementation RatingHelper

- (DYRateView *)getRatingViewForView:(UIView *)_view andApp:(App *)_app {
    DYRateView *rateView = [[DYRateView alloc] initWithFrame:CGRectMake(_view.frame.origin.x, _view.frame.origin.y + 5, _view.frame.size.width, _view.frame.size.height)];
    rateView.rate = [_app.auxTotalRate doubleValue];
    rateView.alignment = RateViewAlignmentCenter;
    return rateView;
}

- (NSString *)getRatingTextForApp:(App *)_app {
    return [self getText:(int)ceil([_app.auxTotalRate doubleValue])];
}

- (NSString *)getText:(int)value {
    NSString *ratingText = NSLocalizedString(@"app_rating_unrated", @"Rating - unrated app");

    switch (value) {
        case 1:
            ratingText = NSLocalizedString(@"app_rating_poor_app", @"Rating - poor app");
            break;
        case 2:
            ratingText = NSLocalizedString(@"app_rating_below_avg_app", @"Rating - below average app");
            break;
        case 3:
            ratingText = NSLocalizedString(@"app_rating_avg_app", @"Rating - average app");
            break;
        case 4:
            ratingText = NSLocalizedString(@"app_rating_above_avg_app", @"Rating - above average app");
            break;
        case 5:
            ratingText = NSLocalizedString(@"app_rating_excellent_app", @"Rating - excellent app");
            break;
        default:
            break;
    }
    return ratingText;
}

@end
