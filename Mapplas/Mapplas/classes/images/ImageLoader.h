//
//  ImageLoader.h
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "ImageDownloader.h"
#import "ImageFileManager.h"
#import "CacheFolder.h"

@interface ImageLoader : NSObject {
	ImageFileManager *imageFileManager;
	id<ImageDownloader> imageDownloader;
	CacheFolder *cacheFolder;
}

- (id)initWithFileManager:(ImageFileManager *)image_file_manager folder:(CacheFolder *)cache_folder downloader:(id<ImageDownloader>)sync_downloader;
- (UIImage *)loadImageFromCache:(NSString *)path;
- (UIImage *)load:(NSString *)path withSaveName:(NSString *)save_name;
- (NSError *)saveImageInCache:(UIImage *)image path:(NSString *)path;

@end
