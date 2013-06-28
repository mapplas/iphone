//
//  SharingHelper.m
//  Mapplas
//
//  Created by Belén  on 06/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "SharingHelper.h"
#import "NavigationControllerStyler.h"

@implementation SharingHelper

- (id)initWithApp:(id)_app navigationController:(UINavigationController *)nav_controller user:(User *)_user andLocation:(NSString *)_current_location {
    self = [super init];
    if (self) {
        app = _app;
        navController = nav_controller;
        user = _user;
        current_location = _current_location;
    }
    return self;
}

- (NSString *)getShareMessage {
    return [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"share_message_part_1", @"Share message  part 1"), app.name];
}

- (void)shareWithTwitter {
    if ([TWTweetComposeViewController canSendTweet]) {
        TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
        [tweetSheet setInitialText:[self getShareMessage]];
        [navController presentModalViewController:tweetSheet animated:YES];
    }
    else {
        // Alert View
        UIAlertView *errorAler = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"share_twitter_error", @"Twitter sharing not avaliable") delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"ok_message", @"OK message"), nil];
        [errorAler show];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"share_sms_error", @"SMS sharing error") delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"ok_message", @"OK message"), nil];
    UIAlertView *okAlert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"share_sms_ok_message", @"SMS sharing ok message") delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"ok_message", @"OK message"), nil];
    
	switch (result) {
		case MessageComposeResultCancelled:
			break;
		case MessageComposeResultFailed:
            [errorAlert show];
			break;
		case MessageComposeResultSent:
            // Share request
            appShareRequester = [[AppShareRequest alloc] init];
            [appShareRequester doRequestWithAppId:app.appId userId:user.userId andLocation:current_location via:ACTION_SHARE_REQUEST_VIA_SMS];
            
            [okAlert show];
			break;
		default:
			break;
	}
    
	[navController dismissModalViewControllerAnimated:YES];
}

- (void)shareViaInAppSMS {
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText]) {
        controller.body = [self getShareMessage];
        controller.messageComposeDelegate =  self;
        [navController presentModalViewController:controller animated:YES];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"share_email_error", @"Email sharing error") delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"ok_message", @"OK message"), nil];
    UIAlertView *okAlert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"share_email_ok_message", @"Email sharing ok message") delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"ok_message", @"OK message"), nil];
    
	switch (result) {
		case MessageComposeResultCancelled:
			break;
		case MessageComposeResultFailed:
            [errorAlert show];
			break;
		case MessageComposeResultSent:
            // Share request
            appShareRequester = [[AppShareRequest alloc] init];
            [appShareRequester doRequestWithAppId:app.appId userId:user.userId andLocation:current_location via:ACTION_SHARE_REQUEST_VIA_EMAIL];
            
            [okAlert show];
			break;
		default:
			break;
	}
    
	[navController dismissModalViewControllerAnimated:YES];
}

- (void)shareViaEmail {
    MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
    mailViewController.mailComposeDelegate = self;
    [mailViewController setSubject:[NSString stringWithFormat:@"%@%@", app.name, NSLocalizedString(@"share_message_part_2", @"")]];
    [mailViewController setMessageBody:[NSString stringWithFormat:@"%@ %@ %@ %@", NSLocalizedString(@"share_email_body_part_1", @"Share email body Spanish part 1"), app.name, NSLocalizedString(@"share_email_body_part_2", @"Share email body Spanish part 2"), [NSString stringWithFormat:@"ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", app.appId]] isHTML:NO];
    
    [navController presentModalViewController:mailViewController animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {
        [self shareWithTwitter];
        // Share request
        appShareRequester = [[AppShareRequest alloc] init];
        [appShareRequester doRequestWithAppId:app.appId userId:user.userId andLocation:current_location via:ACTION_SHARE_REQUEST_VIA_TWITTER];
    }
    else if(buttonIndex == 1) {
		[self shareViaInAppSMS];
	}
    else if(buttonIndex == 2) {
        [self shareViaEmail];
    }
}

- (void)shareType:(NSString *)activity_type {
    NSString *myActivityConstant = ACTION_SHARE_REQUEST_VIA_UNKNOWN;
    
    if ([activity_type isEqualToString:@"com.apple.UIKit.activity.PostToFacebook"]) {
        myActivityConstant = ACTION_SHARE_REQUEST_VIA_FACEBOOK;
    } else if ([activity_type isEqualToString:@"com.apple.UIKit.activity.PostToTwitter"]) {
        myActivityConstant = ACTION_SHARE_REQUEST_VIA_TWITTER;
    } else if ([activity_type isEqualToString:@"com.apple.UIKit.activity.Mail"]) {
        myActivityConstant = ACTION_SHARE_REQUEST_VIA_EMAIL;
    } else if ([activity_type isEqualToString:@"com.apple.UIKit.activity.Message"]) {
        myActivityConstant = ACTION_SHARE_REQUEST_VIA_SMS;
    }
    
    appShareRequester = [[AppShareRequest alloc] init];
    [appShareRequester doRequestWithAppId:app.appId userId:user.userId andLocation:current_location via:myActivityConstant];
}

@end
