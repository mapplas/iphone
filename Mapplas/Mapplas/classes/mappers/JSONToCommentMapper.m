//
//  JSONToCommentMapper.m
//  Mapplas
//
//  Created by Belén  on 23/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "JSONToCommentMapper.h"

@implementation JSONToCommentMapper

- (id)init {
    
	NSArray *mappingProperties = [[NSArray alloc] initWithObjects:
								  [[KeyValueMapper alloc] initWithKey:@"IDComment" action:@selector(setCommentId:)],
                                  [[KeyValueMapper alloc] initWithKey:@"IDUser" action:@selector(setIdUser:)],
                                  [[KeyValueMapper alloc] initWithKey:@"IDLocalization" action:@selector(setIdApp:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"Comment" action:@selector(setRate:)],
                                  [[KeyValueMapper alloc] initWithKey:@"Date" action:@selector(setDate:)],
                                  [[KeyValueMapper alloc] initWithKey:@"Hour" action:@selector(setHour:)],
                                  [[KeyValueMapper alloc] initWithKey:@"Rate" action:@selector(setComment:)],
                                  nil];
    
    self = [super initWithMappers:mappingProperties];
    
    return self;
}

- (Comment *)map:(NSDictionary *)data {
    Comment *comment = [[Comment alloc] init];
    
    [super map:data target:comment];
    
    return comment;
}

@end
