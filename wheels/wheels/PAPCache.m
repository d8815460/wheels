//
//  PAPCache.m
//  Anypic
//
//  Created by Héctor Ramos on 5/31/12.
//  Copyright (c) 2012 Parse. All rights reserved.
//

#import "PAPCache.h"

@interface PAPCache()

@property (nonatomic, strong) NSCache *cache;
- (void)setAttributes:(NSDictionary *)attributes forPhoto:(PFObject *)photo;
@end

@implementation PAPCache
@synthesize cache;

#pragma mark - Initialization

+ (id)sharedCache {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init {
    self = [super init];
    if (self) {
        self.cache = [[NSCache alloc] init];
    }
    return self;
}

#pragma mark - PAPCache

- (void)clear {
    [self.cache removeAllObjects];
}

//原本是紀錄在Activity的 type = like，針對問題給愛心
//現在要改成針對某個特定問題之外，還要外加某個頻道，愛心數最好是記錄QChannel上，
//頻道是AnswerUser＝回復者 ＋ AskUser＝發問者。
//愛心是AskUser＝發問者 給 AnswerUser＝回復者。 記錄在type
- (void)setAttributesForPhoto:(PFObject *)photo likers:(NSArray *)likers commenters:(NSArray *)commenters likedByCurrentUser:(BOOL)likedByCurrentUser {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [NSNumber numberWithBool:likedByCurrentUser],kPAPPhotoAttributesIsLikedByCurrentAndAskUserKey,
                                      [NSNumber numberWithInt:[likers count]],kPAPPhotoAttributesLikeCountKey,
                                      likers,kPAPPhotoAttributesLikersKey,
                                      [NSNumber numberWithInt:[commenters count]],kPAPPhotoAttributesCommentCountKey,
                                      commenters,kPAPPhotoAttributesCommentersKey,
                                      nil];
    [self setAttributes:attributes forPhoto:photo];
}

- (NSDictionary *)attributesForPhoto:(PFObject *)photo {
    NSString *key = [self keyForPhoto:photo];
    return [self.cache objectForKey:key];
}

//新增用來紀錄發問者與回復者之間的頻道PFObject
- (NSDictionary *)attributesForQuestionChannel:(PFObject *)questionChannel {
    NSString *key = [self keyForQuestionChannel:questionChannel];
    return [self.cache objectForKey:key];
}


//新增
//計算愛心總數
- (NSNumber *)likeCountForQuestionChannel:(PFUser *)AnswerUser{
    PFQuery *likeQuery = [PFQuery queryWithClassName:kPAPQueryChannelsKey];
    [likeQuery whereKey:kPAPQueryChannelAnswerUserKey equalTo:AnswerUser];
    [likeQuery whereKey:kPAPQueryChannelLikeKey equalTo:[NSNumber numberWithBool:kPAPQueryChannelTypeLike]];
    
    NSNumber *myHeartNum = [NSNumber numberWithInteger:likeQuery.countObjects];
    
    return myHeartNum;
}

//計算各問題類別的愛心總數。
- (NSNumber *)likeCountByCatetory:(NSString *)category AndAnswerUser:(PFUser *)AnswerUser{
    PFQuery *likeQuery = [PFQuery queryWithClassName:kPAPQueryChannelsKey];
    [likeQuery whereKey:kPAPQueryChannelAnswerUserKey equalTo:AnswerUser];
    [likeQuery whereKey:kPAPQueryChannelLikeKey equalTo:[NSNumber numberWithBool:kPAPQueryChannelTypeLike]];
    [likeQuery whereKey:kPAWParseCategoryKey equalTo:category];
    
    NSNumber *myCategoryHeartNum = [NSNumber numberWithInteger:likeQuery.countObjects];
    return myCategoryHeartNum;
}

- (NSNumber *)commentCountForQuestionChannel:(PFUser *)AskUser{
//    NSDictionary *attributes = [self attributesForQuestionChannel:questionChannel];
//    if (attributes) {
//        return [attributes objectForKey:kPAPPhotoAttributesCommentCountKey];
//    }
    return [NSNumber numberWithInt:0];
}

- (NSNumber *)likeCountForPhoto:(PFObject *)photo {
    NSDictionary *attributes = [self attributesForPhoto:photo];
    if (attributes) {
        return [attributes objectForKey:kPAPPhotoAttributesLikeCountKey];
    }

    return [NSNumber numberWithInt:0];
}

- (NSNumber *)commentCountForPhoto:(PFObject *)photo {
    NSDictionary *attributes = [self attributesForPhoto:photo];
    if (attributes) {
        return [attributes objectForKey:kPAPPhotoAttributesCommentCountKey];
    }
    
    return [NSNumber numberWithInt:0];
}

