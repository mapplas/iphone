//
//  SCAppUtils.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "MREntitiesConverter.h"

@interface HtmlEntitiesConversor : NSObject {
	NSData *data;
}

- (id)initWithNSData:(NSData *)ns_data;
- (NSString *)convertHtmlEntities:(NSString *)input;
- (NSString *)convert;

@end
