//
//  UserViewController.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollViewOfViews.h"

#import "User.h"

typedef enum {
    SIGN_IN,
    LOG_IN,
    LOGGED_IN
} UserState;

@interface UserViewController : UIViewController {
    User *user;
    
    ScrollViewOfViews *scrollManager;
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

@end
