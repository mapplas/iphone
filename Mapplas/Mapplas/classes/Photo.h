//
//  Photo.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

@interface Photo : NSObject {
    NSNumber *_photoId;
    NSNumber *_userId;
    NSNumber *_appId;
    NSString *_date;
    NSString *_comment;
    NSString *_photo;
    NSString *_hour;
}

- (id)init;

@property (nonatomic, strong) NSNumber *photoId;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSNumber *appId;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *hour;

@end
