//
//  Environment.h
//  Quomai
//
//  Created by Fran Naranjo on 03/03/11.
//  Copyright 2011 Quomai. All rights reserved.
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
