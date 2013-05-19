//
//  PAPUtility.m
//  Anypic
//
//  Created by Mattieu Gamache-Asselin on 5/18/12.
//  Copyright (c) 2012 Parse. All rights reserved.
//

#import "PAPUtility.h"
#import "UIImage+ResizeAdditions.h"

@implementation PAPUtility


#pragma mark - PAPUtility
#pragma mark Like Photos


//發問者刪除
+ (void)DeleteQuestionChannelInBackground:(id)question AndChannel:(id)channel AndAnswerUser:(id)Answeruser block:(void (^)(BOOL succeeded, NSError *error))completionBlock{
    PFObject *Qchannel = channel;
    PFObject *DeleteQuestionChannel = [[PFQuery queryWithClassName:kPAPQueryChannelsKey] getObjectWithId:Qchannel.objectId];
    [DeleteQuestionChannel setObject:[NSNumber numberWithBool:kPAPQueryChannelTypeDelete] forKey:kPAPQueryChannelDeleteKey];   //儲存isDeleted = delete = 1
    
    PFACL *DeleteACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [DeleteACL setPublicReadAccess:YES];
    [DeleteACL setWriteAccess:YES forUser:Answeruser];
    DeleteQuestionChannel.ACL = DeleteACL;
    
    [DeleteQuestionChannel saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (completionBlock) {
            completionBlock(succeeded,error);
        }
        
        if (succeeded) {
            //成功Span
            NSLog(@"成功Delete");
        }
    }];
}
//發問者檢舉
+ (void)SpanQuestionChannelInBackground:(id)question AndChannel:(id)channel AndAnswerUser:(id)Answeruser block:(void (^)(BOOL succeeded, NSError *error))completionBlock{
    PFObject *Qchannel = channel;
    PFObject *SpanQuestionChannel = [[PFQuery queryWithClassName:kPAPQueryChannelsKey] getObjectWithId:Qchannel.objectId];
    [SpanQuestionChannel setObject:[NSNumber numberWithBool:kPAPQueryChannelTypeSpan] forKey:kPAPQueryChannelSpanKey];            //儲存isSpaned = span = 1
    
    PFACL *SpanACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [SpanACL setPublicReadAccess:YES];
    [SpanACL setWriteAccess:YES forUser:Answeruser];
    SpanQuestionChannel.ACL = SpanACL;
    
    [SpanQuestionChannel saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (completionBlock) {
            completionBlock(succeeded,error);
        }
        
        if (succeeded) {
            //成功Span
            NSLog(@"成功Span");
        }
    }];
}
//發問者喜歡、不喜歡回復者頻道
+ (void)likeQuestionChannelInBackground:(id)question AndChannel:(id)channel AndAnswerUser:(id)Answeruser block:(void (^)(BOOL succeeded, NSError *error))completionBlock{
    
    PFObject *Qchannel = channel;
    PFObject *likeQuestionChannel = [[PFQuery queryWithClassName:kPAPQueryChannelsKey] getObjectWithId:Qchannel.objectId];
    [likeQuestionChannel setObject:[NSNumber numberWithBool:kPAPQueryChannelTypeLike] forKey:kPAPQueryChannelLikeKey];            //儲存isliked = like = 1
    
    PFACL *likeACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [likeACL setPublicReadAccess:YES];
    [likeACL setWriteAccess:YES forUser:Answeruser];
    likeQuestionChannel.ACL = likeACL;
    
    NSLog(@"likeQuestionChannel = %@", likeQuestionChannel.objectId);
    
    [likeQuestionChannel saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (completionBlock) {
            completionBlock(succeeded,error);
        }
        
        NSLog(@"succeeded? = %i ,and Error = %@", succeeded, error);
        if (succeeded) {
            NSLog(@"很滿意您的回答。");
            NSString *privateChannelName = [Answeruser objectForKey:kPAPUserPrivateChannelKey];
            if (privateChannelName && privateChannelName.length != 0) {
                NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [NSString stringWithFormat:NSLocalizedStringFromTable(@"notifyLikesAns", @"InfoPlist" , @"推播訊息"), [PAPUtility firstNameForDisplayName:[[PFUser currentUser] objectForKey:kPAPUserDisplayNameKey]]], kAPNSAlertKey,
                                      kPAPPushPayloadPayloadTypeActivityKey, kPAPPushPayloadPayloadTypeKey,
                                      kPAPPushPayloadActivityLikeKey, kPAPPushPayloadActivityTypeKey,
                                      [[PFUser currentUser] objectId], kPAPPushPayloadFromUserObjectIdKey,
                                      [question objectId], kPAPPushPayloadPhotoObjectIdKey,
                                      nil];
                PFPush *push = [[PFPush alloc] init];
                [push setChannel:privateChannelName];
                [push setData:data];
                [push sendPushInBackground];
            }
        }
    }];
}

