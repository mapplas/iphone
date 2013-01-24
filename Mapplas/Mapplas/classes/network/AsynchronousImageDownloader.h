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

- (void)imageDownloaded:(DownloadedImageSuccess *)download;
- (void)imageNotDownloaded:(DownloadedImageError *)error;

@end

@interface AsynchronousImageDownloader : NSObject <ImageDownloader> {
	NSOperationQueue *queue;
	id<AsynchronousImageDownloaderProtocol> delegate;
}

- (id)initWithDelegate:(id<AsynchronousImageDownloaderProtocol>)use_delegate;

@end
