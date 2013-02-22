//
//  LandscapeImageGalleryViewController.h
//  Mapplas
//
//  Created by Belén  on 22/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageResizer.h"

@interface LandscapeImageGalleryViewController : UIViewController <UIScrollViewDelegate> {
    NSMutableDictionary *imagesArray;
}

@property (nonatomic, strong) IBOutlet UIView *background;
@property (nonatomic, strong) IBOutlet UIScrollView *scroll;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

- (id)initWithImagesArray:(NSMutableDictionary *)images_array;

@end
