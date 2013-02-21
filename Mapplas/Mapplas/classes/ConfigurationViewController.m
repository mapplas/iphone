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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *groupedTableIdentifier = @"GroupedCellItem";
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:groupedTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:groupedTableIdentifier];
    }
        
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = NSLocalizedString(@"conf_screen_terms_title", @"Configuration screen terms title");
            break;
            
        case 1:
            cell.textLabel.text = NSLocalizedString(@"conf_screen_policy_title", @"Configuration screen policy title");
            break;
            
        case 2:
            cell.textLabel.text = NSLocalizedString(@"conf_screen_contact_title", @"Configuration screen contact title");
            break;

        default:
            break;
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
        else if(indexPath.row == 1) {
            TextViewViewController *vc = [[TextViewViewController alloc] initWithTextToShow:NSLocalizedString(@"conf_screen_policy_text", @"Configuration screen policy text")];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if(indexPath.row == 2) {
            
            MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
            [controller setMailComposeDelegate:self];
            
            NSString *mail = NSLocalizedString(@"config_contact_us_email", @"Config contact us email");
            [controller setToRecipients:[NSArray arrayWithObject:mail]];
            NSString *subject = NSLocalizedString(@"config_contact_us_email_subject", @"Config contact us email subject");
            [controller setSubject:subject];
            
            [self presentModalViewController:controller animated:YES];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// Developer email delegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"share_email_error", @"Email sharing error") delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"ok_message", @"OK message"), nil];
    UIAlertView *okAlert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"share_email_ok_message", @"Email sharing ok message") delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"ok_message", @"OK message"), nil];
    
	switch (result) {
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultFailed:
            [errorAlert show];
			break;
		case MFMailComposeResultSent:
            [okAlert show];
			break;
		default:
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}

@end
