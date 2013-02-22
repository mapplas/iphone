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
    ImageResizer *resizer = [[ImageResizer alloc] initWithScroll:scroll];
    
    NSArray *keys = [imagesArray allKeys];
    
    self.scroll.clipsToBounds = NO;
	self.scroll.pagingEnabled = YES;
    self.scroll.showsHorizontalScrollIndicator = NO;
    self.scroll.delegate = self;
    
    self.pageControl.numberOfPages = keys.count;
    self.pageControl.currentPage = 0;
    
    if (keys.count > 0) {
        for (NSString *currentKey in keys) {
            
            if ([imagesArray objectForKey:currentKey] != nil && ![[imagesArray objectForKey:currentKey] isKindOfClass:[NSString class]]) {
                UIImageView *imageView = [resizer getImageViewForImage:[imagesArray objectForKey:currentKey] contentOffset:contentOffset background:self.background container:self.view];
                
                imageView.image = [resizer resizeImageForFullscreenView:[imagesArray objectForKey:currentKey]];
                imageView.contentMode = UIViewContentModeCenter;
                
                [self.scroll addSubview:imageView];
                
                contentOffset += imageView.frame.size.width;
                self.scroll.contentSize = CGSizeMake(contentOffset, self.scroll.frame.size.height);
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
