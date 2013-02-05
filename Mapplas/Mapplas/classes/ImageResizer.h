//
//  ImageResizer.h
//  Mapplas
//
//  Created by Belén  on 30/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//


@interface ImageResizer : NSObject {
    UIScrollView *scroll;
}

- (id)initWithScroll:(UIScrollView *)_scroll;
- (UIImageView *)getImageViewForImage:(UIImage *)_image contentOffset:(CGFloat)content_offset background:(UIView *)gallery_background container:(UIView *)gallery_container;
- (UIImage *)resizeImage:(UIImage *)_image;

@end
