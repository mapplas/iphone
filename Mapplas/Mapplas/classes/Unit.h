//
//  Unit.h
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

@interface Unit : NSObject {
    NSString *_identifier;
}

@property (nonatomic, strong) NSString *identifier;

- (id)initWithId:(NSString *)key;

@end