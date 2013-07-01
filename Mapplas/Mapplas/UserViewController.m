//
//  UserViewController.m
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserViewController.h"
#import "UserPinAndBlocksRequester.h"
#import "NavigationControllerStyler.h"

@interface UserViewController ()
- (void)configureLayout;
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
    
    NavigationControllerStyler *styler = [[NavigationControllerStyler alloc] init];    
    NSDictionary *dict = [styler styleNavBarButtonToBlue:YES];
    [[UIBarButtonItem appearance] setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    ImageLoaderFactory *factory = [[ImageLoaderFactory alloc] init];
    AsynchronousImageDownloader *downloader = [[AsynchronousImageDownloader alloc] initWithDelegate:nil];
    imageLoader = [factory createUsingCacheFolderWithDownloader:downloader];
    
    NSMutableArray *viewsToShow = [[NSMutableArray alloc] initWithObjects:/*self.userImageView, self.userInfo, self.listHeaderView,*/ self.list, nil];
    scrollManager = [[MutableScrollViewOfViews alloc] initWithViews:viewsToShow inScrollView:self.scroll delegate:self];
    
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
            [cell setReverseGeocodedLocation:model.currentDescriptiveGeoLoc];
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
        ConfigurationViewController *configVC = [[ConfigurationViewController alloc] init];
        [self.navigationController pushViewController:configVC animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)segmentedControlIndexChanged {
    [self reloadDataAnimated:YES];
}

#pragma mark - Private methods
- (void)configureLayout {
    NSString *segmentedControlPinnedText = NSLocalizedString(@"user_screen_segmented_control_pins", @"User screen segmented control pinned title");
    [self.segmentedControl setTitle:segmentedControlPinnedText forSegmentAtIndex:0];
    
    [self.segmentedControl setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                  [UIColor colorWithRed:0.0f/255.0f green:153.0f/255.0f blue:204.0f/255.0f alpha:255.0f/255.0f],
                                                  UITextAttributeTextColor,
                                                  [UIColor clearColor],
                                                  UITextAttributeTextShadowColor, nil]
                                        forState:UIControlStateNormal];
    
    NSString *segmentedControlBlockedText = NSLocalizedString(@"user_screen_segmented_control_blocks", @"User screen segmented control blocks title");
    [self.segmentedControl setTitle:segmentedControlBlockedText forSegmentAtIndex:1];
    self.navigationItem.titleView = self.segmentedControl;
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
    
    [list reloadData];
}

@end
