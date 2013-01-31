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
- (UIImage *)resizeImage:(UIImage *)_image;

@end
