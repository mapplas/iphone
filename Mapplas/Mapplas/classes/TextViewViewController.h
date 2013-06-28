//
//  TextViewViewController.h
//  Mapplas
//
//  Created by Belén  on 19/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewViewController : UIViewController {
    NSString *textToShow;
}

@property (nonatomic, strong) IBOutlet UIWebView *webView;

- (id)initWithTextToShow:(NSString *)text_to_show;

@end
