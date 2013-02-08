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
- (void)changeLayoutComponents:(int)user_state;
- (void)actionButtonSelector;
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

- (void)actionButtonSelector {
    
}

- (void)configureLayout {
    // Unpressed view layout components initialization
    self.userInfoUnpressedWarningText.text = NSLocalizedString(@"", @"");
    
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
            
            // Remove buttons view from bottom
            
            break;
            
        case LOG_IN:
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"user_action_button_log_in_text", @"User screen action button log-in text") style:UIBarButtonItemStylePlain target:self action:@selector(actionButtonSelector)];
            self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
            
            self.userInfoUnpressedWarningText.text = NSLocalizedString(@"user_warning_text_signed_in", @"Pulsa login para acceder a tus preferencias.");
            self.userInfoUnpressedWarningText.hidden = NO;
            
            self.userInfoUnpressedName.hidden = YES;
            self.userInfoUnpressedEmail.hidden = YES;
            
            // Remove buttons view from bottom
            
            break;
            
        case LOGGED_IN:
            self.navigationItem.rightBarButtonItem = nil;
            
            self.userInfoUnpressedWarningText.hidden = YES;
            
            self.userInfoUnpressedName.hidden = NO;
            self.userInfoUnpressedEmail.text = user.name;
            self.userInfoUnpressedEmail.hidden = NO;
            self.userInfoUnpressedEmail.text = user.email;
            
            // Add footer buttons
            
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

@end
