//
//  DownloadedImageError.h
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "DownloadedImageData.h"

@interface DownloadedImageError : DownloadedImageData {
	NSError *error;
}

@property (nonatomic, retain) NSError *error;

- (id)initWithPath:(NSString *)image_path andError:(NSError *)download_error;

@end
