//
//  ImageLoader.m
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "ImageLoader.h"
#import "DownloadedImageController.h"

@implementation ImageLoader

- (id)initWithFileManager:(ImageFileManager *)image_file_manager folder:(CacheFolder *)cache_folder downloader:(id<ImageDownloader>)downloader {
	self = [super init];

	if(self) {
		imageFileManager = image_file_manager;
		imageDownloader = downloader;
		cacheFolder = cache_folder;
	}
	
	return self;
}

#pragma mark -
#pragma mark Cache handling

- (UIImage *)loadImageFromCache:(NSNumber *)path {
	return [imageFileManager loadImage:path folder:cacheFolder];
}

- (NSError *)saveImageInCache:(UIImage *)image path:(NSNumber *)path {
	return [imageFileManager saveImage:image path:path folder:cacheFolder];
}


#pragma mark -
#pragma mark Download image

- (UIImage *)downloadImage:(NSString *)path withSavePaht:(NSNumber *)save_path {
	return [imageDownloader downloadImage:path withSavePath:save_path];
}

#pragma mark - Public methods

- (UIImage *)load:(NSString *)path withSaveName:(NSNumber *)save_name {
	
	// First try: cache
	UIImage *image = [self loadImageFromCache:save_name];
	if(image != nil) {
		return image;
	}
	
	// Second try: download
    [self downloadImage:path withSavePaht:save_name];
	
	return image;
}

@end
