//
//  PriceImageLabelHelper.h
//  Mapplas
//
//  Created by Belén  on 30/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "App.h"

@interface PriceImageLabelHelper : NSObject {
    App *app;
}

- (id)initWithApp:(App *)_app;
- (UIImage *)getImage;
- (NSString *)getPriceText;

@end
