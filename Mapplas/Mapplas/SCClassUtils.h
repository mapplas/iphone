//
//  SCClassUtils.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

@interface SCClassUtils : NSObject

+ (void)swizzleSelector:(SEL)orig ofClass:(Class)c withSelector:(SEL)new;

@end
