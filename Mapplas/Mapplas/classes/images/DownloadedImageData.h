//
//  DownloadedImageData.h
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

@interface DownloadedImageData : NSObject {
	NSString *path;
}

@property (nonatomic, retain) NSString *path;

- (id)initWithPath:(NSString *)image_path;

@end
