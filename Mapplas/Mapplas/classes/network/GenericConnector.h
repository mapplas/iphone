//
//  GenericConnector.h
//  Mapplas
//
//  Created by Belén  on 22/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AbstractUrlAddresses.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"
#import "GenericRequestHandler.h"

@interface GenericConnector : NSObject {    
    AbstractUrlAddresses *adresses;
    id<GenericRequestHandler> _handler;
    
    NSMutableDictionary *parameters;
}

@property (nonatomic, strong) id<GenericRequestHandler> handler;

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses responseHandler:(id<GenericRequestHandler>)response_handler;
- (NSString *)getUrl;
- (void)initializeVariablesWithUrlAndSend:(NSString *)url;

@end
