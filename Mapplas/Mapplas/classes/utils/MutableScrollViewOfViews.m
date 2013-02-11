//
//  MutableScrollViewOfViews.m
//  Mapplas
//
//  Created by Belén  on 31/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "MutableScrollViewOfViews.h"

@implementation MutableScrollViewOfViews

- (id)initWithViews:(NSMutableArray *)add_views inScrollView:(UIScrollView *)scroll_view delegate:(id)assign_delegate {

	self = [super initWithViews:add_views inScrollView:scroll_view delegate:assign_delegate];
	if(add_views == nil) {
		self.views = [NSMutableArray array];
		viewForTag = [[NSMutableDictionary alloc] init];
	}

	return self;
}

- (void)dismissKeyboard {
	for (id current in self.views) {
		
		UIView *current_view = nil;
		
		if([current isKindOfClass:[UIViewController class]]) {
			UIViewController *currentController = (UIViewController *)current;
        
            current_view = currentController.view;
		}
		else if([current isKindOfClass:[UIView class]]) {
			current_view = (UIView *)current;
		}
		for (UIView *current_text_field in current_view.subviews) {
			if([current_text_field isKindOfClass:[UITextField class]]) {
				[current_text_field resignFirstResponder];
			}
		}
	}
}

- (id)initWithScrollView:(UIScrollView *)scroll_view delegate:(id)assign_delegate {
	return [self initWithViews:nil inScrollView:scroll_view delegate:assign_delegate];
}

- (void)addView:(id)view {
	if (view != nil) {
		[self.views addObject:view];
	}
}

- (void)organize {
	CGFloat currentY = 0;
	
	for (UIView *current_subview in [scrollView subviews]) {
		[current_subview removeFromSuperview];
	}

	for (id current in self.views) {
		UIView *current_view = nil;
		if([current isKindOfClass:[UIViewController class]]) {
			UIViewController *currentController = (UIViewController *)current;
			current_view = currentController.view;
		}
		else if([current isKindOfClass:[UIView class]]) {
			current_view = (UIView *)current;
		}
		if(current_view != nil) {
			[self.scrollView addSubview:current_view];
			currentY += [super concatView:current_view toScrollView:self.scrollView currentYPosition:currentY];
		}
	}

	[self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, currentY)];
}

- (void)emptyFromPosition:(NSUInteger)from_position {
	NSUInteger count = self.views.count;
	//NSLog(@"from %d, count %d, range [%d,%d]", from_position, count, from_position, count-from_position);
	if (count > 0 && from_position < count) {
		[self.views removeObjectsInRange:NSMakeRange(from_position, count - from_position /*length of range*/)];
	}
}

- (void)empty {
	NSMutableArray *newArray = [[NSMutableArray alloc] init];
	self.views = newArray;
}

# pragma mark - Adding removing views with tag
- (void)addView:(id)view withTag:(NSString *)_tag {
	[self addView:view];
	[viewForTag setValue:view forKey:_tag];
}

- (id)obtainViewWithTag:(NSString *)_tag {
	return [viewForTag objectForKey:_tag];
}

- (void)removeView:(id)view {
	[self.views removeObject:view];
}

@end
