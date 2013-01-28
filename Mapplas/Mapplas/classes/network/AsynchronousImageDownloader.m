//
//  AsynchronousImageDownloader.m
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AsynchronousImageDownloader.h"
#import "Environment.h"

@implementation AsynchronousImageDownloader

- (id)initWithDelegate:(id<AsynchronousImageDownloaderProtocol>)use_delegate {
	self = [super init];

	if(self) {
		queue = [[NSOperationQueue alloc] init];
		delegate = use_delegate;
	}

	return self;
}

- (void)sendImageToDelegate:(DownloadedImageSuccess *)data {
	[delegate imageDownloaded:data];
}

- (void)sendErrorToDelegate:(DownloadedImageError *)error {
	[delegate imageNotDownloaded:error];
}

- (void)executeDownload:(NSString *)path {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
	NSError *error = nil;
	NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:path] options:NSDataReadingUncached error:&error];

	if(error == nil) {
		UIImage *image = [[UIImage alloc] initWithData:data];
		DownloadedImageSuccess *data = [[DownloadedImageSuccess alloc] initWithPath:path andImage:image];
		[self performSelectorOnMainThread:@selector(sendImageToDelegate:) withObject:data waitUntilDone:YES];
	}
	else {
		DownloadedImageError *data = [[DownloadedImageError alloc] initWithPath:path andError:error];
		[self performSelectorOnMainThread:@selector(sendErrorToDelegate:) withObject:data waitUntilDone:YES];
	}

	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (UIImage *)downloadImage:(NSString *)path {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
																			selector:@selector(executeDownload:)
																			  object:path
										];
	[queue addOperation:operation];

	return nil;
}

@end
