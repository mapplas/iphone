//
//  SCAppUtils.h
//  Mapplas
//
//  Adapted from Herbert Hansen implementation
//  http://discussions.apple.com/message.jspa?messageID=8064367#8064367
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "MREntitiesConverter.h"

@implementation MREntitiesConverter

- (id)init {
    self = [super init];
    if (self) {
		resultString = [[NSMutableString alloc] init];
	}
	return self;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)s {
	[resultString appendString:s];
}

- (NSString *)convertEntitiesInString:(NSString *)s {
	if(s == nil) {
		NSLog(@"ERROR : Parameter string is nil");
	}

	NSString* xmlStr = [NSString stringWithFormat:@"<d>%@</d>", s];
	NSData *data = [xmlStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
	NSXMLParser* xmlParse = [[NSXMLParser alloc] initWithData:data];
	[xmlParse setDelegate:self];
	[xmlParse parse];

	return [[NSString alloc] initWithFormat:@"%@",resultString];
}

@end
