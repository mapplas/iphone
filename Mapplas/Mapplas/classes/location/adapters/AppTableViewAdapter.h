//
//  AppTableViewAdapter.h
//  Mapplas
//
//  Created by Belén  on 23/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperModel.h"

@interface AppTableViewAdapter : NSObject <UITableViewDelegate, UITableViewDataSource> {
    SuperModel *model;
}

- (id)initWithModel:(SuperModel *)_model;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
