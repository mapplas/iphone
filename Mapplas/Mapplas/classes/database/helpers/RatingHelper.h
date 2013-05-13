//
//  RatingHelper.h
//  Mapplas
//
//  Created by Belén  on 13/05/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "App.h"

@interface RatingHelper : NSObject <UIAlertViewDelegate> {
    App *app;
}

- (void)rateApp:(App *)_app;

@end
