//
//  ImageResizer.h
//  Mapplas
//
//  Created by Belén  on 30/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UIImage+Resize.h"

@interface ImageResizer : NSObject

- (UIImageView *)getImageViewForImage:(UIImage *)_image contentOffset:(CGFloat)content_offset scroll:(UIScrollView *)scroll andMargin:(CGFloat)margin;
- (UIImage *)resizeImage:(UIImage *)_image;
- (UIImage *)resizeImageForFullscreenView:(UIImage *)_image;

@end
