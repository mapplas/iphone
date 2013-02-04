//
//  AppDetailCommentsViewController.m
//  Mapplas
//
//  Created by Belén  on 01/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppDetailCommentsViewController.h"

@interface AppDetailCommentsViewController ()
- (void)showComments:(id)sender;
@end

@implementation AppDetailCommentsViewController

@synthesize table;

@synthesize headerSection;

@synthesize commentCell;

- (id)initWithApp:(App *)_app {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        app = _app;
        buttonSelected = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    comments = app.auxCommentsArray;
}


#pragma mark - Private mehtods
- (void)showComments:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    if (button.selected) {
        buttonSelected = NO;
    }
    else {
        buttonSelected = YES;
    }
    
    [self.table clearsContextBeforeDrawing];
    [self.table reloadData];
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {    
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *headerView = self.headerSection;
    [headerView setUserInteractionEnabled:YES];
    
    UILabel *headerTitle = [[UILabel alloc]initWithFrame:CGRectMake(5, 15, 225, 20)];
    [headerTitle setBackgroundColor:[UIColor clearColor]];
    [headerTitle setFont:[UIFont fontWithName:@"System" size:20]];
    [headerTitle setTextColor:[UIColor colorWithRed:33.0f/255.0f green:33.0f/255.0f blue:33.0f/255.0f alpha:1]];
    [headerTitle setText:[NSString stringWithFormat:@"%@ (%d)", NSLocalizedString(@"app_detail_comment_list_title", @"App detail - comments list header text"), [app.auxTotalComments intValue]]];
    [headerView addSubview:headerTitle];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(275, 5, 40, 40);
    [button addTarget:self action:@selector(showComments:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"ic_arrow_com.png"] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:@"disclosure.png"] forState:UIControlStateSelected];
    [headerView addSubview:button];
   
    return  headerView;
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (buttonSelected) {
        return [app.auxTotalComments integerValue];
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *simpleTableIdentifier = @"CommentTableItem";
    UITableViewCell *cell = self.commentCell;
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
//    if (cell == nil) {
//        cell = self.commentCell;
//    }
    return cell;
}

@end
