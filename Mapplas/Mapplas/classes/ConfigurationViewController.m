//
//  ConfigurationViewController.m
//  Mapplas
//
//  Created by Belén  on 19/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "ConfigurationViewController.h"

@interface ConfigurationViewController ()

@end

@implementation ConfigurationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - UITableViewDataSource delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *groupedTableIdentifier = @"GroupedCellItem";
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:groupedTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:groupedTableIdentifier];
    }
        
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    if (indexPath.row == 0) {
        cell.textLabel.text = NSLocalizedString(@"conf_screen_terms_title", @"Configuration screen terms title");
    }
    else {
        cell.textLabel.text = NSLocalizedString(@"conf_screen_policy_title", @"Configuration screen policy title");
    }
        
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return groupedCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.view) {
        if (indexPath.row == 0) {
            TextViewViewController *vc = [[TextViewViewController alloc] initWithTextToShow:NSLocalizedString(@"conf_screen_terms_text", @"Configuration screen terms text")];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else {
            TextViewViewController *vc = [[TextViewViewController alloc] initWithTextToShow:NSLocalizedString(@"conf_screen_policy_text", @"Configuration screen policy text")];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
