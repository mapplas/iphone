//
//  Photo.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

@interface Photo : NSObject {
    NSNumber *_photoId;
    NSString *_photo;
}

- (id)init;

@property (nonatomic, strong) NSNumber *photoId;
@property (nonatomic, strong) NSString *photo;

@end
