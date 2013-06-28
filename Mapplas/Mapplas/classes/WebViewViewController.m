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
//- (void)startTimer;
//- (void)hideAndShowNavigationBar;
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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"nav_bar_button_cancel", @" Navigation bar button - Cancel") style:UIBarButtonSystemItemCancel target:self action:@selector(pop)];
    
//    self.webView.scrollView.delegate = self;
    
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
//        [self startTimer];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    Toast *errorToast = [[Toast alloc] initAndShowIn:self.view withText:@"Developer website is not avaliable"];
    [errorToast show];
    [self pop];
}

//- (void)startTimer {
//    [NSTimer scheduledTimerWithTimeInterval:3.0f
//                                     target:self
//                                   selector:@selector(hideAndShowNavigationBar)
//                                   userInfo:nil
//                                    repeats:NO];
//}

- (void)loadUrl {
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:requestObj];
}

//- (void)hideAndShowNavigationBar {
//    BOOL navBarState = [self.navigationController isNavigationBarHidden];
//    
//    CATransition *pushTransition = [CATransition animation];
//    pushTransition.type = kCATransitionReveal;
//    pushTransition.duration = .8;
//    
//    [self.navigationController.navigationBar.layer addAnimation:pushTransition forKey:@""];
//	[self.navigationController setNavigationBarHidden:!navBarState animated:NO];
//}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGPoint scrollPosition = scrollView.contentOffset;
//
//    if (scrollPosition.y == 0) {
//        [self hideAndShowNavigationBar];
//        [self startTimer];
//    }
//}

@end
