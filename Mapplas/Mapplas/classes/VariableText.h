//
//  UserIdentificationConnector.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "Variable.h"

@interface VariableText : Variable

- (id)initWithValue:(NSString *)init_value forKey:(NSString *)for_key;

- (NSString *)textValue;

@end
