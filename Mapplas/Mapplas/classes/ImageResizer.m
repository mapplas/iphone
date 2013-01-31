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

- (UIImage *)resizeImage:(UIImage *)_image {
    // Screen size
//    CGRect screenBound = [[UIScreen mainScreen] bounds];
//    CGSize screenSize = screenBound.size;
//    CGFloat screenWidth = screenSize.width;
//    
//    NSUInteger constantw = 480;
//    if (screenWidth >= 480) {
//        constantw = 480;
//    }
//    else {
//        constantw = 320;
//    }
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
