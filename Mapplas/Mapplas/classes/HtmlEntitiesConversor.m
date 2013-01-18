//
//  SCAppUtils.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "HtmlEntitiesConversor.h"

@implementation HtmlEntitiesConversor

- (id)initWithNSData:(NSData *)ns_data {
	self = [super init];
	
	if (self) {
		data = ns_data;
	}
	return self;
}

- (NSString *)convertHtmlEntities:(NSString *)input {
	MREntitiesConverter *converter = [[MREntitiesConverter alloc] init];	NSString *result = [converter convertEntitiesInString:input];
	
	return result;
}

- (NSString *)convert {
	NSString *receivedDataAsString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSMutableString *receivedString = [[NSMutableString alloc] initWithString:@""];
	[receivedString appendString:[self convertHtmlEntities:receivedDataAsString]];
	return receivedString;
}

@end
