//
//  AppsViewController.m
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppsViewController.h"
#import "NSString+UUID.h"
#import "AppDelegate.h"
#import "CoreLocationManagerConfigurator.h"

@interface AppsViewController ()

@end

@implementation AppsViewController

@synthesize userIdentRequest = _userIdentRequester;
@synthesize model = _model;
@synthesize aroundRequester = _aroundRequester;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initializeNavigationBarButtons {
    UIImage *notificationImage = [UIImage imageNamed:@"ic_menu_notifications.png"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:notificationImage style:UIBarButtonItemStyleBordered target:self action:nil];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    
    UIImage *profileImage = [UIImage imageNamed:@"ic_menu_profile.png"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:profileImage style:UIBarButtonItemStyleBordered target:self action:nil];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeNavigationBarButtons];
    
    self.model = [[SuperModel alloc] init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uniqueCode = [defaults objectForKey:UUID_USER_DEFAULTS_KEY];
    uniqueCode = [uniqueCode stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [self.model setCurrentImei:uniqueCode];
    
    // Identify user through server
    self.userIdentRequest = [[UserIdentificationRequest alloc] initWithSuperModel:self.model];
    [self.userIdentRequest doRequest];
    
    // Get phone's application list
    
    // Create localization requester and start searching!
    CLLocationManager *coreLocationManager = [CLLocationManager alloc];
    CoreLocationManagerConfigurator *configurator = [[CoreLocationManagerConfigurator alloc] init];
    
    LocationManager *locationManager = [[LocationManager alloc] initWithLocationManager:coreLocationManager managerConfigurator:configurator listener:nil];
    self.aroundRequester = [[AroundRequester alloc] initWithLocationManager:locationManager andModel:self.model];
    [self.aroundRequester startRequesting];
}



@end
