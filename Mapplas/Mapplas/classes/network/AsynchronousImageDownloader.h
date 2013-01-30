//
//  AsynchronousImageDownloader.h
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "ImageDownloader.h"
#import "DownloadedImageSuccess.h"
#import "DownloadedImageError.h"

@protocol AsynchronousImageDownloaderProtocol <NSObject>

- (void)imageDownloaded:(DownloadedImageSuccess *)download withSaveName:(NSString *)save_name;
- (void)imageNotDownloaded:(DownloadedImageError *)error withSaveName:(NSString *)save_name;

@end

@interface AsynchronousImageDownloader : NSObject <ImageDownloader> {
	NSOperationQueue *queue;
	id<AsynchronousImageDownloaderProtocol> delegate;
}

- (id)initWithDelegate:(id<AsynchronousImageDownloaderProtocol>)use_delegate;

@end
