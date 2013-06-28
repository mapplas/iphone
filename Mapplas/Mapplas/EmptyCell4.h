//
//  EmptyCell4.h
//  Mapplas
//
//  Created by Belén  on 26/06/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptyCell4 : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *title;
@property (nonatomic, strong) IBOutlet UILabel *subtitle;
@property (nonatomic, strong) IBOutlet UILabel *pull;

- (void)load;

@end
