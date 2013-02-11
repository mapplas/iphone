//
//  UserViewController.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ScrollViewOfViews.h"

#import "User.h"
#import "UserListTableViewCell.h"
#import "UserBlockedTableViewCell.h"

#define cellHeight 72;

typedef enum {
    SIGN_IN,
    LOG_IN,
    LOGGED_IN
} UserState;

@class UserPinUpsRequester;
@class UserBlocksRequester;

@interface UserViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    User *user;
    
    ScrollViewOfViews *scrollManager;
    
    UserPinUpsRequester *pinUpsRequester;
    UserBlocksRequester *blocksRequester;
}

- (id)initWithUser:(User *)_user;

@property (nonatomic, strong) IBOutlet UIScrollView *scroll;

@property (nonatomic, strong) IBOutlet UIView *userImageView;
@property (nonatomic, strong) IBOutlet UIButton *userImageButton;
@property (nonatomic, strong) IBOutlet UIImageView *userImageImageView;

@property (nonatomic, strong) IBOutlet UIView *userInfoUnpressed;
@property (nonatomic, strong) IBOutlet UILabel *userInfoUnpressedName;
@property (nonatomic, strong) IBOutlet UILabel *userInfoUnpressedEmail;
@property (nonatomic, strong) IBOutlet UILabel *userInfoUnpressedWarningText;

@property (nonatomic, strong) IBOutlet UIView *userInfoPressed;
@property (nonatomic, strong) IBOutlet UIView *userInfoPressedNameEditText;
@property (nonatomic, strong) IBOutlet UIView *userInfoPressedEmailEditText;
@property (nonatomic, strong) IBOutlet UIView *userInfoPressedButtonOk;

@property (nonatomic, strong) IBOutlet UIView *listHeaderView;
@property (nonatomic, strong) IBOutlet UIButton *listHeaderPinsButton;
@property (nonatomic, strong) IBOutlet UILabel *listHeaderPinsLabel;
@property (nonatomic, strong) IBOutlet UIButton *listHeaderBlocksButton;
@property (nonatomic, strong) IBOutlet UILabel *listHeaderBlocksLabel;

@property (nonatomic, strong) IBOutlet UITableView *list;

@property (nonatomic, strong) IBOutlet UIView *footerView;
@property (nonatomic, strong) IBOutlet UIButton *footerClearButton;
@property (nonatomic, strong) IBOutlet UILabel *footerClearButtonLabel;
@property (nonatomic, strong) IBOutlet UIButton *footerSignOutButton;
@property (nonatomic, strong) IBOutlet UILabel *footerSignOutButtonLabel;


- (IBAction)userPinnedApps:(id)sender;
- (IBAction)userBlockedApps:(id)sender;

- (void)requestedDataLoaded;

@end
