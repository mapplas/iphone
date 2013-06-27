//
//  ImageGalleryViewController.m
//  Mapplas
//
//  Created by Belén  on 21/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "ImageGalleryViewController.h"

@interface ImageGalleryViewController ()
- (void)pop;
- (void)configureGallery;
@end

@implementation ImageGalleryViewController

@synthesize background, scroll, pageControl;

- (id)initWithImagesArray:(NSMutableDictionary *)images_array {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        imagesArray = images_array;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"nav_bar_button_cancel", @" Navigation bar button - Cancel") style:UIBarButtonSystemItemCancel target:self action:@selector(pop)];
    
    [self configureGallery];
}

- (void)pop {
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)configureGallery {
	CGFloat contentOffset = 0.0f;
    ImageResizer *resizer = [[ImageResizer alloc] initWithScroll:self.scroll];
    NSArray *keys = [imagesArray allKeys];
    
    self.scroll.clipsToBounds = NO;
	self.scroll.pagingEnabled = YES;
    self.scroll.showsHorizontalScrollIndicator = NO;
    self.scroll.delegate = self;
    
    self.pageControl.numberOfPages = keys.count;
    self.pageControl.currentPage = 0;
    
    if (keys.count > 0) {
        for (NSString *currentKey in keys) {
            UIImage *currentImage = [imagesArray objectForKey:currentKey];
            
            if (currentImage != nil && ![currentImage isKindOfClass:[NSString class]]) {
                UIImageView *imageView = [resizer getImageViewForImage:currentImage contentOffset:contentOffset background:self.background container:self.view];
                                
                imageView.image = [resizer resizeImageForFullscreenView:currentImage];
                
                if (imageView.image.size.height < imageView.image.size.width) {
                    // Rotate
                    imageView.center = CGPointMake(100.0, 100.0);
                    imageView.transform = CGAffineTransformMakeRotation(M_PI+ M_PI_2); // Rotation in radians 270
                    
                    imageView.frame = CGRectMake(contentOffset, -20, imageView.frame.size.height, imageView.frame.size.width);
                }
                
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                                
                [self.scroll addSubview:imageView];
                
                contentOffset += imageView.frame.size.width;
                self.scroll.contentSize = CGSizeMake(contentOffset, 300);
            }
        }
    }
}

#pragma mark - UIScrollViewDelegate methods - PageControl
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.scroll.frame.size.width;
    int page = floor((self.scroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= [imagesArray allKeys].count) return;
}

@end
