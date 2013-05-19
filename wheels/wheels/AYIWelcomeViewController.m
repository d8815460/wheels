//
//  AYIWelcomeViewController.m
//  Wheels
//
//  Created by 陳 駿逸 on 13/2/10.
//  Copyright (c) 2013年 陳 駿逸. All rights reserved.
//

#import "AYIWelcomeViewController.h"
#import "AppDelegate.h"
#import "AYILogInViewController.h"

@interface AYIWelcomeViewController ()

@end

@implementation AYIWelcomeViewController

- (void)loadView {
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    [backgroundImageView setContentMode:UIViewContentModeScaleToFill];
    self.view = backgroundImageView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    PFUser *currentUser = [PFUser currentUser];
    
    // If not logged in, present login view controller
    if (!currentUser) {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] presentLoginViewControllerAnimated:NO];
        return;
    }else if (currentUser.isNew){
        // Refresh current user with server side data -- checks if user is still valid and so on
        [[PFUser currentUser] refreshInBackgroundWithTarget:self selector:@selector(refreshCurrentUserCallbackWithResult:error:)];
    }else{
        // Refresh current user with server side data -- checks if user is still valid and so on
        [[PFUser currentUser] refreshInBackgroundWithTarget:self selector:@selector(refreshCurrentUserCallbackWithResult:error:)];
        
        // Present Anypic UI 引用AppDelegate的presentTabBarController
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] presentTabBarController];
    }
}

#pragma mark - ()

- (void)refreshCurrentUserCallbackWithResult:(PFObject *)refreshedObject error:(NSError *)error {
    // A kPFErrorObjectNotFound error on currentUser refresh signals a deleted user
    if (error && error.code == kPFErrorObjectNotFound) {
        NSLog(@"User does not exist.用戶不存在哦！");
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] logOut];
        return;
    }
    
    // Check if user is missing a Facebook ID
    if ([PAPUtility userHasValidFacebookData:[PFUser currentUser]]) {
        // User has Facebook ID.
        
        // refresh Facebook friends on each launch
        [FBRequestConnection startForMyFriendsWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(facebookRequestDidLoad:)]) {
                    [[UIApplication sharedApplication].delegate performSelector:@selector(facebookRequestDidLoad:) withObject:result];
                }
            } else {
                if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(facebookRequestDidFailWithError:)]) {
                    [[UIApplication sharedApplication].delegate performSelector:@selector(facebookRequestDidFailWithError:) withObject:error];
                }
            }
        }];
//*******************************舊版本Parse.framework及FacebookSDK.framework使用的方法*********************************
//        PF_FBRequest *request = [PF_FBRequest requestForMyFriends];
//        [request setDelegate:(AppDelegate *)[[UIApplication sharedApplication] delegate]];
//        [request startWithCompletionHandler:nil];
    } else {
        NSLog(@"Current user is missing their Facebook ID");
        [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(facebookRequestDidLoad:)]) {
                    [[UIApplication sharedApplication].delegate performSelector:@selector(facebookRequestDidLoad:) withObject:result];
                }
            } else {
                if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(facebookRequestDidFailWithError:)]) {
                    [[UIApplication sharedApplication].delegate performSelector:@selector(facebookRequestDidFailWithError:) withObject:error];
                }
            }
        }];
//*******************************舊版本Parse.framework及FacebookSDK.framework使用的方法*********************************
//        PF_FBRequest *request = [PF_FBRequest requestForGraphPath:@"me?fields=birthday,email,first_name,last_name,location,gender,name,picture"];
//        [request setDelegate:(AppDelegate *)[[UIApplication sharedApplication] delegate]];
//        [request startWithCompletionHandler:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
