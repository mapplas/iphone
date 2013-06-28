//
//  NSString+UUID.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "NSString+UUID.h"

@implementation NSString (UUID)

+ (NSString *)uuid {
    NSString *uuidString = nil;
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    if (uuid) {
        uuidString = (__bridge NSString *)CFUUIDCreateString(NULL, uuid);
        CFRelease(uuid);
    }
    return uuidString;
}

@end
