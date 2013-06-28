//
//  WebViewViewController.m
//  Mapplas
//
//  Created by Belén  on 28/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "WebViewViewController.h"
#import "NavigationControllerStyler.h"

@interface WebViewViewController ()
- (void)loadUrl;
@end

@implementation WebViewViewController

@synthesize webView;
@synthesize activityIndicator;

- (id)initWithUrl:(NSString *)_url{
    self = [super init];
    if (self) {
        url = _url;
        webFinished = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NavigationControllerStyler *styler = [[NavigationControllerStyler alloc] init];
    [styler style:self.navigationController.navigationBar andItem:self.navigationItem];
    NSDictionary *dict = [styler styleNavBarButtonToBlue:YES];
    [[UIBarButtonItem appearance] setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"nav_bar_button_cancel", @" Navigation bar button - Cancel") style:UIBarButtonSystemItemCancel target:self action:@selector(pop)];
    
        
    [self.activityIndicator startAnimating];
    
    [self loadUrl];
}

#pragma mark - Private methods
- (void)pop {
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (!webFinished) {
        webFinished = YES;
        [self.activityIndicator stopAnimating];
        [self.activityIndicator removeFromSuperview];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    Toast *errorToast = [[Toast alloc] initAndShowIn:self.view withText:@"Developer website is not avaliable"];
    [errorToast show];
    [self pop];
}

- (void)loadUrl {
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:requestObj];
}

@end