+ (void)unlikeQuestionChannelInBackground:(id)question AndChannel:(id)channel AndAnswerUser:(id)Answeruser block:(void (^)(BOOL succeeded, NSError *error))completionBlock{
    
    PFObject *Qchannel = channel;
    PFObject *unlikeQuestionChannel = [[PFQuery queryWithClassName:kPAPQueryChannelsKey] getObjectWithId:Qchannel.objectId];
    [unlikeQuestionChannel setObject:[NSNumber numberWithInt:kPAPQueryChannelTypeUnLike] forKey:kPAPQueryChannelLikeKey];     //儲存isliked = unlike = 0
    
    PFACL *likeACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [likeACL setPublicReadAccess:YES];
    [likeACL setWriteAccess:YES forUser:Answeruser];
    unlikeQuestionChannel.ACL = likeACL;
    
    [unlikeQuestionChannel saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        //取消喜歡
        NSLog(@"取消喜歡");
        if (completionBlock) {
            completionBlock(succeeded,error);
        }
        
        if (succeeded) {
            NSLog(@"成功取消喜歡。");
            
        }
    }];
    
    PFQuery *query = [PAPUtility queryForActivitiesOnPhoto:question cachePolicy:kPFCachePolicyNetworkOnly];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            NSMutableArray *likers = [NSMutableArray array];
            NSMutableArray *commenters = [NSMutableArray array];
            
            BOOL isLikedByCurrentUser = NO;
            
            for (PFObject *activity in objects) {
                if ([[activity objectForKey:kPAPActivityTypeKey] isEqualToNumber:[NSNumber numberWithInt:kPAPActivityTypeLike]]) {
                    [likers addObject:[activity objectForKey:kPAPActivityFromUserKey]];
                } else if ([[activity objectForKey:kPAPActivityTypeKey] isEqualToNumber:[NSNumber numberWithInt:kPAPActivityTypeComment]]) {
                    [commenters addObject:[activity objectForKey:kPAPActivityFromUserKey]];
                }
                
                if ([[[activity objectForKey:kPAPActivityFromUserKey] objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
                    if ([[activity objectForKey:kPAPActivityTypeKey] isEqualToNumber:[NSNumber numberWithInt:kPAPActivityTypeLike]]) {
                        isLikedByCurrentUser = YES;
                    }
                }
            }
            
            [[PAPCache sharedCache] setAttributesForPhoto:question likers:likers commenters:commenters likedByCurrentUser:isLikedByCurrentUser];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:PAPUtilityUserLikedUnlikedPhotoCallbackFinishedNotification object:question userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:PAPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotificationUserInfoLikedKey]];
    }];
}


