//
//  Environment.h
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AbstractUrlAddresses.h"

@interface Environment : NSObject {
	AbstractUrlAddresses *_addresses;
    BOOL _appSomethingChangedInDetail;
}

@property (nonatomic, strong) AbstractUrlAddresses *addresses;
@property (nonatomic) BOOL appSomethingChangedInDetail;

+(Environment*)sharedInstance;
+(id)hiddenAlloc;
+(BOOL)sharedInstanceExists;

- (void)purge;
//- (BOOL)saveUserInfo:(BaseUserInfo *)user_info;

@end
