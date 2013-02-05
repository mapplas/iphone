//
//  ImageDownloader.h
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

@protocol ImageDownloader <NSObject>

- (UIImage *)downloadImage:(NSString *)path withSavePath:(NSString *)save_name;
@end
