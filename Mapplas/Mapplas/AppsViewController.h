//
//  AppsViewController.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationsViewController.h"
#import "UserViewController.h"
#import "UserIdentificationRequest.h"

@interface AppsViewController : UIViewController {
    UserIdentificationRequest *_userIdentRequester;
}

@property (nonatomic, strong) UserIdentificationRequest *userIdentRequest;


@end
