//
//  Constants.h
//  Mapplas
//
//  Created by Belén  on 28/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#define ACTION_PIN_REQUEST_PIN @"pin"
#define ACTION_PIN_REQUEST_UNPIN @"unpin"

#define ACTION_LIKE_REQUEST_BLOCK @"block"
#define ACTION_LIKE_REQUEST_UNBLOCK @"unblock"

#define ACTION_SHARE_REQUEST_VIA_EMAIL @"em"
#define ACTION_SHARE_REQUEST_VIA_SMS @"sms"
#define ACTION_SHARE_REQUEST_VIA_TWITTER @"tw"
#define ACTION_SHARE_REQUEST_VIA_FACEBOOK @"fb"
#define ACTION_SHARE_REQUEST_VIA_UNKNOWN @"none"

#define ACTION_ACTIVITY_LOGOUT @"logout"
#define ACTION_ACTIVITY_START @"start"
#define ACTION_ACTIVITY_INSTALL @"install"
#define ACTION_ACTIVITY_PROBLEM @"problem"

#define ACTION_ACTIVITY_PIN @"pin"
#define ACTION_ACTIVITY_UNPIN @"unpin"
#define ACTION_ACTIVITY_BLOCK @"unblock"
#define ACTION_ACTIVITY_UNBLOCK @"unblock"
#define ACTION_ACTIVITY_RATE @"rate"
#define ACTION_ACTIVITY_SHARE @"share"
#define ACTION_ACTIVITY_CALL @"call"
#define ACTION_ACTIVITY_SHOW_COMMENTS @"showcomments"


#define IS_RETINA ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))

@interface Constants : NSObject

@end
