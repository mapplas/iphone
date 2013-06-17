//
//  WebViewViewController.h
//  Mapplas
//
//  Created by Belén  on 28/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "App.h"
#import "Toast.h"

@interface WebViewViewController : UIViewController <UIWebViewDelegate> {
    App *app;
    BOOL webFinished;
}

@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

- (id)initWithApp:(App *)_app;

@end
