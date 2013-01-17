//
//  Photo.m
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "Photo.h"

@implementation Photo

@synthesize photoId = _photoId;
@synthesize userId = _userId;
@synthesize appId = _appId;
@synthesize date = _date;
@synthesize comment = _comment;
@synthesize photo = _photo;
@synthesize hour = _hour;

- (id)init {
    if (self = [super init]) {
        self.photoId = [NSNumber numberWithInt:0];
        self.userId = [NSNumber numberWithInt:0];
        self.appId = [NSNumber numberWithInt:0];
        self.date = @"";
        self.comment = @"";
        self.photo = @"";
        self.hour = @"";
    }
    return self;
}

@end
