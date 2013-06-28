//
//  ImageResizer.m
//  Mapplas
//
//  Created by Belén  on 30/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "ImageResizer.h"

@implementation ImageResizer

static inline double radians (double degrees) {return degrees * M_PI/180;}

- (UIImageView *)getImageViewForImage:(UIImage *)_image contentOffset:(CGFloat)content_offset scroll:(UIScrollView *)scroll andMargin:(CGFloat)margin {
    return [[UIImageView alloc] initWithFrame:CGRectMake(content_offset, 0, 320 - (2 * margin), scroll.frame.size.height)];
}

- (UIImage *)resizeImage:(UIImage *)_image {
    CGSize newSize = CGSizeMake(220, 330);
    int height = newSize.height;
    int width = newSize.width;
    
    CGImageRef imageRef = [_image CGImage];
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGColorSpaceCreateDeviceRGB();
    
    if (alphaInfo == kCGImageAlphaNone)
        alphaInfo = kCGImageAlphaNoneSkipLast;
    
    CGContextRef bitmap;
    
    if (_image.imageOrientation == UIImageOrientationUp | _image.imageOrientation == UIImageOrientationDown) {
        bitmap = CGBitmapContextCreate(NULL, width, height, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, alphaInfo);
        
    } else {
        bitmap = CGBitmapContextCreate(NULL, height, width, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, alphaInfo);
        
    }
    
    if (_image.imageOrientation == UIImageOrientationLeft) {
        CGContextRotateCTM (bitmap, radians(90));
        CGContextTranslateCTM (bitmap, 0, -height);
        
    } else if (_image.imageOrientation == UIImageOrientationRight) {
        CGContextRotateCTM (bitmap, radians(-90));
        CGContextTranslateCTM (bitmap, -width, 0);
        
    } else if (_image.imageOrientation == UIImageOrientationUp) {
        
    } else if (_image.imageOrientation == UIImageOrientationDown) {
        CGContextTranslateCTM (bitmap, width,height);
        CGContextRotateCTM (bitmap, radians(-180.));
        
    }
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, width, height), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage *result = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return result;
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
