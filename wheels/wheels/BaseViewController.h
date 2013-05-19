//
//  BaseViewController.h
//  Wheels
//
//  Created by 陳 駿逸 on 13/2/9.
//  Copyright (c) 2013年 陳 駿逸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UITabBarController

// Create a view controller and setup it's tab bar item with a title and image
- (UIViewController *) viewControllerWithTabTitle:(NSString *)title image:(UIImage *)image;
// Create a custom UIButton and add it to the center of our tab bar
//- (void) addCenterButtonWithOptions:(NSDictionary *)options;

@end
