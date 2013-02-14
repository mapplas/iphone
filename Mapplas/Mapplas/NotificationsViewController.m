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
@end

@implementation NotificationsViewController

@synthesize tableView;

- (id)initWithModel:(SuperModel *)_model {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        model = _model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Set notifications as shown
    NotificationTable *table = [[NotificationTable alloc] init];
    [table setNotificationsAsShown];
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
    return model.notificationList.list.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"header";
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

@end
