//
//  RatingModalViewController.m
//  Mapplas
//
//  Created by Belén  on 05/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "RatingModalViewController.h"

@interface RatingModalViewController ()
- (void)pop;
- (void)popAndSave;
- (void)initLayoutComponents;
@end

@implementation RatingModalViewController

@synthesize ratingView, rateItLabel, ratingLabel;
@synthesize titleField, commentField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"nav_bar_button_done", @"Navigation bar button - Done") style:UIBarButtonSystemItemCancel target:self action:@selector(popAndSave)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"nav_bar_button_cancel", @" Navigation bar button - Cancel") style:UIBarButtonSystemItemCancel target:self action:@selector(pop)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    
    [self initLayoutComponents];
}

#pragma mark - Private methods
- (void)pop {
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)popAndSave {
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)initLayoutComponents {
    self.rateItLabel.text = NSLocalizedString(@"app_rating_rate_it_text", @"Rating - rate it text");
    
    // Rating    
    DYRateView *rateView = [[DYRateView alloc] initWithFrame:CGRectMake(self.ratingView.frame.origin.x, self.ratingView.frame.origin.y, self.ratingView.frame.size.width, self.ratingView.frame.size.height)];
    rateView.rate = 5.0;
    rateView.delegate = self;
    rateView.editable = YES;
    rateView.alignment = RateViewAlignmentCenter;
    
    [self.view addSubview:rateView];

    self.ratingLabel.text = NSLocalizedString(@"app_rating_excellent_app", @"Rating - excellent app");
    
    // Title and comment
    self.titleField.placeholder = NSLocalizedString(@"app_rating_modal_title_text", @"Rating modal screen - Title text");
    self.commentField.placeholder = NSLocalizedString(@"app_rating_modal_review_text", @"Rating modal screen - Review text");
}

#pragma mark - DYRateViewDelegate method
- (void)rateView:(DYRateView *)rateView changedToNewRate:(NSNumber *)rate {
    RatingHelper *helper = [[RatingHelper alloc] init];
    self.ratingLabel.text = [helper getText:[rate intValue]];
}

#pragma mark - UITextFieldDelegate method
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.titleField]) {
        // Found next responder, so set it.
        [self.commentField becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; 
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0) {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0) {
        heightFraction = 1.0;
    }
    
    animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);

    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

@end
