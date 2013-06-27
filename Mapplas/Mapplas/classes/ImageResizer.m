//
//  ImageResizer.m
//  Mapplas
//
//  Created by Belén  on 30/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "ImageResizer.h"

@implementation ImageResizer

- (id)initWithScroll:(UIScrollView *)_scroll {
    self = [super init];
    if (self) {
        scroll = _scroll;
    }
    return self;
}

- (UIImageView *)getImageViewForImage:(UIImage *)_image contentOffset:(CGFloat)content_offset background:(UIView *)gallery_background container:(UIView *)gallery_container {
    return [[UIImageView alloc] initWithFrame:CGRectMake(content_offset, 0, scroll.frame.size.width, scroll.frame.size.height)];
}

- (UIImage *)resizeImage:(UIImage *)_image {
    NSUInteger constantw = 280;
    
    NSUInteger height = _image.size.height;
    NSUInteger width = _image.size.width;
    float ratio = (float)width / (float)height;
    
    height = constantw;
    width = constantw;
    
    if (_image.size.width > _image.size.height) {
        height = constantw / ratio;
        height = height * 0.8;
        width = width * 0.8;
    }
    else {
        width = constantw * ratio;
        height = height * 0.8;
        width = width * 0.8;
    }
    
    return [_image resizedImage:CGSizeMake((NSInteger)width, (NSInteger)height) interpolationQuality:kCGInterpolationHigh];
}

- (UIImage *)resizeImageForFullscreenView:(UIImage *)_image {
    NSUInteger constantw = 280;
    
    NSUInteger height = _image.size.height;
    NSUInteger width = _image.size.width;
    float ratio = (float)width / (float)height;
    
    height = constantw;
    width = constantw;
    
    if (_image.size.width > _image.size.height) {
        height = constantw / ratio;
        height = height * 1.3;
        width = width * 1.3;
    }
    else {
        width = constantw * ratio;
        height = height * 1.3;
        width = width * 1.3;
    }
    
    return [_image resizedImage:CGSizeMake((NSInteger)width, (NSInteger)height) interpolationQuality:kCGInterpolationHigh];
}

@end
