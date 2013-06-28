//
//  GenericRequestHandler
//  Mapplas
//
//  Created by Belén  on 22/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

@protocol GenericRequestHandler <NSObject>

- (void)requestFinished:(id)JSON;
- (void)requestFinishedWithErrors:(NSError *)error andReponse:(id)JSON;

@end
