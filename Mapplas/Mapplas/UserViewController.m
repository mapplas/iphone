//
//  UserViewController.m
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserViewController.h"
#import "UserPinAndBlocksRequester.h"

@interface UserViewController ()
//- (void)setTextToNavigationButton:(NSString *)title;
- (void)configureLayout;
//- (int)checkUserState;
//- (void)changeLayoutComponents:(int)user_state;
//- (void)actionButtonSelector;
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
    
    NSMutableArray *viewsToShow = [[NSMutableArray alloc] initWithObjects:/*self.userImageView, self.userInfo, self.listHeaderView,*/ self.list, nil];
    scrollManager = [[MutableScrollViewOfViews alloc] initWithViews:viewsToShow inScrollView:self.scroll delegate:self];
    //[self.userInfo addSubview:self.userInfoUnpressed];
    
    [self configureLayout];
    
    pinAndBlocksRequester = [[UserPinAndBlocksRequester alloc] init];
    [pinAndBlocksRequester doRequestWithUser:model.user viewController:self];
    
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
        return 1;
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
        cell.textLabel.text = NSLocalizedString(@"user_footer_config_button_text", @"Footer config button label text");
        
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
//        if (indexPath.row == 0) {
            ConfigurationViewController *configVC = [[ConfigurationViewController alloc] init];
            [self.navigationController pushViewController:configVC animated:YES];
//        }
//        else {
//            [self userLogOut];
//        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
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
*/
- (IBAction)segmentedControlIndexChanged {
    [self reloadDataAnimated:YES];
}

#pragma mark - Private methods
- (void)configureLayout {
    // User image photo
    /*
    UIImage *userImage = [imageLoader loadImageFromCache:@"userPhoto"];
    if (userImage != nil) {
        self.userImageImageView.image = userImage;
    }
    */
    // Segmented control button names
    NSString *segmentedControlPinnedText = NSLocalizedString(@"user_screen_segmented_control_pins", @"User screen segmented control pinned title");
    [self.segmentedControl setTitle:segmentedControlPinnedText forSegmentAtIndex:0];
    
    NSString *segmentedControlBlockedText = NSLocalizedString(@"user_screen_segmented_control_blocks", @"User screen segmented control blocks title");
    [self.segmentedControl setTitle:segmentedControlBlockedText forSegmentAtIndex:1];
    self.navigationItem.titleView = self.segmentedControl;
//    [self changeLayoutComponents:[self checkUserState]];
}

- (void)checkEmptyTable:(NSUInteger)cells {
    [scrollManager emptyFromPosition:0];
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
//    
//    // Screen component sizes
//    NSUInteger screenHeight = self.view.frame.size.height;
//    // Content offset is not real. Scroll hasn't been resized
//    NSUInteger scrollViewContentOffset = scroll.contentOffset.y;
//    NSUInteger segmentListAndConfigViewsHeight = self.segmentedControl.frame.size.height + listHeight + self.configTable.frame.size.height;
//    NSUInteger scrollViewHeight = segmentListAndConfigViewsHeight;
////    NSUInteger scrollViewHeight = self.userImageView.frame.size.height + self.userInfo.frame.size.height + segmentListAndConfigViewsHeight;
//    
//    if (scrollViewHeight - scrollViewContentOffset < screenHeight) {
//        [UIView animateWithDuration:1.2
//                              delay:0.02
//                            options:UIViewAnimationOptionTransitionFlipFromTop
//                         animations:^{
//                             [scroll setContentOffset:CGPointMake(0, scrollViewHeight - screenHeight)];
//                         }
//                         completion:^(BOOL finished)
//         {}
//         ];
//    }
    
    
    [list reloadData];
}

@end
