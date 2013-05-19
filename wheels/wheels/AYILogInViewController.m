//
//  AYILogInViewController.m
//  Wheels
//
//  Created by 陳 駿逸 on 13/2/10.
//  Copyright (c) 2013年 陳 駿逸. All rights reserved.
//

#import "AYILogInViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface AYILogInViewController ()

@end

@implementation AYILogInViewController
@synthesize locationManager = _locationManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    // There is no documentation on how to handle assets with the taller iPhone 5 screen as of 9/13/2012
    if ([UIScreen mainScreen].bounds.size.height > 480.0f) {
        // for the iPhone 5
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Default-568h.png"]];
    } else {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Default.png"]];
    }
    
//    NSString *text = NSLocalizedStringFromTable(@"msgWelcome", @"InfoPlist", @"登入畫面");
//    CGSize textSize = [text sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0f] constrainedToSize:CGSizeMake( 255.0f, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
//    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake( ([UIScreen mainScreen].bounds.size.width - textSize.width)/2.0f, 350.0f, textSize.width, textSize.height)];
//    [textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0f]];
//    [textLabel setLineBreakMode:NSLineBreakByWordWrapping];
//    [textLabel setNumberOfLines:0];
//    [textLabel setText:text];
//    [textLabel setTextColor:[UIColor colorWithRed:214.0f/255.0f green:206.0f/255.0f blue:191.0f/255.0f alpha:1.0f]];
//    [textLabel setBackgroundColor:[UIColor clearColor]];
//    [textLabel setTextAlignment:NSTextAlignmentCenter];
//    [self.logInView addSubview:textLabel];
    
    [self.logInView setLogo:nil];
    
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorized) {
        // if locationManager does not currently exist, create it
        if (!_locationManager)
        {
            _locationManager = [[CLLocationManager alloc] init];
            [_locationManager setDelegate:self];
            _locationManager.distanceFilter = 10.0f; // we don't need to be any more accurate than 10m
//            _locationManager.purpose = @"開啟定位通知！";
        }
    }
    
//    [self.logInView.facebookButton setBackgroundImage:[UIImage imageNamed:@"Facebook.png"] forState:UIControlStateNormal];
    [self.logInView.facebookButton setTitle:NSLocalizedStringFromTable(@"StartBtn", @"InfoPlist", @"登入畫面") forState:UIControlStateNormal];
    [self.logInView.facebookButton setTitle:NSLocalizedStringFromTable(@"StartBtn", @"InfoPlist", @"登入畫面") forState:UIControlStateHighlighted];
    self.logInView.facebookButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15.0f];
}

- (void)viewDidLayoutSubviews {
    // Set frame for elements
    NSLog(@"hight = %f",self.view.frame.size.height);
    if (self.view.frame.size.height > 560) {
        [self.logInView.facebookButton setFrame:CGRectMake(52, 438, 208, 50)];
    }else{
        [self.logInView.facebookButton setFrame:CGRectMake(52, 383, 208, 50)];
    }
    
    [self.logInView.facebookButton setBackgroundImage:[UIImage imageNamed:@"Splash_FB_button.png"] forState:UIControlStateNormal];
    [self.logInView.facebookButton setBackgroundImage:[UIImage imageNamed:@"Splash_FB_button_pressed.png"] forState:UIControlStateHighlighted];
    [self.logInView.facebookButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
