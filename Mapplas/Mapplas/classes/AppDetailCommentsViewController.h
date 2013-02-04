//
//  AppDetailCommentsViewController.h
//  Mapplas
//
//  Created by Belén  on 01/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App.h"
#import "Comment.h"

@interface AppDetailCommentsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    App *app;
    
    NSMutableArray *comments;
    BOOL buttonSelected;
}

@property (nonatomic, strong) IBOutlet UITableView *table;

@property (nonatomic, strong) IBOutlet UIView *headerSection;

@property (nonatomic, strong) IBOutlet UITableViewCell *commentCell;

- (id)initWithApp:(App *)_app;

@end
