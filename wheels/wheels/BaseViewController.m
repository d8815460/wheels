//
//  BaseViewController.m
//  Wheels
//
//  Created by 陳 駿逸 on 13/2/9.
//  Copyright (c) 2013年 陳 駿逸. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

// Create a view controller and setup it's tab bar item with a title and image
-(UIViewController*) viewControllerWithTabTitle:(NSString*) title image:(UIImage*)image
{
    UIViewController* viewController = [[UIViewController alloc] init];
    viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image tag:0];
    return viewController;
}

// Create a custom UIButton and add it to the center of our tab bar
//-(void) addCenterButtonWithOptions:(NSDictionary *)options {
//    UIImage *buttonImage = [UIImage imageNamed:options[@"buttonImage"]];
//    UIImage *highlightImage = [UIImage imageNamed:options[@"highlightImage"]];
//    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
//    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
//    [button setBackgroundImage:highlightImage forState:UIControlStateNormal];
//    [button setBackgroundImage:buttonImage forState:UIControlStateHighlighted];
//    [button addTarget:self action:@selector(showModalController) forControlEvents:UIControlEventTouchUpInside];
//    
//    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
//    if (heightDifference < 0)
//        button.center = self.tabBar.center;
//    else {
//        CGPoint center = self.tabBar.center;
//        center.y = center.y - heightDifference/2.0;
//        button.center = center;
//    }
//    
//    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(3, buttonImage.size.height-14, buttonImage.size.width - 6, 14)];
//    lblName.text = options[@"title"];
//    lblName.font = [UIFont boldSystemFontOfSize:10.0f];
//    lblName.textAlignment = UITextAlignmentCenter;
//    lblName.textColor = [UIColor whiteColor];
//    lblName.backgroundColor = [UIColor clearColor];
//    [button addSubview:lblName];
//    
//    UIImageView *imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(3, 10, buttonImage.size.width - 6, buttonImage.size.height - lblName.bounds.size.height - 3)];
//    imgIcon.contentMode = UIViewContentModeCenter;
//    imgIcon.image = [UIImage imageNamed:options[@"icon"]];
//    [button addSubview:imgIcon];
//    
//    [self.view addSubview:button];
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (void)showModalController {
//    UIViewController *modal = [self.storyboard instantiateViewControllerWithIdentifier:@"choseCategoryController"];
//    [self presentViewController:modal animated:YES completion:nil];
////    [self presentModalViewController:modal animated:YES];
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
