//
//  UserViewController.m
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserViewController.h"
#import "UserPinUpsRequester.h"
#import "UserBlocksRequester.h"

@interface UserViewController ()
- (void)setTextToNavigationButton:(NSString *)title;
- (void)configureLayout;
- (int)checkUserState;
- (void)changeLayoutComponents:(int)user_state;
- (void)actionButtonSelector;
- (void)checkEmptyTable:(NSUInteger)cells;
@end

@implementation UserViewController

@synthesize scroll;

@synthesize userImageView, userImageButton, userImageImageView;
@synthesize userInfo;
@synthesize userInfoUnpressed, userInfoUnpressedName, userInfoUnpressedEmail, userInfoUnpressedWarningText;
@synthesize userInfoPressed, userInfoPressedNameEditText, userInfoPressedEmailEditText, userInfoPressedButtonOk;
@synthesize listHeaderView, segmentedControl;
@synthesize list;
@synthesize listEmptyView, listEmptyViewLabel;
@synthesize configTable;

- (id)initWithModel:(SuperModel *)_super_model {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        model = _super_model;
        signInInputsVisible = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ImageLoaderFactory *factory = [[ImageLoaderFactory alloc] init];
    AsynchronousImageDownloader *downloader = [[AsynchronousImageDownloader alloc] initWithDelegate:nil];
    imageLoader = [factory createUsingCacheFolderWithDownloader:downloader];
    
    NSMutableArray *viewsToShow = [[NSMutableArray alloc] initWithObjects:self.userImageView, self.userInfo, self.listHeaderView, self.list, self.configTable, nil];
    scrollManager = [[MutableScrollViewOfViews alloc] initWithViews:viewsToShow inScrollView:self.scroll delegate:self];
    [self.userInfo addSubview:self.userInfoUnpressed];
    
    [self configureLayout];
    
    pinUpsRequester = [[UserPinUpsRequester alloc] init];
    [pinUpsRequester doRequestWithUser:model.user viewController:self];
    
    blocksRequester = [[UserBlocksRequester alloc] init];
    [blocksRequester doRequestWithUser:model.user viewController:self];
    
    [scrollManager organize];
}

#pragma mark - User pin ups and blocked requests handler methods 
- (void)requestedDataLoaded {
    [list reloadData];
}

