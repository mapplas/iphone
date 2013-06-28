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

#import "Constants.h"
#import "ConfigurationViewController.h"

#define cellHeight 72;
#define groupedCellHeight 44;

typedef enum {
    SIGN_IN,
    LOG_IN,
    LOGGED_IN
} UserState;

@class UserPinAndBlocksRequester;

@interface UserViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    SuperModel *model;
    
    MutableScrollViewOfViews *scrollManager;
    BOOL signInInputsVisible;
    
    UserPinAndBlocksRequester *pinAndBlocksRequester;
    UserEditRequester *userEditRequester;
    
    ImageLoader *imageLoader;
}

- (id)initWithModel:(SuperModel *)_super_model;

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
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;

@property (nonatomic, strong) IBOutlet UITableView *list;

@property (nonatomic, strong) IBOutlet UIView *listEmptyView;
@property (nonatomic, strong) IBOutlet UILabel *listEmptyViewLabel;

@property (nonatomic, strong) IBOutlet UITableView *configTable;

- (IBAction)segmentedControlIndexChanged;
- (void)requestedDataLoaded;

@end
