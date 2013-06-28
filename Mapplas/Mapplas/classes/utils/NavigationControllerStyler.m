//
//  NavigationControllerStyler.m
//  Mapplas
//
//  Created by Belén  on 27/06/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "NavigationControllerStyler.h"

@implementation NavigationControllerStyler

- (void)style:(UINavigationBar *)nav_bar andItem:(UINavigationItem *)nav_item {
    
    nav_bar.tintColor = [UIColor whiteColor];
    
    int height = nav_bar.frame.size.height;
    int width = 150;
    
    UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    navLabel.backgroundColor = [UIColor clearColor];
    navLabel.textColor = [UIColor colorWithRed:0.0f/255.0f green:153.0f/255.0f blue:204.0f/255.0f alpha:255.0f/255.0f];
    navLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:28];
    navLabel.textAlignment = UITextAlignmentCenter;
    
    nav_item.titleView = navLabel;
    
    ((UILabel *)nav_item.titleView).text = NSLocalizedString(@"nav_controller_title", @"Navigation controller title");
}

- (NSDictionary *)styleNavBarButtonToBlue:(BOOL)set_blue {
    if (set_blue) {
        return [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor colorWithRed:0.0f/255.0f green:153.0f/255.0f blue:204.0f/255.0f alpha:255.0f/255.0f],
                                    UITextAttributeTextColor,
                                    [UIColor clearColor],
                                    UITextAttributeTextShadowColor, nil];
        
    }
    else {
        return [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor],
                                    UITextAttributeTextColor,
                                    [UIColor clearColor],
                                    UITextAttributeTextShadowColor, nil];
    }
}

@end