+ (void)likePhotoInBackground:(id)photo AndChannel:(id)channel block:(void (^)(BOOL succeeded, NSError *error))completionBlock {
    
        // proceed to creating new like
        PFObject *likeActivity = [PFObject objectWithClassName:kPAPActivityClassKey];                               //儲存到Activity
        [likeActivity setObject:[NSNumber numberWithInt:kPAPActivityTypeLike] forKey:kPAPActivityTypeKey];          //儲存type為like
        [likeActivity setObject:[photo objectForKey:kPAPPhotoUserKey] forKey:kPAPActivityFromUserKey];  //（發問用戶）給愛心   fromUser=當前用戶
        [likeActivity setObject:[channel objectForKey:@"fromUser"] forKey:kPAPActivityToUserKey];       //（回復用戶）接受愛心 toUser
        [likeActivity setObject:photo forKey:kPAPActivityPhotoKey];                                     //儲存photo為該問題
        [likeActivity setObject:[channel objectForKey:@"channel"] forKey:@"channel"];                   //儲存channel為頻道
        
        NSLog(@"likeActivity = %@" , likeActivity);
        
        PFACL *likeACL = [PFACL ACLWithUser:[PFUser currentUser]];
        [likeACL setPublicReadAccess:YES];
        [likeACL setWriteAccess:YES forUser:[photo objectForKey:kPAPPhotoUserKey]];
        likeActivity.ACL = likeACL;

        [likeActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (completionBlock) {
                completionBlock(succeeded,error);
            }

//            if (succeeded && ![[[photo objectForKey:kPAPPhotoUserKey] objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
            if (succeeded) {
                
                PFUser *fromUserData = [channel objectForKey:@"fromUser"];
                PFQuery *userDataQuery = [PFUser query];
                [userDataQuery whereKey:@"objectId" equalTo:fromUserData.objectId];
                PFObject *userPFObject = [userDataQuery getFirstObject];
                
                NSString *privateChannelName = [userPFObject objectForKey:kPAPUserPrivateChannelKey];
                if (privateChannelName && privateChannelName.length != 0) {
                    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [NSString stringWithFormat:NSLocalizedStringFromTable(@"notifyLikesAns", @"InfoPlist" , @"推播訊息"), [PAPUtility firstNameForDisplayName:[[PFUser currentUser] objectForKey:kPAPUserDisplayNameKey]]], kAPNSAlertKey,
                                          kPAPPushPayloadPayloadTypeActivityKey, kPAPPushPayloadPayloadTypeKey,
                                          kPAPPushPayloadActivityLikeKey, kPAPPushPayloadActivityTypeKey,
                                          [[PFUser currentUser] objectId], kPAPPushPayloadFromUserObjectIdKey,
                                          [photo objectId], kPAPPushPayloadPhotoObjectIdKey,
                                          nil];
                    PFPush *push = [[PFPush alloc] init];
                    [push setChannel:privateChannelName];
                    [push setData:data];
                    [push sendPushInBackground];
                }
            }
           
            // refresh cache
            PFQuery *query = [PAPUtility queryForActivitiesOnPhoto:photo cachePolicy:kPFCachePolicyNetworkOnly];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    
                    NSMutableArray *likers = [NSMutableArray array];
                    NSMutableArray *commenters = [NSMutableArray array];
                    
                    BOOL isLikedByCurrentUser = NO;
                    
                    for (PFObject *activity in objects) {
                        if ([[activity objectForKey:kPAPActivityTypeKey] isEqualToNumber:[NSNumber numberWithInt:kPAPActivityTypeLike]] && [activity objectForKey:kPAPActivityFromUserKey]) {
                            [likers addObject:[activity objectForKey:kPAPActivityFromUserKey]];
                        } else if ([[activity objectForKey:kPAPActivityTypeKey] isEqualToNumber:[NSNumber numberWithInt:kPAPActivityTypeComment]] && [activity objectForKey:kPAPActivityFromUserKey]) {
                            [commenters addObject:[activity objectForKey:kPAPActivityFromUserKey]];
                        }
                        
                        if ([[[activity objectForKey:kPAPActivityFromUserKey] objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
                            if ([[activity objectForKey:kPAPActivityTypeKey] isEqualToNumber:[NSNumber numberWithInt:kPAPActivityTypeLike]]) {
                                isLikedByCurrentUser = YES;
                            }
                        }
                    }
                    
                    [[PAPCache sharedCache] setAttributesForPhoto:photo likers:likers commenters:commenters likedByCurrentUser:isLikedByCurrentUser];
                }

                [[NSNotificationCenter defaultCenter] postNotificationName:PAPUtilityUserLikedUnlikedPhotoCallbackFinishedNotification object:photo userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:succeeded] forKey:PAPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotificationUserInfoLikedKey]];
            }];

        }];
//    }];

    /*
    // like photo in Facebook if possible
    NSString *fbOpenGraphID = [photo objectForKey:kPAPPhotoOpenGraphIDKey];
    if (fbOpenGraphID && fbOpenGraphID.length > 0) {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
        NSString *objectURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@", fbOpenGraphID];
        [params setObject:objectURL forKey:@"object"];
        [[PFFacebookUtils facebook] requestWithGraphPath:@"me/og.likes" andParams:params andHttpMethod:@"POST" andDelegate:nil];
    }
    */
}

