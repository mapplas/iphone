//
//  NotificationsViewController.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationTable.h"
#import "NotificationCell.h"
#import "SuperModel.h"

#define cellHeight 72;
#define sectionHeight 30;

typedef enum {
    typeItem,
    typeSeparator
} CellType;

@interface NotificationsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    SuperModel *model;
    
    NSMutableDictionary *tableData;
    NSMutableArray *notificationSet;
    
    NSString *currentSectionText;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;

- (id)initWithModel:(SuperModel *)_model;

@end
