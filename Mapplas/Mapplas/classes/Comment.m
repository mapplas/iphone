//
//  Comment.m
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "Comment.h"

@implementation Comment

@synthesize commentId = _commentId;
@synthesize idUser = _idUser;
@synthesize idApp = _idApp;
@synthesize rate = _rate;
@synthesize date = _date;
@synthesize hour = _hour;
@synthesize comment = _comment;

- (id)init {
    self = [super init];
    if (self) {
        self.commentId = [NSNumber numberWithInt:0];
        self.idUser = [NSNumber numberWithInt:0];
        self.idApp = [NSNumber numberWithInt:0];
        self.rate = [NSNumber numberWithInt:0];
        self.date = @"";
        self.hour = @"";
        self.comment = @"";
    }
    return self;
}

@end
