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
@synthesize photo = _photo;

- (id)init {
    self = [super init];
    if (self) {
        self.photoId = [NSNumber numberWithInt:0];
        self.photo = @"";
    }
    return self;
}

@end
