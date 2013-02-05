//
//  Toast.h
//  Mapplas
//
//  Created by Belén  on 05/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "MBProgressHUD.h"

@interface Toast : NSObject {
	MBProgressHUD *hud;
}

- (id)initAndShowIn:(UIView *)show_in_view withText:(NSString *)text;
- (void)show;

@end
