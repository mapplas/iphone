//
//  SCAppUtils.h
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

@interface MREntitiesConverter : NSObject <NSXMLParserDelegate> {
	@private
	NSMutableString *resultString;
}

- (NSString *)convertEntitiesInString:(NSString *)s;

@end
