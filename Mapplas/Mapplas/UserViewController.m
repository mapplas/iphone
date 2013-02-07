//
//  UserViewController.m
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()
- (void)configureLayout;
- (int)checkUserState;
@end

@implementation UserViewController

@synthesize scroll;

@synthesize userImageView, userImageButton, userImageImageView;
@synthesize userInfoUnpressed, userInfoUnpressedName, userInfoUnpressedEmail, userInfoUnpressedWarningText;
@synthesize userInfoPressed, userInfoPressedNameEditText, userInfoPressedEmailEditText, userInfoPressedButtonOk;

- (id)initWithUser:(User *)_user {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        user = _user;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *viewsToShow = [[NSMutableArray alloc] initWithObjects:self.userImageView, self.userInfoUnpressed, nil];
    scrollManager = [[ScrollViewOfViews alloc] initWithViews:viewsToShow inScrollView:self.scroll delegate:self];
    
    [self configureLayout];
    
    [scrollManager organize];
}

- (void)configureLayout {
    // Unpressed view layout components initialization
    self.userInfoUnpressedWarningText.text = NSLocalizedString(@"", @"");
    
    
}

- (int)checkUserState {
    if(![user.email isEqualToString:@""]) {
        if(user.logged) {
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

@end
