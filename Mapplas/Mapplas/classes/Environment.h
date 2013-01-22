//
//  Environment.h
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AbstractUrlAddresses.h"

@interface Environment : NSObject {
	AbstractUrlAddresses *addresses;
}

@property (nonatomic, retain) AbstractUrlAddresses *addresses;

+(Environment*)sharedInstance;
+(id)hiddenAlloc;
+(BOOL)sharedInstanceExists;

- (void)purge;
//- (BOOL)saveUserInfo:(BaseUserInfo *)user_info;

@end
