//
//  ScrollViewOfViews.h
//  Mapplas
//
//  Created by Belén  on 31/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

@interface ScrollViewOfViews : NSObject <UIGestureRecognizerDelegate> {
	NSMutableArray *views;
	UIScrollView *scrollView;
}

@property (nonatomic, strong) NSMutableArray *views;
@property (nonatomic, strong) UIScrollView *scrollView;

- (id)initWithViews:(NSMutableArray *)add_views inScrollView:(UIScrollView *)scroll_view delegate:(id)assign_delegate;
- (void)organize;
- (CGFloat)concatView:(UIView *)current_view toScrollView:(UIScrollView *)scroll_view currentYPosition:(CGFloat)currentYPosition;
- (NSUInteger)count;
- (void)removeView:(UIView *)view_to_remove;

@end
