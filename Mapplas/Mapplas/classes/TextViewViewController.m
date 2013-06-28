//
//  TextViewViewController.m
//  Mapplas
//
//  Created by Belén  on 19/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "TextViewViewController.h"
#import "NavigationControllerStyler.h"

@implementation TextViewViewController

@synthesize webView;

- (id)initWithTextToShow:(NSString *)text_to_show {
    self = [super init];
    if (self) {
        textToShow = text_to_show;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NavigationControllerStyler *styler = [[NavigationControllerStyler alloc] init];
    [styler style:self.navigationController.navigationBar andItem:self.navigationItem];
    
    [webView loadHTMLString:textToShow baseURL:nil];
}


@end
