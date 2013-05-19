//
//  AppDelegate.h
//  wheels
//
//  Created by 陳 駿逸 on 13/5/19.
//  Copyright (c) 2013年 陳 駿逸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, NSURLConnectionDataDelegate, UITabBarControllerDelegate, PFLogInViewControllerDelegate>{
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BaseViewController *tabBarController;
@property (strong, nonatomic) UINavigationController *navController;

@property (nonatomic, readonly) int networkStatus;
@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, assign) CLLocationAccuracy filterDistance;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) PFUser *wheelsUser;

- (BOOL)isParseReachable;

- (void)presentLoginViewController;
- (void)presentLoginViewControllerAnimated:(BOOL)animated;
- (void)presentMeTabBarControllr;                           //轉場到Me
- (void)presentTabBarController;                            //轉場到Happening
- (void)presentWelcomeViewController;                       //回到歡迎及登入頁
- (void)logOut;


//使用FacebookSDK 3.5版新增
- (void)facebookRequestDidLoad:(id)result;
- (void)facebookRequestDidFailWithError:(NSError *)error;

@end
