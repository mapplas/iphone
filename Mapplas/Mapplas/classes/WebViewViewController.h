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
    NSString *url;
    BOOL webFinished;
}

@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

- (id)initWithUrl:(NSString *)_url;

@end
