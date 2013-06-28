//
//  ScrollViewOfViews.m
//  Mapplas
//
//  Created by Belén  on 31/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "ScrollViewOfViews.h"

@implementation ScrollViewOfViews

@synthesize views;
@synthesize scrollView;

- (CGFloat)concatView:(UIView *)current_view toScrollView:(UIScrollView *)scroll_view currentYPosition:(CGFloat)currentYPosition {
	CGRect frame = current_view.frame;
	frame.origin = CGPointMake(0, currentYPosition);
	current_view.frame = frame;
	
	return frame.size.height;
}

#pragma mark -
#pragma mark initialization

- (id)initWithViews:(NSMutableArray *)add_views inScrollView:(UIScrollView *)scroll_view delegate:(id)assign_delegate{
	self = [super init];
	
	self.views = add_views;
	self.scrollView = scroll_view;

    [self.scrollView setCanCancelContentTouches:NO];
	
	self.scrollView.clipsToBounds = YES;
	self.scrollView.scrollEnabled = YES;
	
	return self;
}

#pragma mark -
#pragma mark public methods

- (void)organize {
	CGFloat currentY = 0;
	
	for (UIView *current_view in [scrollView subviews]) {
		[current_view removeFromSuperview];
	}
    
    for (id current in self.views) {
		UIView *current_view = nil;
        if([current isKindOfClass:[UIView class]]) {
			current_view = (UIView *)current;
		}
		else if([current isKindOfClass:[UIViewController class]]) {
			UIViewController *currentController = (UIViewController *)current;
			current_view = currentController.view;
		}
        
		if(current_view != nil) {
			[self.scrollView addSubview:current_view];
			currentY += [self concatView:current_view toScrollView:self.scrollView currentYPosition:currentY];
		}
	}

	[self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, currentY)];
}

- (NSUInteger)count {
	return [[self.scrollView subviews] count]; 
}

- (void)removeView:(UIView *)view_to_remove {
    [self.views removeObject:view_to_remove];
    [self organize];
}

@end
