//
//  DownloadedImageSuccess.h
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "DownloadedImageData.h"

@interface DownloadedImageSuccess : DownloadedImageData {
	UIImage *image;
}

@property (nonatomic, retain) UIImage *image;

- (id)initWithPath:(NSString *)image_path andImage:(UIImage *)image_object;

@end
