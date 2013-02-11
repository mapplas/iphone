//
//  MutableScrollViewOfViews.h
//  Mapplas
//
//  Created by Belén  on 31/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "ScrollViewOfViews.h"

@interface MutableScrollViewOfViews : ScrollViewOfViews {
	NSMutableDictionary *viewForTag;
}

- (id)initWithScrollView:(UIScrollView *)scroll_view delegate:(id)assign_delegate;
- (void)addView:(id)view;
- (void)empty;
- (void)emptyFromPosition:(NSUInteger)from_position;

- (void)addView:(id)view withTag:(NSString *)_tag;
- (id)obtainViewWithTag:(NSString *)_tag;
- (void)removeView:(id)view;

@end
