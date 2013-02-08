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

#import "UserPinUpsRequester.h"

typedef enum {
    SIGN_IN,
    LOG_IN,
    LOGGED_IN
} UserState;

@interface UserViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    User *user;
    App *app;
    
    ScrollViewOfViews *scrollManager;
    
    UserPinUpsRequester *pinUpsRequester;
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

@end
