//
//  ImageLoaderFactory.h
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "ImageLoader.h"
#import "ImageDownloader.h"

@interface ImageLoaderFactory : NSObject

- (ImageLoader *)createUsingCacheFolderWithDownloader:(id<ImageDownloader>)downloader;

@end
