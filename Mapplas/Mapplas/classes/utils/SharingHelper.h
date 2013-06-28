//
//  SharingHelper.h
//  Mapplas
//
//  Created by Belén  on 06/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <Twitter/Twitter.h>
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

#import "App.h"
#import "User.h"
#import "AppShareRequest.h"
#import "Constants.h"

@interface SharingHelper : NSObject <MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate, UIActionSheetDelegate> {
    App *app;
    User *user;
    NSString *current_location;
    AppShareRequest *appShareRequester;
    UINavigationController *navController;
}

- (id)initWithApp:(App *)_app navigationController:(UINavigationController *)nav_controller user:(User *)_user andLocation:(NSString *)_current_location;
- (NSString *)getShareMessage;

- (void)shareType:(NSString *)activity_type;

@end
