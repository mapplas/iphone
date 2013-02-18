//
//  NotificationsViewController.m
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "NotificationsViewController.h"

@interface NotificationsViewController ()
- (App *)getAppForId:(NSString *)appId;
- (void)initializeNotificationSet;
@end

@implementation NotificationsViewController

@synthesize tableView;

- (id)initWithModel:(SuperModel *)_model appsViewController:(UIViewController *)apps_controller {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        model = _model;
        appsController = apps_controller;
        
        tableData = [[NSMutableDictionary alloc] init];
        notificationSet = [[NSMutableArray alloc] init];
        
        currentSectionText = @"";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NotificationTable *notificationTable = [[NotificationTable alloc] init];
    tableData = [notificationTable getNotificationsSeparatedByLocation];

    // Set notifications as shown
    NotificationTable *table = [[NotificationTable alloc] init];
    [table setNotificationsAsShown];
    
    [self initializeNotificationSet];
    [self setAuxAppToNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    UIImage *notificationImage = [UIImage imageNamed:@"ic_menu_notifications.png"];
    appsController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:notificationImage style:UIBarButtonItemStyleBordered target:appsController action:@selector(pushNotificationScreen)];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"NotificationTableItem";
    
    NotificationCell *cell = [table dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NotificationCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Notification *notification = [model.notificationList.list objectAtIndex:indexPath.row];
    [cell setApp:[self getAppForId:notification.appId]];
    [cell setNotification:notification];

    [cell loadData];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return sectionHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSEnumerator *keyEnumerator = tableData.keyEnumerator;
    int count = 0;
    for (NSNumber *key in keyEnumerator) {
        if (count == section) {
            return [[tableData objectForKey:key] count];
        }
        count++;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tableData.keyEnumerator.allObjects.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSEnumerator *keyEnumerator = tableData.keyEnumerator;
    int count = 0;
    CLLocation *location;
    for (NSNumber *key in keyEnumerator) {
        if (count == section) {
            NSMutableArray *notifications = [tableData objectForKey:key];
            NSString *currentLocation = [[notifications objectAtIndex:0] currentLocation];
            NSArray *locationSplitted = [currentLocation componentsSeparatedByString:@","];
            
            CLLocationDegrees latitudeDegree = (CLLocationDegrees)[locationSplitted[0] doubleValue];
            CLLocationDegrees longitudeDegree = (CLLocationDegrees)[locationSplitted[1] doubleValue];
            location = [[CLLocation alloc] initWithLatitude:latitudeDegree longitude:longitudeDegree];
        }
    }
    [self doReverseGeocoding:location];
    
    return currentSectionText;
}

#pragma mark - Private methods
- (App *)getAppForId:(NSString *)appId {
    for (App *app in model.appList.list) {
        if ([app.appId isEqualToString:appId]) {
            return app;
        }
    }
    return nil;
}

- (void)initializeNotificationSet {
    NSEnumerator *keyEnumerator = [tableData keyEnumerator];
    
    for (NSNumber *key in keyEnumerator) {
        [notificationSet addObject:[NSNumber numberWithInt:typeSeparator]];
        
        NSMutableArray *notifs = [tableData objectForKey:key];
        for (Notification *current in notifs) {
            [notificationSet addObject:[NSNumber numberWithInt:typeItem]];
        }
    }
}

- (void)setAuxAppToNotifications {
    NSEnumerator *keyEnumerator = [tableData keyEnumerator];
    
    for (NSNumber *key in keyEnumerator) {
        NSMutableArray *value = [tableData objectForKey:key];
        
        for (Notification *currentNotif in value) {
            NSString *appId = currentNotif.appId;
            currentNotif.auxApp = [self getAppForId:appId];
        }
    }
}

#pragma mark - Reverse geocoding
- (void)doReverseGeocoding:(CLLocation *)location {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];

    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error){
            currentSectionText = @"error";
            return;
        }
        
        if(placemarks && placemarks.count > 0) {
            //do something
            CLPlacemark *topResult = [placemarks objectAtIndex:0];
            //            NSString *sub = [topResult subThoroughfare];
            //            NSString *thr = [topResult thoroughfare];
            //            NSString *local = [topResult locality];
            NSString *addressTxt = [NSString stringWithFormat:@"%@ %@, %@",
                                    [topResult subThoroughfare],[topResult thoroughfare],
                                    [topResult locality]];
            
            currentSectionText = addressTxt;
        }
    }];
}

@end
