//
//  AppRateRequestResponseHandler.h
//  Mapplas
//
//  Created by Belén  on 05/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenericRequestHandler.h"

@interface AppRateRequestResponseHandler : NSObject <GenericRequestHandler> {
    UIView *viewToShowToast;
}

- (id)initWithView:(UIView *)_view;

@end
