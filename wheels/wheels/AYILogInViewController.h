//
//  AYILogInViewController.h
//  Wheels
//
//  Created by 陳 駿逸 on 13/2/10.
//  Copyright (c) 2013年 陳 駿逸. All rights reserved.
//

#import <Parse/Parse.h>

@interface AYILogInViewController : PFLogInViewController <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end