#pragma mark - UITableViewDataSource delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == list) {
        NSMutableArray *loadedList = nil;
        if (self.segmentedControl.selectedSegmentIndex == 0) {
            loadedList = model.user.pinnedApps;
        }
        else {
            loadedList = model.user.blockedApps;
        }
        
        NSUInteger count = loadedList.count;
        NSUInteger tableHeight = count * cellHeight;
        
        CGRect listFrame = CGRectMake(self.list.frame.origin.x, self.list.frame.origin.y, self.list.frame.size.width, tableHeight);
        self.list.frame = listFrame;
        
        [scrollManager organize];
        
        [self checkEmptyTable:count];
        
        return count;
    }
    else {
        if ([self checkUserState] == LOGGED_IN) {
            return 2;
        }
        else {
            return 1;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *pinnedAppsTableIdentifier = @"UserPinsTableItem";
    static NSString *blockedAppsTableIdentifier = @"UserBlocksTableItem";
    static NSString *groupedTableIdentifier = @"GroupedCellItem";
    
    if (tableView == list) {
        if (self.segmentedControl.selectedSegmentIndex == 0) {
            UserListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pinnedAppsTableIdentifier];
            if (cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UserListTableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            [cell setApp:[model.user.pinnedApps objectAtIndex:indexPath.row]];
            [cell setPinnedApps:model.user.pinnedApps];
            [cell setLocation:model.currentLocation];
            [cell setUser:model.user];
            [cell setModelAppOrderedList:model.appList];
            [cell setPositionInList:indexPath.row];
            
            [cell loadData];
            return cell;
            
        }
        else {
            UserBlockedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:blockedAppsTableIdentifier];
            if (cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UserBlockedTableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            [cell setApp:[model.user.blockedApps objectAtIndex:indexPath.row]];
            [cell setBlockedApps:model.user.blockedApps];
            [cell setLocation:model.currentLocation];
            [cell setUser:model.user];
            [cell setModelAppOrderedList:model.appList];
            [cell setPositionInList:indexPath.row];
            
            [cell loadData];
            return cell;
        }
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:groupedTableIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:groupedTableIdentifier];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (indexPath.row == 0) {
            cell.textLabel.text = NSLocalizedString(@"user_footer_config_button_text", @"Footer config button label text");
        }
        else {
            cell.textLabel.text = NSLocalizedString(@"user_footer_sign_out_button_text", @"Footer sign-out button label text");
        }
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == list) {
        return cellHeight;
    }
    else {
        return groupedCellHeight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == configTable) {
        if (indexPath.row == 0) {
            ConfigurationViewController *configVC = [[ConfigurationViewController alloc] init];
            [self.navigationController pushViewController:configVC animated:YES];
        }
        else {
            [self userLogOut];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITextFieldDelegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.userInfoPressedNameEditText]) {
        // Found next responder, so set it.
        [self.userInfoPressedEmailEditText becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO;
}

- (IBAction)segmentedControlIndexChanged {
    [self reloadDataAnimated:YES];
}

#pragma mark - Private methods

- (void)setTextToNavigationButton:(NSString *)title {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(actionButtonSelector)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
}

- (void)actionButtonSelector {
    CATransition *pushTransition = [CATransition animation];
    pushTransition.type = kCATransitionPush;
    
    if (signInInputsVisible) {
        signInInputsVisible = NO;
        pushTransition.subtype = kCATransitionFromLeft;
        [self.userInfo.layer addAnimation:pushTransition forKey:@""];
        [self.userInfo addSubview:self.userInfoUnpressed];
        [self.userInfoPressed removeFromSuperview];
        
        [self setTextToNavigationButton:NSLocalizedString(@"user_action_button_sign_in_text", @"User screen action button sign-in text")];
    }
    else {
        signInInputsVisible = YES;
        pushTransition.subtype = kCATransitionFromRight;
        [self.userInfo.layer addAnimation:pushTransition forKey:@""];
        [self.userInfo addSubview:self.userInfoPressed];
        [self.userInfoUnpressed removeFromSuperview];

        [self setTextToNavigationButton:NSLocalizedString(@"nav_bar_button_cancel", @"Navigation bar button - Cancel")];
    }
}

- (void)configureLayout {
    // User image photo
    UIImage *userImage = [imageLoader loadImageFromCache:@"userPhoto"];
    if (userImage != nil) {
        self.userImageImageView.image = userImage;
    }
    
    // Segmented control button names
    NSString *segmentedControlPinnedText = NSLocalizedString(@"user_screen_segmented_control_pins", @"User screen segmented control pinned title");
    [self.segmentedControl setTitle:segmentedControlPinnedText forSegmentAtIndex:0];
    
    NSString *segmentedControlBlockedText = NSLocalizedString(@"user_screen_segmented_control_blocks", @"User screen segmented control blocks title");
    [self.segmentedControl setTitle:segmentedControlBlockedText forSegmentAtIndex:1];
    
    [self changeLayoutComponents:[self checkUserState]];
}

- (void)changeLayoutComponents:(int)user_state {
    switch (user_state) {
        case SIGN_IN:
            [self setTextToNavigationButton:NSLocalizedString(@"user_action_button_sign_in_text", @"User screen action button sign-in text")];
                        
            self.userInfoUnpressedWarningText.text = NSLocalizedString(@"user_warning_text_sign_in", @"User screen warning text sign-in");
            self.userInfoUnpressedWarningText.hidden = NO;
            
            self.userInfoUnpressedName.hidden = YES;
            self.userInfoUnpressedEmail.hidden = YES;
            
            CGRect newFrame = CGRectMake(self.configTable.frame.origin.x, self.configTable.frame.origin.y, self.configTable.frame.size.width, 64);
            self.configTable.frame = newFrame;
            [self.configTable reloadData];
            
            break;
            
        case LOG_IN:
            [self setTextToNavigationButton:NSLocalizedString(@"user_action_button_log_in_text", @"User screen action button log-in text")];
                        
            self.userInfoUnpressedWarningText.text = NSLocalizedString(@"user_warning_text_signed_in", @"Pulsa login para acceder a tus preferencias.");
            self.userInfoUnpressedWarningText.hidden = NO;
            
            self.userInfoUnpressedName.hidden = YES;
            self.userInfoUnpressedEmail.hidden = YES;
            
            CGRect newFrame2 = CGRectMake(self.configTable.frame.origin.x, self.configTable.frame.origin.y, self.configTable.frame.size.width, 64);
            self.configTable.frame = newFrame2;
            [self.configTable reloadData];
            
            break;
            
        case LOGGED_IN:
            self.navigationItem.rightBarButtonItem = nil;
                        
            self.userInfoUnpressedWarningText.hidden = YES;
            
            self.userInfoUnpressedName.hidden = NO;
//            self.userInfoUnpressedName.text = model.user.name;
            self.userInfoUnpressedEmail.hidden = NO;
//            self.userInfoUnpressedEmail.text = model.user.email;
            
            CGRect newFrame3 = CGRectMake(self.configTable.frame.origin.x, self.configTable.frame.origin.y, self.configTable.frame.size.width, 108);
            self.configTable.frame = newFrame3;
            [self.configTable reloadData];
            
            break;
    }
    
    [scrollManager organize];
}

- (int)checkUserState {
    // Read from NSUserDefaults if user is logged before
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    BOOL logged = [userDefaults boolForKey:@"logged"];

    return SIGN_IN;
//    if(![model.user.email isEqualToString:@""] && logged) {
//        if(logged) {
//            return LOGGED_IN;
//        }
//        else {
//            return LOG_IN;
//        }
//    }
//    else {
//        return SIGN_IN;
//    }
}

- (void)checkEmptyTable:(NSUInteger)cells {
    [scrollManager emptyFromPosition:3];
    if (cells == 0) {
        NSString *textToShow = NSLocalizedString(@"user_screen_empty_blocked_list_text", @"User screen empty blocked list cell message");
        if (self.segmentedControl.selectedSegmentIndex == 0) {
            textToShow = NSLocalizedString(@"user_screen_empty_pinup_list_text", @"User screen empty pinned list cell message");
        }
        
        [scrollManager addView:self.listEmptyView];
        
        self.listEmptyViewLabel.text = textToShow;
    }
    else {
        [scrollManager addView:self.list];
    }
    
    [scrollManager addView:self.configTable];
}

- (IBAction)userLogin:(id)sender {
    [sender resignFirstResponder];
    
    NSString *userName = self.userInfoPressedNameEditText.text;
//    model.user.name = userName;
    
    if ([userName isEqualToString:@""]) {
        userName = NSLocalizedString(@"user_info_name_not_set_text", @"User screen name not set text");
    }
    self.userInfoUnpressedName.text = userName;
    
    
    NSString *userEmail =  self.userInfoPressedEmailEditText.text;
//    model.user.email = userEmail;
    
    if ([userEmail isEqualToString:@""]) {
        userEmail = NSLocalizedString(@"user_info_email_not_set_text", @"User screen email not set text");
    }
    self.userInfoUnpressedEmail.text = userEmail;
    
    // Request
    userEditRequester = [[UserEditRequester alloc] init];
    [userEditRequester doRequestWithUser:model.user];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:@"logged"];
    [userDefaults synchronize];
    
    [self changeLayoutComponents:[self checkUserState]];

    // Transition animation
    CATransition *pushTransition = [CATransition animation];
    pushTransition.type = kCATransitionPush;
    signInInputsVisible = NO;
    pushTransition.subtype = kCATransitionFromLeft;
    [self.userInfo.layer addAnimation:pushTransition forKey:@""];
    [self.userInfo addSubview:self.userInfoUnpressed];
    [self.userInfoPressed removeFromSuperview];
}

- (void)userLogOut {
    UIAlertView *logoutAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"user_screen_sign_out_alert_title", @"User screen sign-out alert dialog title") message:NSLocalizedString(@"user_screen_sign_out_alert_message", @"User screen sign-out alert dialog message") delegate:self cancelButtonTitle:NSLocalizedString(@"nav_bar_button_cancel", @"Navigation bar button - Cancel") otherButtonTitles:NSLocalizedString(@"ok_message", @"OK message"), nil];
    [logoutAlert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {
//        NSString *name = model.user.name;
//        model.user.name = @"";
//        NSString *email = model.user.email;        
//        model.user.email = @"";
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:NO forKey:@"logged"];
        [userDefaults synchronize];
        
        [self changeLayoutComponents:[self checkUserState]];
        
        // Logout request
//        NSString *message = [NSString stringWithFormat:@"%@ (%@:%@)", ACTION_ACTIVITY_LOGOUT, name, email];
        appActivityRequester = [[AppActivityRequest alloc] init];
//        [appActivityRequester doRequestWithLocation:model.currentLocation action:message app:nil andUser:model.user];
        
        // User edit request
        userEditRequester = [[UserEditRequester alloc] init];
        [userEditRequester doRequestWithUser:model.user];
    }
}