+ (void)unlikePhotoInBackground:(id)photo AndChannel:(id)channel block:(void (^)(BOOL succeeded, NSError *error))completionBlock {
//    PFQuery *queryExistingLikes = [PFQuery queryWithClassName:kPAPActivityClassKey];                    //搜尋Activity，整合已經存在的like總數
//    [queryExistingLikes whereKey:kPAPActivityPhotoKey equalTo:photo];                                   //搜尋photo，符合該問題
//    [queryExistingLikes whereKey:@"channel" equalTo:channel];                                           //搜尋channel符合該頻道
//    [queryExistingLikes whereKey:kPAPActivityTypeKey equalTo:kPAPActivityTypeLike];                     //搜尋type符合like
//    [queryExistingLikes whereKey:kPAPActivityFromUserKey equalTo:[PFUser currentUser]];                 //搜尋fromeUser符合當前用戶
//    [queryExistingLikes setCachePolicy:kPFCachePolicyNetworkOnly];
//    [queryExistingLikes findObjectsInBackgroundWithBlock:^(NSArray *activities, NSError *error) {
//        if (!error) {
//            for (PFObject *activity in activities) {
//                [activity delete];
//            }
//            
//            if (completionBlock) {
//                completionBlock(YES,nil);
//            }

            // refresh cache
            PFQuery *query = [PAPUtility queryForActivitiesOnPhoto:photo cachePolicy:kPFCachePolicyNetworkOnly];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    
                    NSMutableArray *likers = [NSMutableArray array];
                    NSMutableArray *commenters = [NSMutableArray array];
                    
                    BOOL isLikedByCurrentUser = NO;
                    
                    for (PFObject *activity in objects) {
                        if ([[activity objectForKey:kPAPActivityTypeKey] isEqualToNumber:[NSNumber numberWithInt:kPAPActivityTypeLike]]) {
                            [likers addObject:[activity objectForKey:kPAPActivityFromUserKey]];
                        } else if ([[activity objectForKey:kPAPActivityTypeKey] isEqualToNumber:[NSNumber numberWithInt:kPAPActivityTypeComment]]) {
                            [commenters addObject:[activity objectForKey:kPAPActivityFromUserKey]];
                        }
                        
                        if ([[[activity objectForKey:kPAPActivityFromUserKey] objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
                            if ([[activity objectForKey:kPAPActivityTypeKey] isEqualToNumber:[NSNumber numberWithInt:kPAPActivityTypeLike]]) {
                                isLikedByCurrentUser = YES;
                            }
                        }
                    }
                    
                    [[PAPCache sharedCache] setAttributesForPhoto:photo likers:likers commenters:commenters likedByCurrentUser:isLikedByCurrentUser];
                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:PAPUtilityUserLikedUnlikedPhotoCallbackFinishedNotification object:photo userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:PAPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotificationUserInfoLikedKey]];
            }];

//        } else {
//            if (completionBlock) {
//                completionBlock(NO,error);
//            }
//        }
//    }];
}


#pragma mark Facebook

