//
//  NotificationsViewController.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "NotificationTable.h"
#import "NotificationCell.h"
#import "SuperModel.h"
#import "AppDetailViewController.h"

#define cellHeight 72;

typedef enum {
    typeHighlightedItem,
    typeNormalItem
} CellType;

@interface NotificationsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    SuperModel *model;
    UIViewController *appsController;
    
    NSMutableDictionary *tableData;
    NSMutableArray *notificationSet;
    NSMutableArray *orderedTableDataKeys;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;

//- (id)initWithModel:(SuperModel *)_model appsViewController:(UIViewController *)apps_controller;

@end
