//
//  DownloadedImageData.m
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "DownloadedImageData.h"


@implementation DownloadedImageData

@synthesize path;

- (id)initWithPath:(NSString *)image_path {
	self = [super init];

	if(self) {
		self.path = image_path;
	}

	return self;
}

@end