+ (void)processFacebookProfilePictureData:(NSData *)newProfilePictureData {
    if (newProfilePictureData.length == 0) {
        NSLog(@"個人照片無法成功下載。");
        return;
    }
    
    // The user's Facebook profile picture is cached to disk. Check if the cached profile picture data matches the incoming profile picture. If it does, avoid uploading this data to Parse.

    NSURL *cachesDirectoryURL = [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject]; // iOS Caches directory

    NSURL *profilePictureCacheURL = [cachesDirectoryURL URLByAppendingPathComponent:@"FacebookProfilePicture.jpg"];
    
    //如果檔案照片一致就不需要再重新上傳。
//    if ([[NSFileManager defaultManager] fileExistsAtPath:[profilePictureCacheURL path]]) {
//        // We have a cached Facebook profile picture
//        
//        NSData *oldProfilePictureData = [NSData dataWithContentsOfFile:[profilePictureCacheURL path]];
//
//        if ([oldProfilePictureData isEqualToData:newProfilePictureData]) {
//            NSLog(@"緩存的個人檔案照片與資料庫上一致，系統將不會更新照片檔案。");
//            return;
//        }
//    }

    BOOL cachedToDisk = [[NSFileManager defaultManager] createFileAtPath:[profilePictureCacheURL path] contents:newProfilePictureData attributes:nil];
    NSLog(@"磁碟高速緩存個人檔案照片: %d", cachedToDisk);

    UIImage *image = [UIImage imageWithData:newProfilePictureData];
    UIImage *mediumImage = [image thumbnailImage:280 transparentBorder:0 cornerRadius:140 interpolationQuality:kCGInterpolationHigh];
    UIImage *smallRoundedImage = [image thumbnailImage:64 transparentBorder:0 cornerRadius:32 interpolationQuality:kCGInterpolationLow];
    
    NSData *mediumImageData = UIImagePNGRepresentation(mediumImage); // using JPEG for larger pictures
    NSData *smallRoundedImageData = UIImagePNGRepresentation(smallRoundedImage);
    
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // 创建profile目录 //在Documents里创建目录
    NSString *profileDirectory = [documentsDirectory stringByAppendingPathComponent:@"profile"];
    [fileManager createDirectoryAtPath:profileDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    //更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[profileDirectory stringByExpandingTildeInPath]];
    //在profile目录下创建文件
    NSString *profileMediumPath = [profileDirectory stringByAppendingPathComponent:@"medium.png"];
    NSString *profileSmallPath = [profileDirectory stringByAppendingPathComponent:@"small.png"];
    //寫入檔案
    [fileManager createFileAtPath:profileMediumPath contents:mediumImageData attributes:nil];
    [fileManager createFileAtPath:profileSmallPath contents:smallRoundedImageData attributes:nil];
    
    //讀取檔案
//    NSData *reader = [NSData dataWithContentsOfFile:path];  
    /*
     其他地方可以用這個方法去取回當前用戶的大頭照。
     NSData *mediumimageData = [NSData dataWithContentsOfFile:mediumpath];
     NSData *smallimageData = [NSData dataWithContentsOfFile:smallpath];
     */
    
    if (mediumImageData.length > 0) {
        NSLog(@"中型個人檔案照片上載中...");
        PFFile *fileMediumImage = [PFFile fileWithData:mediumImageData];
        
        [fileMediumImage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                NSLog(@"中型個人檔案照片上載完成。");
                PFUser *currentMyFile = [PFUser currentUser];
                [currentMyFile setObject:fileMediumImage forKey:kPAPUserProfilePicMediumKey];
                [currentMyFile saveEventually:^(BOOL succeeded, NSError *error) {
                    if (!error) {
                        NSLog(@"中型個人檔案照片應該要確實上傳到資料庫。");
                    }else {
                        NSLog(@"中型個人檔案照片出錯囉！");
                    }
                    
                }];
            }
        }];
    }
    
    if (smallRoundedImageData.length > 0) {
        NSLog(@"小型個人檔案照片上載中...");
        PFFile *fileSmallRoundedImage = [PFFile fileWithData:smallRoundedImageData];
        [fileSmallRoundedImage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                NSLog(@"小型個人檔案照片上載完成。");
                PFUser *currentMyFile = [PFUser currentUser];
                [currentMyFile setObject:fileSmallRoundedImage forKey:kPAPUserProfilePicSmallKey];    
                [currentMyFile saveEventually:^(BOOL succeeded, NSError *error) {
                    if (!error) {
                        NSLog(@"小型個人檔案照片應該要確實上傳到資料庫。");
                    }else{
                        NSLog(@"小型個人檔案照片出錯囉！");
                    }
                }];
            }
        }];
    }
}

+ (BOOL)userHasValidFacebookData:(PFUser *)user {
    NSString *facebookId = [user objectForKey:kPAPUserFacebookIDKey];
    return (facebookId && facebookId.length > 0);
}

+ (BOOL)userHasProfilePictures:(PFUser *)user {
    PFFile *profilePictureMedium = [user objectForKey:kPAPUserProfilePicMediumKey];
    PFFile *profilePictureSmall = [user objectForKey:kPAPUserProfilePicSmallKey];
    
    return (profilePictureMedium && profilePictureSmall);
}


#pragma mark Display Name

