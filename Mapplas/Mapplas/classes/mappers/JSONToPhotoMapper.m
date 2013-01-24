//
//  JSONToPhotoMapper.m
//  Mapplas
//
//  Created by Belén  on 23/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "JSONToPhotoMapper.h"

@implementation JSONToPhotoMapper

- (id)init {
    NSArray *mappingProperties = [[NSArray alloc] initWithObjects:
								  [[KeyValueMapper alloc] initWithKey:@"IDPhoto" action:@selector(setPhotoId:)],
                                  [[KeyValueMapper alloc] initWithKey:@"Photo" action:@selector(setPhoto:)],
                                  nil];
    self = [super initWithMappers:mappingProperties];
    
    return self;
}

- (Photo *)map:(NSDictionary *)data {
    Photo *photo = [[Photo alloc] init];
    
    [super map:data target:photo];
    
    return photo;
}

@end
