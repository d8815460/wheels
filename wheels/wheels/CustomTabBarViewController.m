//
//  CustomTabBarViewController.m
//  Wheels
//
//  Created by 陳 駿逸 on 13/2/9.
//  Copyright (c) 2013年 陳 駿逸. All rights reserved.
//

#import "CustomTabBarViewController.h"

@interface CustomTabBarViewController ()

@end

@implementation CustomTabBarViewController
@synthesize allowLanscape;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    int idx = (self.viewControllers.count / 2);
//    UIViewController *controller = (self.viewControllers)[idx];
//    NSString *string = controller.title ? controller.title : @" ";
//    [self addCenterButtonWithOptions:@{@"buttonImage": @"tabbar-center.png"
//     , @"icon": @"ButtonCameraSelected.png"
//     , @"title": string}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
