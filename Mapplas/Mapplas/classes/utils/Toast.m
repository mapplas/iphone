//
//  Toast.m
//  Mapplas
//
//  Created by Belén  on 05/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "Toast.h"

@implementation Toast

- (id)initAndShowIn:(UIView *)show_in_view withText:(NSString *)text {
    self = [super init];
    if (self) {
        hud = [[MBProgressHUD alloc] initWithView:show_in_view];
		[show_in_view addSubview:hud];
		[hud setCustomView:[[UIView alloc] init]];
		[hud setMode:MBProgressHUDModeCustomView];
		[hud setAnimationType:MBProgressHUDAnimationFade];
		[hud setLabelFont:[UIFont fontWithName:@"helvetica neue" size:13]];
		[hud setLabelText:text];		
		
		CGFloat offset = show_in_view.bounds.size.height / 4.25;
		[hud setYOffset:offset];

		[hud setMargin:8];
	}
    return self;
}

- (void)show {
	[hud hide:YES afterDelay:3];
	[hud show:YES];
}

@end
