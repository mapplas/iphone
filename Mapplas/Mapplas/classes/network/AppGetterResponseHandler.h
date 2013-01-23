//
//  AppGetterResponseHandler.h
//  Mapplas
//
//  Created by Belén  on 22/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericRequestHandler.h"
#import "NSObject+JSON.h"
#import "JSONToAppMapper.h"
#import "SuperModel.h"

@interface AppGetterResponseHandler : NSObject <GenericRequestHandler> {
    SuperModel *model;
}

- (id)initWithModel:(SuperModel *)_model;

@end