- (NSArray *)likersForPhoto:(PFObject *)photo {
    NSDictionary *attributes = [self attributesForPhoto:photo];
    if (attributes) {
        return [attributes objectForKey:kPAPPhotoAttributesLikersKey];
    }
    
    return [NSArray array];
}

- (NSArray *)commentersForPhoto:(PFObject *)photo {
    NSDictionary *attributes = [self attributesForPhoto:photo];
    if (attributes) {
        return [attributes objectForKey:kPAPPhotoAttributesCommentersKey];
    }
    
    return [NSArray array];
}

//問題被發問者主動給愛心for回復者於該問題與兩人之間的頻道。
- (void)setQuestionIsLikedByCurrentAndAskUser:(PFObject *)questionChannel liked:(BOOL)liked {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForPhoto:questionChannel]];
    [attributes setObject:[NSNumber numberWithBool:liked] forKey:kPAPPhotoAttributesIsLikedByCurrentAndAskUserKey];
    [self setAttributes:attributes forQuestionChannel:questionChannel];
}

- (BOOL)isQuestionChannelLikedByCurrentAndAskUser:(PFObject *)questionChannel {
    NSDictionary *attributes = [self attributesForQuestionChannel:questionChannel];
    if (attributes) {
        return [[attributes objectForKey:kPAPPhotoAttributesIsLikedByCurrentAndAskUserKey] boolValue];
    }
    return NO;
}

//原本舊程式
- (void)setPhotoIsLikedByCurrentUser:(PFObject *)photo liked:(BOOL)liked {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForPhoto:photo]];
    [attributes setObject:[NSNumber numberWithBool:liked] forKey:kPAPPhotoAttributesIsLikedByCurrentUserKey];
    [self setAttributes:attributes forPhoto:photo];
}

- (BOOL)isPhotoLikedByCurrentUser:(PFObject *)photo {
    NSDictionary *attributes = [self attributesForPhoto:photo];
    if (attributes) {
        return [[attributes objectForKey:kPAPPhotoAttributesIsLikedByCurrentUserKey] boolValue];
    }
    
    return NO;
}

//新增 增加跟遞減愛心總數量（對某一個特定問題頻道）
- (void)incrementLikerCountForQuestionChannel:(PFUser *)aQuestionChannel{
    NSNumber *likerCount = [NSNumber numberWithInt:[[self likeCountForQuestionChannel:aQuestionChannel] intValue] + 1];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForQuestionChannel:aQuestionChannel]];
    [attributes setObject:likerCount forKey:kPAPPhotoAttributesLikeCountKey];
    [self setAttributes:attributes forQuestionChannel:aQuestionChannel];
}

- (void)decrementLikerCountForQuestionChannel:(PFUser *)questionChannel{
    NSNumber *likerCount = [NSNumber numberWithInt:[[self likeCountForQuestionChannel:questionChannel] intValue] - 1];
    if ([likerCount intValue] < 0) {
        return;
    }
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForQuestionChannel:questionChannel]];
    [attributes setObject:likerCount forKey:kPAPPhotoAttributesLikeCountKey];
    [self setAttributes:attributes forQuestionChannel:questionChannel];
}

- (void)incrementLikerCountForPhoto:(PFObject *)photo {
    NSNumber *likerCount = [NSNumber numberWithInt:[[self likeCountForPhoto:photo] intValue] + 1];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForPhoto:photo]];
    [attributes setObject:likerCount forKey:kPAPPhotoAttributesLikeCountKey];
    [self setAttributes:attributes forPhoto:photo];
}

- (void)decrementLikerCountForPhoto:(PFObject *)photo {
    NSNumber *likerCount = [NSNumber numberWithInt:[[self likeCountForPhoto:photo] intValue] - 1];
    if ([likerCount intValue] < 0) {
        return;
    }
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForPhoto:photo]];
    [attributes setObject:likerCount forKey:kPAPPhotoAttributesLikeCountKey];
    [self setAttributes:attributes forPhoto:photo];
}

- (void)incrementCommentCountForPhoto:(PFObject *)photo {
    NSNumber *commentCount = [NSNumber numberWithInt:[[self commentCountForPhoto:photo] intValue] + 1];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForPhoto:photo]];
    [attributes setObject:commentCount forKey:kPAPPhotoAttributesCommentCountKey];
    [self setAttributes:attributes forPhoto:photo];
}

