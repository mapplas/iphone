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

- (void)sendImageToDelegate:(NSArray *)data {
	[delegate imageDownloaded:[data objectAtIndex:0] withSaveName:[data objectAtIndex:1]];
}

- (void)sendErrorToDelegate:(NSArray *)data {
	[delegate imageNotDownloaded:[data objectAtIndex:0] withSaveName:[data objectAtIndex:1]];
}

- (void)executeDownload:(NSArray *)params {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
	NSError *error = nil;
	NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[params objectAtIndex:0]] options:NSDataReadingUncached error:&error];

	if(error == nil) {
		UIImage *image = [[UIImage alloc] initWithData:data];
		DownloadedImageSuccess *data = [[DownloadedImageSuccess alloc] initWithPath:[params objectAtIndex:0] andImage:image];
        NSArray *toPass = [[NSArray alloc] initWithObjects:data, [params objectAtIndex:1], nil];
		[self performSelectorOnMainThread:@selector(sendImageToDelegate:) withObject:toPass waitUntilDone:YES];
	}
	else {
        DownloadedImageError *data = [[DownloadedImageError alloc] initWithPath:[params objectAtIndex:0] andError:error];
        NSArray *toPass = [[NSArray alloc] initWithObjects:data, [params objectAtIndex:1], nil];
		[self performSelectorOnMainThread:@selector(sendErrorToDelegate:) withObject:toPass waitUntilDone:YES];
	}

	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (UIImage *)downloadImage:(NSString *)path withSavePath:(NSString *)save_name {
    NSArray *params = [[NSArray alloc] initWithObjects:path, save_name, nil];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
																			selector:@selector(executeDownload:)
																			  object:params
										];
	[queue addOperation:operation];

	return nil;
}

@end
