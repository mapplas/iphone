//
//  JSONToAppMapper.m
//  Mapplas
//
//  Created by Belén  on 23/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "JSONToAppMapper.h"

@implementation JSONToAppMapper

- (id)init {
    
    JSONToCommentMapper *commentMapper = [[JSONToCommentMapper alloc] init];
    JSONToPhotoMapper *photoMapper = [[JSONToPhotoMapper alloc] init];
    
	NSArray *mappingProperties = [[NSArray alloc] initWithObjects:
								  [[KeyValueScappedMapper alloc] initWithKey:@"IDLocalization" action:@selector(setAppId:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"Name" action:@selector(setName:)],
                                  [[KeyValueMapper alloc] initWithKey:@"Latitude" action:@selector(setLatitude:)],
                                  [[KeyValueMapper alloc] initWithKey:@"Longitude" action:@selector(setLongitude:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"Type" action:@selector(setType:)],
                                  
                                  [[KeyValueScappedMapper alloc] initWithKey:@"AppName" action:@selector(setAppName:)],
                                  [[KeyValueMapper alloc] initWithKey:@"AppLogo" action:@selector(setAppLogo:)],
                                  [[KeyValueMapper alloc] initWithKey:@"AppLogoMini" action:@selector(setAppLogoMini:)],
                                  [[KeyValueMapper alloc] initWithKey:@"AppURL" action:@selector(setAppUrl:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"AppDescription" action:@selector(setAppDescription:)],
                                  [[KeyValueMapper alloc] initWithKey:@"Phone" action:@selector(setPhone:)],
                                  [[KeyValueMapper alloc] initWithKey:@"AppPrice" action:@selector(setAppPrice:)],
                                  
                                  [[KeyValueMapper alloc] initWithKey:@"AuxFavourite" action:@selector(setAuxFavourite:)],
                                  [[KeyValueMapper alloc] initWithKey:@"AuxPin" action:@selector(setAuxPin:)],
                                  [[KeyValueMapper alloc] initWithKey:@"AuxRate" action:@selector(setAuxRate:)],
                                  [[KeyValueMapper alloc] initWithKey:@"AuxComment" action:@selector(setAuxComment:)],
                                  [[KeyValueMapper alloc] initWithKey:@"AuxTotalRate" action:@selector(setAuxTotalRate:)],
                                  [[KeyValueMapper alloc] initWithKey:@"AuxTotalPins" action:@selector(setAuxTotalPins:)],
                                  [[KeyValueMapper alloc] initWithKey:@"AuxTotalComments" action:@selector(setAuxTotalComments:)],
                                  
                                  [[TargetIteratingMapper alloc] initWithArrayKey:@"auxCommentsArray" elementMapper:commentMapper action:@selector(setAuxCommentsArray:)],
                                  [[TargetIteratingMapper alloc] initWithArrayKey:@"auxPhotosArray" elementMapper:photoMapper action:@selector(setAuxPhotosArray:)],
                                  
                                  [[KeyValueScappedMapper alloc] initWithKey:@"Market" action:@selector(setMarket:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"AuxNews" action:@selector(setNotificationRaw:)],
                                  
                                  nil];
    
    self = [super initWithMappers:mappingProperties];
    
    return self;
}

- (App *)map:(NSDictionary *)json {
    App *app = [[App alloc] init];
    
    [super map:json target:app];
    
    if ([[app market] isEqualToString:@"Usa"]) {
        [app setLocationCurrency:DOLLAR];
    }
    else {
        [app setLocationCurrency:EURO];
    }
    
    return app;
}

@end
