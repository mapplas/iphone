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
- (void)orderTableData;
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
        orderedTableDataKeys = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NotificationTable *notificationTable = [[NotificationTable alloc] init];
    tableData = [notificationTable getNotificationsSeparatedByLocation];
    [self orderTableData];

    // Set notifications as shown
    NotificationTable *table = [[NotificationTable alloc] init];
    [table setNotificationsAsShown];
    
    [self initializeNotificationSet];
    [self setAuxAppToNotificationsAndReloadModelData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:NO];
    
    UIImage *notificationImage = [UIImage imageNamed:@"ic_menu_notifications.png"];
    appsController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:notificationImage style:UIBarButtonItemStyleBordered target:appsController action:@selector(pushNotificationScreen)];
    
    [self imgSlideInFromLeft:self.navigationController.view];
}

-(void)imgSlideInFromLeft:(UIView *)view {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype =kCATransitionFromRight;
    transition.delegate = self;
    [view.layer addAnimation:transition forKey:nil];
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
    NotificationTable *table = [[NotificationTable alloc] init];
    [table setNotificationsAsSeen:[model.notificationList.list objectAtIndex:indexPath.row]];
    
    Notification *notif = [model.notificationList.list objectAtIndex:indexPath.row];
    AppDetailViewController *detailViewController = [[AppDetailViewController alloc] initWithApp:notif.auxApp user:model.user model:model andLocation:model.currentLocation];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([notificationSet objectAtIndex:indexPath.row] == [NSNumber numberWithInt:typeHighlightedItem]) {
        [cell setBackgroundColor:[UIColor colorWithRed:153.f/255.f green:204.f/255.f blue:255.f/255.f alpha:1]];
    }
    else {
        [cell setBackgroundColor:[UIColor clearColor]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return model.notificationList.list.count;
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
    BOOL highlighted = NO;
    
    for (NSNumber *key in orderedTableDataKeys) {
        highlighted = !highlighted;
        NSMutableArray *notifs = [tableData objectForKey:key];
        for (Notification *current in notifs) {
            if (highlighted) {
                [notificationSet addObject:[NSNumber numberWithInt:typeHighlightedItem]];
            }
            else {
                [notificationSet addObject:[NSNumber numberWithInt:typeNormalItem]];
            }
        }
    }
}

- (void)setAuxAppToNotificationsAndReloadModelData {
    [model.notificationList reset];
    
    NSEnumerator *keyEnumerator = [tableData keyEnumerator];
    
    for (NSNumber *key in keyEnumerator) {
        NSMutableArray *value = [tableData objectForKey:key];
        NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"dateInMs" ascending:NO];
        [value sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
        
        for (Notification *currentNotif in value) {
            NSString *appId = currentNotif.appId;
            currentNotif.auxApp = [self getAppForId:appId];
            
            [model.notificationList addNotification:currentNotif];
        }
    }
}

- (void)orderTableData {
    NSEnumerator *keyEnumerator = [tableData keyEnumerator];
    for (NSNumber *key in keyEnumerator) {
        [orderedTableDataKeys addObject:key];
    }
    
    NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
    [orderedTableDataKeys sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
}

@end