+ (NSString *)firstNameForDisplayName:(NSString *)displayName {
    if (!displayName || displayName.length == 0) {
        return @"Someone";
    }
    
    NSArray *displayNameComponents = [displayName componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *firstName = [displayNameComponents objectAtIndex:0];
    if (firstName.length > 100) {
        // truncate to 100 so that it fits in a Push payload
        firstName = [firstName substringToIndex:100];
    }
    return firstName;
}


#pragma mark User Following

+ (void)followUserInBackground:(PFUser *)user block:(void (^)(BOOL succeeded, NSError *error))completionBlock {
    if ([[user objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
        return;
    }
    
    PFObject *followActivity = [PFObject objectWithClassName:kPAPActivityClassKey];
    [followActivity setObject:[PFUser currentUser] forKey:kPAPActivityFromUserKey];
    [followActivity setObject:user forKey:kPAPActivityToUserKey];
    [followActivity setObject:[NSNumber numberWithInt:kPAPActivityTypeFollow] forKey:kPAPActivityTypeKey];
    
    PFACL *followACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [followACL setPublicReadAccess:YES];
    followActivity.ACL = followACL;
    
    [followActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (completionBlock) {
            completionBlock(succeeded, error);
        }
        
        if (succeeded) {
//            [PAPUtility sendFollowingPushNotification:user];  移除好友安裝wheels的推播。
        }
    }];
    [[PAPCache sharedCache] setFollowStatus:YES user:user];
}

+ (void)followUserEventually:(PFUser *)user block:(void (^)(BOOL succeeded, NSError *error))completionBlock {
    if ([[user objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
        return;
    }
    
    PFObject *followActivity = [PFObject objectWithClassName:kPAPActivityClassKey];
    [followActivity setObject:[PFUser currentUser] forKey:kPAPActivityFromUserKey];
    [followActivity setObject:user forKey:kPAPActivityToUserKey];
    [followActivity setObject:[NSNumber numberWithInt:kPAPActivityTypeFollow] forKey:kPAPActivityTypeKey];
    
    PFACL *followACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [followACL setPublicReadAccess:YES];
    followActivity.ACL = followACL;
    
    [followActivity saveEventually:completionBlock];
    [[PAPCache sharedCache] setFollowStatus:YES user:user];
}

+ (void)followUsersEventually:(NSArray *)users block:(void (^)(BOOL succeeded, NSError *error))completionBlock {
    for (PFUser *user in users) {
        [PAPUtility followUserEventually:user block:completionBlock];
        [[PAPCache sharedCache] setFollowStatus:YES user:user];
    }
}

+ (void)unfollowUserEventually:(PFUser *)user {
    PFQuery *query = [PFQuery queryWithClassName:kPAPActivityClassKey];
    [query whereKey:kPAPActivityFromUserKey equalTo:[PFUser currentUser]];
    [query whereKey:kPAPActivityToUserKey equalTo:user];
    [query whereKey:kPAPActivityTypeKey equalTo:[NSNumber numberWithInt:kPAPActivityTypeFollow]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *followActivities, NSError *error) {
        // While normally there should only be one follow activity returned, we can't guarantee that.
        
        if (!error) {
            for (PFObject *followActivity in followActivities) {
                [followActivity deleteEventually];
            }
        }
    }];
    [[PAPCache sharedCache] setFollowStatus:NO user:user];
}

+ (void)unfollowUsersEventually:(NSArray *)users {
    PFQuery *query = [PFQuery queryWithClassName:kPAPActivityClassKey];
    [query whereKey:kPAPActivityFromUserKey equalTo:[PFUser currentUser]];
    [query whereKey:kPAPActivityToUserKey containedIn:users];
    [query whereKey:kPAPActivityTypeKey equalTo:[NSNumber numberWithInt:kPAPActivityTypeFollow]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *activities, NSError *error) {
        for (PFObject *activity in activities) {
            [activity deleteEventually];
        }
    }];
    for (PFUser *user in users) {
        [[PAPCache sharedCache] setFollowStatus:NO user:user];
    }
}


#pragma mark Push
+ (void)sendFollowingPushNotification:(PFUser *)user {
    NSString *privateChannelName = [user objectForKey:kPAPUserPrivateChannelKey];
    if (privateChannelName && privateChannelName.length != 0) {
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSString stringWithFormat:NSLocalizedStringFromTable( @"notifyFriendInstall", @"InfoPlist" , @"推播訊息" ), [PAPUtility firstNameForDisplayName:[[PFUser currentUser] objectForKey:kPAPUserDisplayNameKey]]], kAPNSAlertKey,
                              kPAPPushPayloadPayloadTypeActivityKey, kPAPPushPayloadPayloadTypeKey,
                              kPAPPushPayloadActivityFollowKey, kPAPPushPayloadActivityTypeKey,
                              [[PFUser currentUser] objectId], kPAPPushPayloadFromUserObjectIdKey,
                              nil];
        PFPush *push = [[PFPush alloc] init];
        [push setChannel:privateChannelName];
        [push setData:data];
        [push sendPushInBackground];
    }
}

