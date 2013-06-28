//
//  Comment.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

@interface Comment : NSObject {
    NSNumber *_commentId;
    NSNumber *_idUser;
    NSNumber *_idApp;
    NSNumber *_rate;
    NSString *_date;
    NSString *_hour;
    NSString *_comment;
}

- (id)init;

@property (nonatomic, strong) NSNumber *commentId;
@property (nonatomic, strong) NSNumber *idUser;
@property (nonatomic, strong) NSNumber *idApp;
@property (nonatomic, strong) NSNumber *rate;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *hour;
@property (nonatomic, strong) NSString *comment;

@end
