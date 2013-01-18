//
//  UserIdentificationConnector.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

@interface Variable : NSObject {
	NSString *key;
    id correspondingValue;
}

@property (nonatomic, retain) id correspondingValue;
@property (nonatomic, retain) NSString *key;

- (id)initWithValue:(id)var_value forKey:(NSString *)var_key;

@end
