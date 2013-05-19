//
//  PAPCache.h
//  Anypic
//
//  Created by Héctor Ramos on 5/31/12.
//  Copyright (c) 2012 Parse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface PAPCache : NSObject

+ (id)sharedCache;

- (void)clear;
//
- (void)setAttributesForPhoto:(PFObject *)photo likers:(NSArray *)likers commenters:(NSArray *)commenters likedByCurrentUser:(BOOL)likedByCurrentUser;
- (NSDictionary *)attributesForPhoto:(PFObject *)photo;
//新增用來紀錄發問者與回復者之間的頻道PFObject
- (NSDictionary *)attributesForQuestionChannel:(PFObject *)questionChannel;

//新增
//計算愛心總數
- (NSNumber *)likeCountForQuestionChannel:(PFUser *)AnswerUser;
//計算各問題類別的愛心總數。
- (NSNumber *)likeCountByCatetory:(NSString *)category AndAnswerUser:(PFUser *)AnswerUser;


//計算討論串總數
- (NSNumber *)commentCountForQuestionChannel:(PFUser *)AskUser;

- (NSNumber *)likeCountForPhoto:(PFObject *)photo;
- (NSNumber *)commentCountForPhoto:(PFObject *)photo;
- (NSArray *)likersForPhoto:(PFObject *)photo;
- (NSArray *)commentersForPhoto:(PFObject *)photo;

//新增問題被發問者主動給愛心for回復者於該問題與兩人之間的頻道。  //這裡的questionChannel指的是"QChannel"
- (void)setQuestionIsLikedByCurrentAndAskUser:(PFObject *)questionChannel liked:(BOOL)liked;
- (BOOL)isQuestionChannelLikedByCurrentAndAskUser:(PFObject *)questionChannel;
//舊有程式
- (void)setPhotoIsLikedByCurrentUser:(PFObject *)photo liked:(BOOL)liked;
- (BOOL)isPhotoLikedByCurrentUser:(PFObject *)photo;

//新增 增加跟遞減愛心總數量（對某一個特定問題頻道）
- (void)incrementLikerCountForQuestionChannel:(PFObject *)aQuestionChannel;
- (void)decrementLikerCountForQuestionChannel:(PFObject *)aQuestionChannel;

//增加跟遞減愛心總數量（對某一個特定問題）
//舊有
- (void)incrementLikerCountForPhoto:(PFObject *)photo;
- (void)decrementLikerCountForPhoto:(PFObject *)photo;
//增加跟遞減問答總數量(對某一特定的問題)
- (void)incrementCommentCountForPhoto:(PFObject *)photo;
- (void)decrementCommentCountForPhoto:(PFObject *)photo;

- (NSDictionary *)attributesForUser:(PFUser *)user;
- (NSNumber *)photoCountForUser:(PFUser *)user;
- (void)setPhotoCount:(NSNumber *)count user:(PFUser *)user;

- (BOOL)followStatusForUser:(PFUser *)user;
- (void)setFollowStatus:(BOOL)following user:(PFUser *)user;

- (void)setFacebookFriends:(NSArray *)friends;
- (NSArray *)facebookFriends;

- (void)setAttributesforChannelUser:(NSArray *)channelobjects;
- (NSArray *)channelobjects;

@end
