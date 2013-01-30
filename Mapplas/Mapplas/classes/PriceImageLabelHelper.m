//
//  PriceImageLabelHelper.m
//  Mapplas
//
//  Created by Belén  on 30/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "PriceImageLabelHelper.h"

@implementation PriceImageLabelHelper

- (id)initWithApp:(App *)_app {
    self = [super init];
    if (self) {
        app = _app;
    }
    return self;
}

- (UIImage *)getImage {
    if ([app.appPrice isEqualToString:@"0"]) {
        return [UIImage imageNamed:@"ic_badge_free.png"];
    }
    else {
        return [UIImage imageNamed:@"ic_badge_price.png"];
    }
}

- (NSString *)getPriceText {
    NSString *currency = @"";
    if (app.locationCurrency == EURO) {
        currency = NSLocalizedString(@"currency_euro", @"Euro currency");
    }
    else {
        currency = NSLocalizedString(@"currency_dollar", @"Dollar currency");
    }
    
    if ([app.appPrice isEqualToString:@"0"]) {
        return NSLocalizedString(@"free_text", @"Free");
    }
    else {
        return [NSString stringWithFormat:@"%@ %@", currency, app.appPrice];
    }
}

@end
