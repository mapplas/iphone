//
//  DownloadedImageController.h
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

@interface DownloadedImageController : NSObject {
	NSString *url;
	UIImageView *targetView;
	UIImage *downloadedImage;
	SEL action;
	SEL action_on_fail;
	NSString *path;
	id delegate;
	NSMutableArray *removeViews;
}

@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) UIImageView *targetView;
@property (nonatomic, retain) UIImage *downloadedImage;
@property SEL action;
@property SEL action_on_fail;
@property (nonatomic, retain) NSString *path;
@property (nonatomic, strong) id delegate;
@property (nonatomic, retain) NSMutableArray *removeViews;

- (id)initWithUrl:(NSString *)connect_url withView:(UIImageView *)with_view delegate:(id)delegate_to executeAction:(SEL)execute_action executeActionOnFail:(SEL)execute_on_fail path:(NSString *)image_path;
- (void)finish;

@end
