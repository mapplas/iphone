//
//  DownloadedImageError.m
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "DownloadedImageError.h"


@implementation DownloadedImageError

@synthesize error;

- (id)initWithPath:(NSString *)image_path andError:(NSError *)download_error {
	self = [super initWithPath:image_path];

	if(self) {
		self.error = download_error;
	}
	
	return self;
}

@end
