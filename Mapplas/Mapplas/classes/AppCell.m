//
//  AppCell.m
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppCell.h"

@implementation AppCell

@synthesize imageLogo = _imageLogo;
@synthesize imageRoundView = _imageRoundView;
@synthesize app = _app;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadData {
    if (self.app.auxPin) {
        [self.imageRoundView setImage:[UIImage imageNamed:@"img_roundc_pinup.png"]];
    }
    else {
        [self.imageRoundView setImage:[UIImage imageNamed:@"img_roundc_btn.png"]];
    }
}

@end