- (void)decrementCommentCountForPhoto:(PFObject *)photo {
    NSNumber *commentCount = [NSNumber numberWithInt:[[self commentCountForPhoto:photo] intValue] - 1];
    if ([commentCount intValue] < 0) {
        return;
    }
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForPhoto:photo]];
    [attributes setObject:commentCount forKey:kPAPPhotoAttributesCommentCountKey];
    [self setAttributes:attributes forPhoto:photo];
}

- (void)setAttributesForUser:(PFUser *)user photoCount:(NSNumber *)count followedByCurrentUser:(BOOL)following {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                count,kPAPUserAttributesPhotoCountKey,
                                [NSNumber numberWithBool:following],kPAPUserAttributesIsFollowedByCurrentUserKey,
                                nil];
    [self setAttributes:attributes forUser:user];
}

- (NSDictionary *)attributesForUser:(PFUser *)user {
    NSString *key = [self keyForUser:user];
    return [self.cache objectForKey:key];
}

- (NSNumber *)photoCountForUser:(PFUser *)user {
    NSDictionary *attributes = [self attributesForUser:user];
    if (attributes) {
        NSNumber *photoCount = [attributes objectForKey:kPAPUserAttributesPhotoCountKey];
        if (photoCount) {
            return photoCount;
        }
    }
    
    return [NSNumber numberWithInt:0];
}

- (BOOL)followStatusForUser:(PFUser *)user {
    NSDictionary *attributes = [self attributesForUser:user];
    if (attributes) {
        NSNumber *followStatus = [attributes objectForKey:kPAPUserAttributesIsFollowedByCurrentUserKey];
        if (followStatus) {
            return [followStatus boolValue];
        }
    }

    return NO;
}

- (void)setPhotoCount:(NSNumber *)count user:(PFUser *)user {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForUser:user]];
    [attributes setObject:count forKey:kPAPUserAttributesPhotoCountKey];
    [self setAttributes:attributes forUser:user];
}

- (void)setFollowStatus:(BOOL)following user:(PFUser *)user {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForUser:user]];
    [attributes setObject:[NSNumber numberWithBool:following] forKey:kPAPUserAttributesIsFollowedByCurrentUserKey];
    [self setAttributes:attributes forUser:user];
}

- (void)setFacebookFriends:(NSArray *)friends {
    NSString *key = kPAPUserDefaultsCacheFacebookFriendsKey;
    [self.cache setObject:friends forKey:key];
    [[NSUserDefaults standardUserDefaults] setObject:friends forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)facebookFriends {
    NSString *key = kPAPUserDefaultsCacheFacebookFriendsKey;
    if ([self.cache objectForKey:key]) {
        return [self.cache objectForKey:key];
    }
    
    NSArray *friends = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if (friends) {
        [self.cache setObject:friends forKey:key];
    }

    return friends;
}


- (void)setAttributesforChannelUser:(NSArray *)channel{
    NSString *key = kPAPUserDefaultsCacheQueryChannelsKey;
    [self.cache setObject:channel forKey:key];
    [[NSUserDefaults standardUserDefaults] setObject:channel forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)channelobjects{
    NSString *key = kPAPUserDefaultsCacheQueryChannelsKey;
    if ([self.cache objectForKey:key]) {
        return [self.cache objectForKey:key];
    }
    NSArray *channelobjects = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (channelobjects) {
        [self.cache setObject:channelobjects forKey:key];
    }
    return channelobjects;
}

#pragma mark - ()

- (void)setAttributes:(NSDictionary *)attributes forPhoto:(PFObject *)photo {
    NSString *key = [self keyForPhoto:photo];
    [self.cache setObject:attributes forKey:key];
}

- (void)setAttributes:(NSDictionary *)attributes forQuestionChannel:(PFObject *)questionChannel {
    NSString *key = [self keyForQuestionChannel:questionChannel];
    [self.cache setObject:attributes forKey:key];
}

- (void)setAttributes:(NSDictionary *)attributes forUser:(PFUser *)user {
    NSString *key = [self keyForUser:user];
    [self.cache setObject:attributes forKey:key];    
}

- (NSString *)keyForPhoto:(PFObject *)photo {
    return [NSString stringWithFormat:@"photo_%@", [photo objectId]];
}

//新增
- (NSString *)keyForQuestionChannel:(PFObject *)quetionChannel {
    return [NSString stringWithFormat:@"questionChannel_%@", [quetionChannel objectId]];
}

- (NSString *)keyForUser:(PFUser *)user {
    return [NSString stringWithFormat:@"user_%@", [user objectId]];
}

@end