#pragma mark Activities

+ (PFQuery *)queryForActivitiesOnPhoto:(PFObject *)photo cachePolicy:(PFCachePolicy)cachePolicy {
    PFQuery *queryLikes = [PFQuery queryWithClassName:kPAPActivityClassKey];
    [queryLikes whereKey:kPAPActivityPhotoKey equalTo:photo];
    [queryLikes whereKey:kPAPActivityTypeKey equalTo:[NSNumber numberWithInt:kPAPActivityTypeLike]];
    
    PFQuery *queryComments = [PFQuery queryWithClassName:kPAPActivityClassKey];
    [queryComments whereKey:kPAPActivityPhotoKey equalTo:photo];
    [queryComments whereKey:kPAPActivityTypeKey equalTo:[NSNumber numberWithInt:kPAPActivityTypeComment]];
    
    PFQuery *query = [PFQuery orQueryWithSubqueries:[NSArray arrayWithObjects:queryLikes,queryComments,nil]];
    [query setCachePolicy:cachePolicy];
    [query includeKey:kPAPActivityFromUserKey];
    [query includeKey:kPAPActivityPhotoKey];

    return query;
}

+ (PFQuery *)queryForChannalOnPhoto:(PFObject *)photo cachePolicy:(PFCachePolicy)cachePolicy{
    return nil;
}

#pragma mark Shadow Rendering

+ (void)drawSideAndBottomDropShadowForRect:(CGRect)rect inContext:(CGContextRef)context {
    // Push the context 
    CGContextSaveGState(context);
    
    // Set the clipping path to remove the rect drawn by drawing the shadow
    CGRect boundingRect = CGContextGetClipBoundingBox(context);
    CGContextAddRect(context, boundingRect);
    CGContextAddRect(context, rect);
    CGContextEOClip(context);
    // Also clip the top and bottom
    CGContextClipToRect(context, CGRectMake(rect.origin.x - 10.0f, rect.origin.y, rect.size.width + 20.0f, rect.size.height + 10.0f));
    
    // Draw shadow
    [[UIColor blackColor] setFill];
    CGContextSetShadow(context, CGSizeMake(0.0f, 0.0f), 7.0f);
    CGContextFillRect(context, CGRectMake(rect.origin.x, 
                                          rect.origin.y - 5.0f, 
                                          rect.size.width, 
                                          rect.size.height + 5.0f));
    // Save context
    CGContextRestoreGState(context);
}

+ (void)drawSideAndTopDropShadowForRect:(CGRect)rect inContext:(CGContextRef)context {    
    // Push the context 
    CGContextSaveGState(context);
    
    // Set the clipping path to remove the rect drawn by drawing the shadow
    CGRect boundingRect = CGContextGetClipBoundingBox(context);
    CGContextAddRect(context, boundingRect);
    CGContextAddRect(context, rect);
    CGContextEOClip(context);
    // Also clip the top and bottom
    CGContextClipToRect(context, CGRectMake(rect.origin.x - 10.0f, rect.origin.y - 10.0f, rect.size.width + 20.0f, rect.size.height + 10.0f));
    
    // Draw shadow
    [[UIColor blackColor] setFill];
    CGContextSetShadow(context, CGSizeMake(0.0f, 0.0f), 7.0f);
    CGContextFillRect(context, CGRectMake(rect.origin.x, 
                                          rect.origin.y, 
                                          rect.size.width, 
                                          rect.size.height + 10.0f));
    // Save context
    CGContextRestoreGState(context);
}

