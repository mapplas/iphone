//
//  GenericConnector.h
//  Mapplas
//
//  Created by Belén  on 22/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AbstractUrlAddresses.h"
#import "VariableListMapper.h"

@interface GenericConnector : NSObject {
    ASIFormDataRequest *_request;
    
    AbstractUrlAddresses *adresses;
    VariableListMapper *variableListMapper;
    id<ASIHTTPRequestDelegate> _handler;
    
    VariableList *parameters;
}

@property (nonatomic, strong) ASIFormDataRequest *request;
@property (nonatomic, strong) id<ASIHTTPRequestDelegate> handler;

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses variableListMapper:(VariableListMapper *)list_mapper responseHandler:(id<ASIHTTPRequestDelegate>)response_handler;
- (NSString *)getUrl;
- (void)initializeVariablesWithUrlAndSend:(NSString *)url;

@end
