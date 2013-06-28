//
//  EmptyCell.m
//  Mapplas
//
//  Created by Belén  on 26/06/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "EmptyCell.h"

@implementation EmptyCell

@synthesize title, subtitle, pull;

- (void)load {
    self.title.text = NSLocalizedString(@"comming_soon_title", @"");
    self.subtitle.text = NSLocalizedString(@"comming_soon_subtitle", @"");
    self.pull.text = NSLocalizedString(@"comming_soon_pull", @"");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];
}

@end