+ (void)drawSideDropShadowForRect:(CGRect)rect inContext:(CGContextRef)context {    
    // Push the context 
    CGContextSaveGState(context);
    
    // Set the clipping path to remove the rect drawn by drawing the shadow
    CGRect boundingRect = CGContextGetClipBoundingBox(context);
    CGContextAddRect(context, boundingRect);
    CGContextAddRect(context, rect);
    CGContextEOClip(context);
    // Also clip the top and bottom
    CGContextClipToRect(context, CGRectMake(rect.origin.x - 10.0f, rect.origin.y, rect.size.width + 20.0f, rect.size.height));
    
    // Draw shadow
    [[UIColor blackColor] setFill];
    CGContextSetShadow(context, CGSizeMake(0.0f, 0.0f), 7.0f);
    CGContextFillRect(context, CGRectMake(rect.origin.x, 
                                          rect.origin.y - 5.0f, 
                                          rect.size.width, 
                                          rect.size.height + 10.0f));
    // Save context
    CGContextRestoreGState(context);
}

+ (void)addBottomDropShadowToNavigationBarForNavigationController:(UINavigationController *)navigationController {
    UIView *gradientView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, navigationController.navigationBar.frame.size.height, navigationController.navigationBar.frame.size.width, 3.0f)];
    [gradientView setBackgroundColor:[UIColor clearColor]];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = gradientView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor], (id)[[UIColor clearColor] CGColor], nil];
    [gradientView.layer insertSublayer:gradient atIndex:0];
    navigationController.navigationBar.clipsToBounds = NO;
    [navigationController.navigationBar addSubview:gradientView];	    
}

+ (NSNumber *)unReadCountForMyQuestion:(PFUser *)CurrentUser{
    int unreadCount = [[CurrentUser objectForKey:@"myQunreadNum"] intValue];
    NSNumber *num = [NSNumber numberWithInt:unreadCount];
    return num;
//    if ([[CurrentUser objectForKey:@"myQunreadNum"] intValue]) {
//        
//        NSNumber *num = [NSNumber numberWithInt:unreadCount];
//        return num;
//    }else{
//        return nil;
//    }
}

+ (NSNumber *)spanCount:(PFUser *)AnswerUser{
    PFQuery *spanQuery = [PFQuery queryWithClassName:kPAPQueryChannelsKey];
    [spanQuery whereKey:kPAPQueryChannelAnswerUserKey equalTo:AnswerUser];
    [spanQuery whereKey:kPAPQueryChannelSpanKey equalTo:[NSNumber numberWithBool:kPAPQueryChannelTypeSpan]];
    //今天日期
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:[[NSDate alloc] init]];
    [components setHour:-[components hour]];
    [components setMinute:-[components minute]];
    [components setSecond:-[components second]];
    NSDate *today = [cal dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0]; //This variable should now be pointing at a date object that is the start of today (midnight);
    //    NSDate *oneDayBeforeNow = [NSDate dateWithTimeIntervalSinceReferenceDate:([NSDate timeIntervalSinceReferenceDate] - 24*60*60 * 1)];
    [spanQuery whereKey:@"createdAt" greaterThanOrEqualTo:today];
    [spanQuery orderByAscending:@"createdAt"];                                  //按照時間排序。
    NSNumber *mySpanNum = [NSNumber numberWithInteger:spanQuery.countObjects];
    return mySpanNum;
}

+ (void)sendSpanPushNotification:(PFUser *)AnswerUser{
    NSString *privateChannelName = [AnswerUser objectForKey:kPAPUserPrivateChannelKey];
    if (privateChannelName && privateChannelName.length != 0) {
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSString stringWithFormat:NSLocalizedStringFromTable( @"notifySpanPush", @"InfoPlist" , @"推播訊息" )], kAPNSAlertKey,
                              kPAPPushPayloadPayloadTypeActivityKey, kPAPPushPayloadPayloadTypeKey,
                              kPAPPushPayloadActivitySpanKey, kPAPPushPayloadActivityTypeKey,
                              [[PFUser currentUser] objectId], kPAPPushPayloadFromUserObjectIdKey,
                              nil];
        PFPush *push = [[PFPush alloc] init];
        [push setChannel:privateChannelName];
        [push setData:data];
        [push sendPushInBackground];
    }
}

@end
