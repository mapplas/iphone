//
//  WebViewViewController.m
//  Mapplas
//
//  Created by Belén  on 28/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "WebViewViewController.h"

@interface WebViewViewController ()

@end

@implementation WebViewViewController

@synthesize webView;
@synthesize activityIndicator;

- (id)initWithApp:(App *)_app {
    self = [super init];
    if (self) {
        app = _app;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"nav_bar_button_cancel", @" Navigation bar button - Cancel") style:UIBarButtonSystemItemCancel target:self action:@selector(pop)];
    
    [self.activityIndicator startAnimating];
    
    NSURL *url = [NSURL URLWithString:app.appUrl];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

#pragma mark - Private methods
- (void)pop {
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
    [self.activityIndicator removeFromSuperview];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    Toast *errorToast = [[Toast alloc] initAndShowIn:self.view withText:@"Developer website is not avaliable"];
    [errorToast show];
    [self pop];
}

@end
