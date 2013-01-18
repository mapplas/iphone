//
//  UserIdentificationConnector.h
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

@interface AbstractUrlAddresses : NSObject {
	NSString *identifyUser;
}

@property (nonatomic, retain) NSString *domain;
@property (nonatomic, retain) NSString *port;
@property (nonatomic, retain) NSString *relativePath;

@property (nonatomic, retain) NSString *identifyUser;

- (void)reloadAddresses;

@end
