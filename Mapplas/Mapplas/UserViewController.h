//
//  UserViewController.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import "MutableScrollViewOfViews.h"

#import "SuperModel.h"
#import "User.h"
#import "UserListTableViewCell.h"
#import "UserBlockedTableViewCell.h"
#import "UserEmptyTableViewCell.h"
#import "UserEditRequester.h"
#import "AppActivityRequest.h"

#import "Constants.h"

#define cellHeight 72;
#define groupedCellHeight 44;

typedef enum {
    SIGN_IN,
    LOG_IN,
    LOGGED_IN
} UserState;

@class UserPinUpsRequester;
@class UserBlocksRequester;

@interface UserViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    SuperModel *model;
    
    MutableScrollViewOfViews *scrollManager;
    BOOL signInInputsVisible;
    
    UserPinUpsRequester *pinUpsRequester;
    UserBlocksRequester *blocksRequester;
    UserEditRequester *userEditRequester;
    AppActivityRequest *appActivityRequester;
    
    ImageLoader *imageLoader;
}

- (id)initWithModel:(SuperModel *)_super_model;
//- (id)initWithUser:(User *)_user location:(NSString *)current_location;

@property (nonatomic, strong) IBOutlet UIScrollView *scroll;

@property (nonatomic, strong) IBOutlet UIView *userImageView;
@property (nonatomic, strong) IBOutlet UIButton *userImageButton;
@property (nonatomic, strong) IBOutlet UIImageView *userImageImageView;

@property (nonatomic, strong) IBOutlet UIView *userInfo;

@property (nonatomic, strong) IBOutlet UIView *userInfoUnpressed;
@property (nonatomic, strong) IBOutlet UILabel *userInfoUnpressedName;
@property (nonatomic, strong) IBOutlet UILabel *userInfoUnpressedEmail;
@property (nonatomic, strong) IBOutlet UILabel *userInfoUnpressedWarningText;

@property (nonatomic, strong) IBOutlet UIView *userInfoPressed;
@property (nonatomic, strong) IBOutlet UITextField *userInfoPressedNameEditText;
@property (nonatomic, strong) IBOutlet UITextField *userInfoPressedEmailEditText;
@property (nonatomic, strong) IBOutlet UIView *userInfoPressedButtonOk;

@property (nonatomic, strong) IBOutlet UIView *listHeaderView;
@property (nonatomic, strong) IBOutlet UIButton *listHeaderPinsButton;
@property (nonatomic, strong) IBOutlet UILabel *listHeaderPinsLabel;
@property (nonatomic, strong) IBOutlet UIButton *listHeaderBlocksButton;
@property (nonatomic, strong) IBOutlet UILabel *listHeaderBlocksLabel;

@property (nonatomic, strong) IBOutlet UITableView *list;

@property (nonatomic, strong) IBOutlet UIView *listEmptyView;
@property (nonatomic, strong) IBOutlet UILabel *listEmptyViewLabel;

@property (nonatomic, strong) IBOutlet UITableView *configTable;

- (IBAction)userPinnedApps:(id)sender;
- (IBAction)userBlockedApps:(id)sender;
- (IBAction)userLogin:(id)sender;
- (IBAction)userLogOut:(id)sender;

- (IBAction)loadPhoto:(id)sender;

- (void)requestedDataLoaded;

@end
