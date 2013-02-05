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
    CGRect imageViewFrame = CGRectMake(content_offset, 0, scroll.frame.size.width, scroll.frame.size.height);
    
    if (_image.size.width < _image.size.height) {
        scroll.frame = CGRectMake(20, 0, 280, 300);
        gallery_background.frame = CGRectMake(0, 0, 320, scroll.frame.size.height);
        gallery_container.frame = CGRectMake(0, 0, 320, scroll.frame.size.height);
        imageViewFrame = CGRectMake(content_offset, 0, scroll.frame.size.width, scroll.frame.size.height);
    }
    
    return [[UIImageView alloc] initWithFrame:imageViewFrame];
}

- (UIImage *)resizeImage:(UIImage *)_image {
    NSUInteger constantw = 480;
    
    NSUInteger h = _image.size.height;
    NSUInteger w = _image.size.width;
    float ratio = (float)w / (float)h;
    
    if (w > h) {
        h = constantw / ratio;
    }
    else {
        w = constantw * ratio;
    }
    
    UIImage *newImage = _image;
    
    if (h > scroll.frame.size.height) {
        // Resize image    
        CGSize newSize = CGSizeMake(w/1.5, h/1.5);  //whaterver size
        UIGraphicsBeginImageContext(newSize);
        [_image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return newImage;
}

@end
