//
//  UserIdentificationConnector.h
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericConnector.h"
#import "SuperModel.h"
#import "UserIdentificationResponseHandler.h"

@interface UserIdentificationConnector : GenericConnector {
    SuperModel *model;
}

- (id)initWithAddresses:(AbstractUrlAddresses *)addresses responseHandler:(UserIdentificationResponseHandler *)response_handler;
- (void)requestWithModel:(SuperModel *)super_model;

@end
