//
//  TextViewViewController.m
//  Mapplas
//
//  Created by Belén  on 19/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "TextViewViewController.h"

@interface TextViewViewController ()

@end

@implementation TextViewViewController

@synthesize textView;

- (id)initWithTextToShow:(NSString *)text_to_show {
    self = [super init];
    if (self) {
        textToShow = text_to_show;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.text = textToShow;
}


@end
