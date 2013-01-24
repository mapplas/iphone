//
//  UserIdentificationRequest.h
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "SuperModel.h"
#import "UserIdentificationConnector.h"
#import "Environment.h"

@interface UserIdentificationRequest : NSObject {
    SuperModel *model;
    UserIdentificationConnector *connector;
}

- (id)initWithSuperModel:(SuperModel *)super_model;
- (void)doRequest;

@end
