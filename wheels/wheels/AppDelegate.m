//
//  AppDelegate.m
//  wheels
//
//  Created by 陳 駿逸 on 13/5/19.
//  Copyright (c) 2013年 陳 駿逸. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"                    //判斷網路是否可用
#import "MBProgressHUD.h"                   //Alert HUD
#import "UIImage+ResizeAdditions.h"         //重新定義UIImage大小
#import "AYIWelcomeViewController.h"        //歡迎畫面
#import "AYILogInViewController.h"          //登入畫面

@interface AppDelegate(){
    NSMutableArray *_date;                  //FB之照片資料
    BOOL firstLaunch;                       //是否第一次啟動
}
@property (nonatomic, strong) AYIWelcomeViewController  *welcomViewController;          //歡迎畫面
@property (nonatomic, strong) AYILogInViewController    *loginViewController;           //登入畫面
@property (nonatomic, strong) MBProgressHUD *hud;                                       //Alert過程
@property (nonatomic, strong) NSTimer *autoFollowTimer;                                 //定時器追蹤朋友Follow
@property (nonatomic, strong) Reachability *hostReach;                                  //判斷網路是否可用
@property (nonatomic, strong) Reachability *internetReach;                              //判斷網路是否可用
@property (nonatomic, strong) Reachability *wifiReach;                                  //判斷wifi網路是否可用
@property (nonatomic, strong) NSDictionary *userLocationInforForSave;                   //儲存經緯資料用
@property (nonatomic, strong) NSDictionary *userInfoSave;                               //userInfo全域變數

- (void)setupAppearance;                                                                //設定主題界面
- (BOOL)shouldProceedToMain2Interface:(PFUser *)user;
- (BOOL)shouldProceedToMainInterface:(PFUser *)user;                                    //如果當前用戶是Facebook用戶，繼續執行主界面，如果不是就不回傳NO。
- (BOOL)handleActionURL:(NSURL *)url;                                                   //偵測動作URL_照相機跟相簿偵測
//計時器
- (void) fireAtimer;
- (void) gotoHappenL2:(NSTimer *)timer;
@end

@implementation AppDelegate
@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize tabBarController;
@synthesize navController;
@synthesize networkStatus;
@synthesize welcomViewController;                   //歡迎畫面
@synthesize loginViewController;                    //登入畫面
@synthesize hud;                                    //Alert過程
@synthesize autoFollowTimer;                        //定時器追蹤朋友Follow
@synthesize hostReach;                              //判斷網路是否可用
@synthesize internetReach;                          //判斷網路是否可用
@synthesize wifiReach;                              //判斷wifi網路是否可用
@synthesize filterDistance;
@synthesize currentLocation;
@synthesize userLocationInforForSave;               //儲存經緯資料用
@synthesize wheelsUser;                             //要將用戶資料傳到下一個畫面用
@synthesize userInfoSave;                           //userInfo全域變數



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
