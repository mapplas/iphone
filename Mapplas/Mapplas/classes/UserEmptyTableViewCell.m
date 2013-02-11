//
//  UserEmptyTableViewCell.m
//  Mapplas
//
//  Created by belen on 11/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserEmptyTableViewCell.h"

@implementation UserEmptyTableViewCell

@synthesize emptyCellText;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];
}

@end