- (IBAction)loadPhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;

    [self presentModalViewController:picker animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissModalViewControllerAnimated:YES];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.userImageImageView.image = image;
    [imageLoader saveImageInCache:image path:@"userPhoto"];
}

- (void)reloadDataAnimated:(BOOL)animated {
    
    // Get pinned or blocked apps list height
    NSUInteger listHeight = 0;
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        if (model.user.pinnedApps.count != 0) {
            listHeight = model.user.pinnedApps.count * cellHeight;
        }
        else {
            listHeight = self.listEmptyView.frame.size.height;
        }
    }
    else {
        if (model.user.blockedApps.count != 0) {
            listHeight = model.user.blockedApps.count * cellHeight;
        }
        else {
            listHeight = self.listEmptyView.frame.size.height;
        }
    }
    
    // Screen component sizes
    NSUInteger screenHeight = self.view.frame.size.height;
    // Content offset is not real. Scroll hasn't been resized
    NSUInteger scrollViewContentOffset = scroll.contentOffset.y;
    NSUInteger segmentListAndConfigViewsHeight = self.segmentedControl.frame.size.height + listHeight + self.configTable.frame.size.height;
    NSUInteger scrollViewHeight = self.userImageView.frame.size.height + self.userInfo.frame.size.height + segmentListAndConfigViewsHeight;
    
    if (scrollViewHeight - scrollViewContentOffset < screenHeight) {
        [UIView animateWithDuration:1.2
                              delay:0.02
                            options:UIViewAnimationOptionTransitionFlipFromTop
                         animations:^{
                             [scroll setContentOffset:CGPointMake(0, scrollViewHeight - screenHeight)];
                         }
                         completion:^(BOOL finished)
         {}
         ];
    }
    
    
    [list reloadData];
    
//    if (animated) {
//        CATransition *animation = [CATransition animation];
//        [animation setType:kCATransitionFade];
//        [animation setSubtype:kCAAnimationDiscrete];
//        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//        [animation setFillMode:kCAFillModeBoth];
//        [animation setDuration:.3];
//        [self.scroll.layer addAnimation:animation forKey:@"UITableViewReloadDataAnimationKey"];
//    }
}

@end
