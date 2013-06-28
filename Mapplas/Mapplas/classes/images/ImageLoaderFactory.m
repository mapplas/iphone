//
//  ImageLoaderFactory.m
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "ImageLoaderFactory.h"

@implementation ImageLoaderFactory

- (ImageLoader *)createUsingCacheFolderWithDownloader:(id<ImageDownloader>)downloader {
	FileManagement *fileManagement = [[FileManagement alloc] init];
	ImageFileManager *imageFileManager = [[ImageFileManager alloc] initWithFileManagement:fileManagement];
	CacheFolder *cacheFolder = [[CacheFolder alloc] init];
	
	return [[ImageLoader alloc] initWithFileManager:imageFileManager folder:cacheFolder downloader:downloader];
}

@end
