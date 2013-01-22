//
//  UserIdentificationResponseHandler.h
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericRequestHandler.h"
#import "NSObject+JSON.h"
#import "SuperModel.h"

@interface UserIdentificationResponseHandler : NSObject <GenericRequestHandler> {
    SuperModel *model;
}

- (id)initWithSuperModel:(SuperModel *)_model;

@end
