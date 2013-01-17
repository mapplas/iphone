//
//  AppsViewController.m
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppsViewController.h"

@interface AppsViewController ()

@end

@implementation AppsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIImage *navigationBarBackground = [UIImage imageNamed:@"@bgd_menu.png"];
    [[UINavigationBar appearance] setBackgroundImage:navigationBarBackground forBarMetrics:UIBarMetricsDefault];
}

@end
