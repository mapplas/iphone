//
//  RatingHelper.h
//  Mapplas
//
//  Created by Belén  on 05/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "DYRateView.h"
#import "App.h"

@interface RatingHelper : NSObject

- (DYRateView *)getRatingViewForView:(UIView *)_view andApp:(App *)_app;
- (NSString *)getRatingTextForApp:(App *)_app;
- (NSString *)getText:(int)value;

@end
