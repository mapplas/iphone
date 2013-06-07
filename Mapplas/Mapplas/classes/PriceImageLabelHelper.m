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
    if ([app.type isEqualToString:@"HTML"]) {
        return [UIImage imageNamed:@"ic_badge_html5.png"];
    }
    else if (![app.appUrlScheme isEqualToString:@""] && [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://", app.appUrlScheme]]]){
        return [UIImage imageNamed:@"ic_badge_launch.png"];
    }
    else {
        if ([app.appPrice floatValue] == 0.0) {
            return [UIImage imageNamed:@"ic_badge_free.png"];
        }
        else {
            return [UIImage imageNamed:@"ic_badge_price.png"];
        }
    }
}

- (NSString *)getPriceText {
    NSString *currency = @"";
    
    if (![app.appUrlScheme isEqualToString:@""]) {
        return currency;
    }
    else {
        if ([app.currencyCode isEqualToString:@"EUR"]) {
            currency = NSLocalizedString(@"currency_euro", @"Euro currency");
        }
        else {
            currency = NSLocalizedString(@"currency_dollar", @"Dollar currency");
        }
        
        if (![app.type isEqualToString:@"HTML"]) {
            if ([app.appPrice floatValue] == 0.0) {
                return NSLocalizedString(@"free_text", @"Free");
            }
            else {
                return [NSString stringWithFormat:@"%@ %@", currency, app.appPrice];
            }
        } else {
            return @"";
        }
    }
}

@end
