//
//  DownloadedImageController.m
//  Quomai
//
//  Created by Fran Naranjo on 06/03/11.
//  Copyright 2011 Quomai. All rights reserved.
//

#import "DownloadedImageController.h"


@implementation DownloadedImageController

@synthesize url;
@synthesize targetView;
@synthesize downloadedImage;
@synthesize action;
@synthesize action_on_fail;
@synthesize path;
@synthesize delegate;
@synthesize removeViews;

- (id)initWithUrl:(NSString *)connect_url withView:(UIImageView *)with_view delegate:(id)delegate_to executeAction:(SEL)execute_action executeActionOnFail:(SEL)execute_on_fail path:(NSString *)image_path {
	self = [super init];
	
	self.url = connect_url;
	self.targetView = with_view;
	self.action = execute_action;
	self.action_on_fail = execute_on_fail;
	self.path = image_path;
	
	self.delegate = delegate_to;
	self.removeViews = [[NSMutableArray alloc] init];
	
	return self;
}

- (void)finish {
	int count = [self.removeViews count];
	for(int i = 0; i < count; i++) {
		UIView *current = (UIView *)[self.removeViews objectAtIndex:i];
		[current removeFromSuperview];
	}
}

@end
