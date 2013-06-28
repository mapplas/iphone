//
//  DownloadedImageSuccess.h
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "DownloadedImageSuccess.h"

@implementation DownloadedImageSuccess

@synthesize image;

- (id)initWithPath:(NSString *)image_path andImage:(UIImage *)image_object {
	self = [super initWithPath:image_path];

	if(self) {
		self.image = image_object;
	}

	return self;
}

@end
