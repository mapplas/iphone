//
//  AppDetailRequestHandler.h
//  Mapplas
//
//  Created by Belén  on 13/05/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenericRequestHandler.h"
#import "App.h"
#import "JSONToAppDetailMapper.h"

@class AppDetailViewController;

@interface AppDetailRequestHandler : NSObject <GenericRequestHandler> {
    AppDetailViewController *viewController;
    App *app;
}

- (id)initWithViewController:(AppDetailViewController *)view_controller app:(App *)_app;

@end
