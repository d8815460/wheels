//
//  PAPUtility.h
//  Anypic
//
//  Created by Mattieu Gamache-Asselin on 5/18/12.
//  Copyright (c) 2012 Parse. All rights reserved.
//

@interface PAPUtility : NSObject

//發問者刪除
+ (void)DeleteQuestionChannelInBackground:(id)question AndChannel:(id)channel AndAnswerUser:(id)Answeruser block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
//發問者檢舉
+ (void)SpanQuestionChannelInBackground:(id)question AndChannel:(id)channel AndAnswerUser:(id)Answeruser block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
//發問者喜歡、不喜歡回復者頻道
+ (void)likeQuestionChannelInBackground:(id)question AndChannel:(id)channel AndAnswerUser:(id)Answeruser block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (void)unlikeQuestionChannelInBackground:(id)question AndChannel:(id)channel AndAnswerUser:(id)Answeruser block:(void (^)(BOOL succeeded, NSError *error))completionBlock;

+ (void)likePhotoInBackground:(id)photo AndChannel:(id)channel block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (void)unlikePhotoInBackground:(id)photo AndChannel:(id)channel block:(void (^)(BOOL succeeded, NSError *error))completionBlock;

+ (void)processFacebookProfilePictureData:(NSData *)newProfilePictureData;

//用戶有一個有效的Facebook數據
+ (BOOL)userHasValidFacebookData:(PFUser *)user;
//用戶有個人照片
+ (BOOL)userHasProfilePictures:(PFUser *)user;
//截取用戶的名字顯示在DisplayName上
+ (NSString *)firstNameForDisplayName:(NSString *)displayName;

+ (void)followUserInBackground:(PFUser *)user block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (void)followUserEventually:(PFUser *)user block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (void)followUsersEventually:(NSArray *)users block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (void)unfollowUserEventually:(PFUser *)user;
+ (void)unfollowUsersEventually:(NSArray *)users;

+ (void)sendFollowingPushNotification:(PFUser *)user;

+ (void)drawSideDropShadowForRect:(CGRect)rect inContext:(CGContextRef)context;
+ (void)drawSideAndBottomDropShadowForRect:(CGRect)rect inContext:(CGContextRef)context;
+ (void)drawSideAndTopDropShadowForRect:(CGRect)rect inContext:(CGContextRef)context;  
+ (void)addBottomDropShadowToNavigationBarForNavigationController:(UINavigationController *)navigationController;

+ (PFQuery *)queryForActivitiesOnPhoto:(PFObject *)photo cachePolicy:(PFCachePolicy)cachePolicy;
+ (PFQuery *)queryForChannalOnPhoto:(PFObject *)photo cachePolicy:(PFCachePolicy)cachePolicy;
+ (NSNumber *)unReadCountForMyQuestion:(PFUser *)CurrentUser;

//計算當天的Span總數
+ (NSNumber *)spanCount:(PFUser *)AnswerUser;
+ (void)sendSpanPushNotification:(PFUser *)AnswerUser;

@end
