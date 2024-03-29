//
//  GenericConnector.m
//  Mapplas
//
//  Created by Belén  on 22/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericConnector.h"

@implementation GenericConnector

@synthesize handler = _handler;

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses responseHandler:(id<GenericRequestHandler>)response_handler {
    self = [super init];
    if (self) {
        adresses = _addresses;
        self.handler = response_handler;
        parameters = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSString *)getUrl {
    return @"IMPLEMENT IN SUBCLASS";
}

- (void)initializeVariablesWithUrlAndSend:(NSString *)url {    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:url]];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    NSMutableURLRequest *jsonRequest = [httpClient requestWithMethod:@"POST"
                                                                path:@""
                                                          parameters:parameters];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:jsonRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if (self.handler != nil) {
            [self.handler requestFinished:JSON];
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (self.handler != nil) {
            [self.handler requestFinishedWithErrors:error andReponse:JSON];
        }
    }];
    
    [operation start];
}

@end
