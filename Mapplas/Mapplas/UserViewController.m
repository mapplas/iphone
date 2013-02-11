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
- (void)configureLayout;
- (int)checkUserState;
- (void)changeLayoutComponents:(int)user_state;
- (void)actionButtonSelector;
@end

@implementation UserViewController

@synthesize scroll;

@synthesize userImageView, userImageButton, userImageImageView;
@synthesize userInfoUnpressed, userInfoUnpressedName, userInfoUnpressedEmail, userInfoUnpressedWarningText;
@synthesize userInfoPressed, userInfoPressedNameEditText, userInfoPressedEmailEditText, userInfoPressedButtonOk;
@synthesize listHeaderView, listHeaderPinsButton, listHeaderPinsLabel, listHeaderBlocksButton, listHeaderBlocksLabel;
@synthesize list;
@synthesize footerView, footerClearButton, footerClearButtonLabel, footerSignOutButton, footerSignOutButtonLabel;

- (id)initWithUser:(User *)_user {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        user = _user;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *viewsToShow = [[NSMutableArray alloc] initWithObjects:self.userImageView, self.userInfoUnpressed, self.listHeaderView, self.list, self.footerView, nil];
    scrollManager = [[ScrollViewOfViews alloc] initWithViews:viewsToShow inScrollView:self.scroll delegate:self];
    
    [self configureLayout];
    
    pinUpsRequester = [[UserPinUpsRequester alloc] init];
    [pinUpsRequester doRequestWithUser:user viewController:self];
    
    blocksRequester = [[UserBlocksRequester alloc] init];
    [blocksRequester doRequestWithUser:user viewController:self];
    
    [scrollManager organize];
}

#pragma mark - User pin ups and blocked requests handler methods 
- (void)requestedDataLoaded {
    [list reloadData];
}

#pragma mark - UITableViewDataSource delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSMutableArray *loadedList = nil;
    if (self.listHeaderPinsButton.selected) {
        loadedList = user.pinnedApps;
    }
    else {
        loadedList = user.blockedApps;
    }
    
    float tableHeight = loadedList.count * cellHeight;
    CGRect listFrame = CGRectMake(self.list.frame.origin.x, self.list.frame.origin.y, self.list.frame.size.width, tableHeight);
    self.list.frame = listFrame;
    
    [scrollManager organize];
    
    return loadedList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *pinnedAppsTableIdentifier = @"UserPinsTableItem";
    static NSString *blockedAppsTableIdentifier = @"UserBlocksTableItem";
    
    if (self.listHeaderPinsButton.selected) {
        UserListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pinnedAppsTableIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UserListTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        [cell setApp:[user.pinnedApps objectAtIndex:indexPath.row]];
        [cell loadData];
        
        return cell;
    }
    else {
        UserBlockedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:blockedAppsTableIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UserBlockedTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        [cell setApp:[user.blockedApps objectAtIndex:indexPath.row]];
        [cell loadData];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}

#pragma mark - Private methods

- (void)actionButtonSelector {
    
}

- (void)configureLayout {    
    // List header
    self.listHeaderPinsLabel.text =  NSLocalizedString(@"user_list_header_pins_label", @"User screen list header pins label");
    [self.listHeaderPinsButton setBackgroundImage:[UIImage imageNamed:@"bgd_tab_pressed_left.png"] forState:UIControlStateSelected];
    self.listHeaderPinsButton.selected = YES;
    
    self.listHeaderBlocksLabel.text = NSLocalizedString(@"user_list_header_blocks_label", @"User screen list header blocks label");
    [self.listHeaderBlocksButton setBackgroundImage:[UIImage imageNamed:@"bgd_tab_pressed_right.png"] forState:UIControlStateSelected];
    self.listHeaderBlocksButton.selected = NO;
    
    // Footer
    self.footerClearButtonLabel.text = NSLocalizedString(@"user_footer_clear_button_text", @"Footer clear button label text");
    self.footerSignOutButtonLabel.text = NSLocalizedString(@"user_footer_sign_out_button_text", @"Footer sign-out button label text");
    
    [self changeLayoutComponents:[self checkUserState]];
}

- (void)changeLayoutComponents:(int)user_state {
    switch (user_state) {
        case SIGN_IN:
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"user_action_button_sign_in_text", @"User screen action button sign-in text") style:UIBarButtonItemStylePlain target:self action:@selector(actionButtonSelector)];
            self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
            
            self.userInfoUnpressedWarningText.text = NSLocalizedString(@"user_warning_text_sign_in", @"User screen warning text sign-in");
            self.userInfoUnpressedWarningText.hidden = NO;
            
            self.userInfoUnpressedName.hidden = YES;
            self.userInfoUnpressedEmail.hidden = YES;
            
            self.footerView.hidden = YES;
            
            break;
            
        case LOG_IN:
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"user_action_button_log_in_text", @"User screen action button log-in text") style:UIBarButtonItemStylePlain target:self action:@selector(actionButtonSelector)];
            self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
            
            self.userInfoUnpressedWarningText.text = NSLocalizedString(@"user_warning_text_signed_in", @"Pulsa login para acceder a tus preferencias.");
            self.userInfoUnpressedWarningText.hidden = NO;
            
            self.userInfoUnpressedName.hidden = YES;
            self.userInfoUnpressedEmail.hidden = YES;
            
            self.footerView.hidden = YES;
            
            break;
            
        case LOGGED_IN:
            self.navigationItem.rightBarButtonItem = nil;
            
            self.userInfoUnpressedWarningText.hidden = YES;
            
            self.userInfoUnpressedName.hidden = NO;
            self.userInfoUnpressedEmail.text = user.name;
            self.userInfoUnpressedEmail.hidden = NO;
            self.userInfoUnpressedEmail.text = user.email;
            
            self.footerView.hidden = NO;
            
            break;
    }
}

- (int)checkUserState {
    // Read from NSUserDefaults if user is logged before
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL logged = [userDefaults boolForKey:@"logged"];
    
    if(![user.email isEqualToString:@""] && logged) {
        if(logged) {
            return LOG_IN;
        }
        else {
            return LOGGED_IN;
        }
    }
    else {
        return SIGN_IN;
    }
}

- (IBAction)userPinnedApps:(id)sender {
    self.listHeaderPinsButton.selected = YES;
    self.listHeaderBlocksButton.selected = NO;
    [list reloadData];
}

- (IBAction)userBlockedApps:(id)sender {
    self.listHeaderPinsButton.selected = NO;
    self.listHeaderBlocksButton.selected = YES;
    [list reloadData];
}

@end
