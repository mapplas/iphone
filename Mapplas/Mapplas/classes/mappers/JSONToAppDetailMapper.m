//
//  JSONToAppDetailMapper.m
//  Mapplas
//
//  Created by Belén  on 13/05/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "JSONToAppDetailMapper.h"

@implementation JSONToAppDetailMapper

- (id)init {    
	NSArray *mappingProperties = [[NSArray alloc] initWithObjects:
                                  [[KeyValueScappedMapper alloc] initWithKey:@"curl" action:@selector(setAppUrl:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"surl" action:@selector(setAppSupportUrl:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"d" action:@selector(setAppDescription:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"scr" action:@selector(setAuxPhotosStr:)],
                                  nil];
    
    self = [super initWithMappers:mappingProperties];
    
    return self;
}

- (void)map:(NSDictionary *)data app:(App *)app {
    [super map:data target:app];
    
    NSString *photosStr = app.auxPhotosStr;
    photosStr = [photosStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    photosStr = [photosStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    photosStr = [photosStr stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    photosStr = [photosStr stringByReplacingOccurrencesOfString:@"(" withString:@""];
    photosStr = [photosStr stringByReplacingOccurrencesOfString:@")" withString:@""];
    [app setAuxPhotosArray:[photosStr componentsSeparatedByString:@","]];
}

@end
