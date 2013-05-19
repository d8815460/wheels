//
//  PAPConstants.m
//  Anypic
//
//  Created by Mattieu Gamache-Asselin on 5/25/12.
//  Copyright (c) 2012 Parse. All rights reserved.
//

#import "PAPConstants.h"


#pragma mark - MapViewNeed
NSUInteger const kPAWWallPostMaximumCharacterCount = 140;

double const kPAWFeetToMeters = 0.3048;                                 // this is an exact value.
double const kPAWFeetToMiles = 5280.0;;                                 // this is an exact value.
double const kPAWWallPostMaximumSearchDistance = 3.0;
double const kPAWMetersInAKilometer = 1000.0;                           // this is an exact value.

NSUInteger const kPAWWallPostsSearch = 20;                              // query limit for pins and tableviewcells
NSUInteger const kPAWWallPostsSearchForMap = 100;
// NSNotification userInfo keys:
NSString * const kPAWFilterDistanceKey = @"filterDistance";
NSString * const kPAWLocationKey = @"location";

// Notification names:
NSString * const kPAWFilterDistanceChangeNotification = @"kPAWFilterDistanceChangeNotification";
NSString * const kPAWLocationChangeNotification = @"kPAWLocationChangeNotification";
NSString * const kPAWPostCreatedNotification = @"kPAWPostCreatedNotification";

// UI strings:
NSString * const kPAWWallCantViewPost = @"距離太遠，請再靠近。";

//個人檔案照片儲存位置
NSString * const MediumImagefilePath = @"Documents/medium.png";
NSString * const SmallRoundedImagefilePath = @"Documents/small.png";


NSString *const kPAPUserDefaultsActivityFeedViewControllerLastRefreshKey    = @"com.formulawebllc.Wheels.userDefaults.activityFeedViewController.lastRefresh";
NSString *const kPAPUserDefaultsHomeFeedViewControllerLastRefreshKey        = @"com.formulawebllc.Wheels.userDefaults.HomeFeedViewController.lastRefresh";
NSString *const kPAPUserDefaultsMyQChannelFeedViewControllerLastRefreshKey  = @"com.formulawebllc.Wheels.userDefaults.MyQChannelFeedViewController.lastRefresh";
NSString *const kPAPUserDefaultsMyQuestionFeedViewControllerLastRefreshKey  = @"com.formulawebllc.Wheels.userDefaults.MyQuestionFeedViewController.lastRefresh";
NSString *const kPAPUserDefaultsMyAnswerFeedViewControllerLastRefreshKey    = @"com.formulawebllc.Wheels.userDefaults.MyAnswerFeedViewController.lastRefresh";
NSString *const kPAPUserDefaultsAnnouncementFeedViewControllerLastRefreshKey= @"com.formulawebllc.Wheels.userDefaults.AnnouncementFeedViewController.lastRefresh";
NSString *const kPAPUserDefaultsCacheFacebookFriendsKey                     = @"com.formulawebllc.Wheels.userDefaults.cache.facebookFriends";
NSString *const kPAPUserDefaultsCacheQueryChannelsKey                       = @"com.formulawebllc.Wheels.queryChannels.cache.Channels";

#pragma mark - Launch URLs

NSString *const kPAPLaunchURLHostTakePicture = @"camera";


#pragma mark - NSNotification

NSString *const PAPAppDelegateApplicationDidReceiveRemoteNotification           = @"com.formulawebllc.Wheels.appDelegate.applicationDidReceiveRemoteNotification";
NSString *const PAPUtilityUserFollowingChangedNotification                      = @"com.formulawebllc.Wheels.utility.userFollowingChanged";
NSString *const PAPUtilityUserLikedUnlikedPhotoCallbackFinishedNotification     = @"com.formulawebllc.Wheels.utility.userLikedUnlikedPhotoCallbackFinished";
NSString *const PAPUtilityDidFinishProcessingProfilePictureNotification         = @"com.formulawebllc.Wheels.utility.didFinishProcessingProfilePictureNotification";
NSString *const PAPTabBarControllerDidFinishEditingPhotoNotification            = @"com.formulawebllc.Wheels.tabBarController.didFinishEditingPhoto";
NSString *const PAPTabBarControllerDidFinishImageFileUploadNotification         = @"com.formulawebllc.Wheels.tabBarController.didFinishImageFileUploadNotification";
NSString *const PAPPhotoDetailsViewControllerUserDeletedPhotoNotification       = @"com.formulawebllc.Wheels.photoDetailsViewController.userDeletedPhoto";
NSString *const PAPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotification  = @"com.formulawebllc.Wheels.photoDetailsViewController.userLikedUnlikedPhotoInDetailsViewNotification";
NSString *const PAPPhotoDetailsViewControllerUserCommentedOnPhotoNotification   = @"com.formulawebllc.Wheels.photoDetailsViewController.userCommentedOnPhotoInDetailsViewNotification";


#pragma mark - User Info Keys
NSString *const PAPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotificationUserInfoLikedKey = @"liked";
NSString *const kPAPEditPhotoViewControllerUserInfoCommentKey = @"comment";

#pragma mark - Installation Class

// Field keys
NSString *const kPAPInstallationUserKey = @"user";
NSString *const kPAPInstallationChannelsKey = @"channels";


#pragma mark - PFObject Announcement Class
// Class key
NSString *const kPAPAnnouncementsKey          = @"Announcement";             //公告鍵

//Field keys
NSString *const kPAPAnnouncementTitleKey      = @"title";                    //公告標題
NSString *const kPAPAnnouncementContentKey    = @"content";                  //公告內容
NSString *const kPAPAnnouncementImageKey      = @"image";                    //大圖片
NSString *const kPAPAnnouncementThumbnailKey  = @"thumbnail";                //小圖片


#pragma mark - PFObject QuestionChannel Class
// Class key
NSString *const kPAPQueryChannelsKey              = @"QChannel";      //問題頻道鍵

//Field keys
NSString *const kPAPQueryChannelQuestionKey       = @"question";             //問題頻道的問題鍵
NSString *const kPAPQueryChannelAskUserKey        = @"AskUser";              //發問者鍵
NSString *const kPAPQueryChannelAnswerUserKey     = @"AnswerUser";           //回復者鍵
NSString *const kPAPQueryChannelChannelKey        = @"channel";              //發問者＋回復者頻道鍵
NSString *const kPAPQueryChannelTypeKey           = @"type";                 //類型 （喜歡、檢舉、刪除）
NSString *const kPAPQueryChannelLikeKey           = @"isLiked";
NSString *const kPAPQueryChannelSpanKey           = @"isSpaned";
NSString *const kPAPQueryChannelDeleteKey         = @"isDeleted";

// Type values
BOOL const kPAPQueryChannelTypeLike          = YES;                      //喜歡
BOOL const kPAPQueryChannelTypeUnLike        = NO;                      //預設不喜歡 = 0
BOOL const kPAPQueryChannelTypeSpan          = YES;                      //檢舉
BOOL const kPAPQueryChannelTypeUnSpan        = NO;                      //預設部檢舉 = 0
BOOL const kPAPQueryChannelTypeDelete        = YES;                      //刪除
BOOL const kPAPQueryChannelTypeUnDelete      = NO;                      //預設不刪除 = 0
NSInteger const kPAPQueryChannelTypeComment       = 0;                      //comment = 0

#pragma mark - Activity Class
// Class key
NSString *const kPAPActivityClassKey = @"Activity";

// Field keys
NSString *const kPAPActivityTypeKey        = @"type";
NSString *const kPAPActivityFromUserKey    = @"fromUser";
NSString *const kPAPActivityToUserKey      = @"toUser";
NSString *const kPAPActivityContentKey     = @"content";
NSString *const kPAPActivityPhotoKey       = @"photo";

// Type values
NSInteger const kPAPActivityTypeComment    = 0;             //0 = comment
NSInteger const kPAPActivityTypeFollow     = 1;             //1 = follow
NSInteger const kPAPActivityTypeJoined     = 2;             //2 = joined
NSInteger const kPAPActivityTypeLike       = 3;             //3 = like

#pragma mark - User Class
// Field keys
NSString *const kPAPUserDisplayNameKey                          = @"displayName";
NSString *const kPAPUserFacebookIDKey                           = @"facebookId";
NSString *const kPAPUserPhotoIDKey                              = @"photoId";
NSString *const kPAPUserProfilePicSmallKey                      = @"profilePictureSmall";
NSString *const kPAPUserProfilePicMediumKey                     = @"profilePictureMedium";
NSString *const kPAPUserFacebookFriendsKey                      = @"facebookFriends";
NSString *const kPAPUserAlreadyAutoFollowedFacebookFriendsKey   = @"userAlreadyAutoFollowedFacebookFriends";
NSString *const kPAPUserPrivateChannelKey                       = @"channel";
//資料表新增生日、性別、email、地區、姓氏、名字
NSString *const kPAPUserFacebookBirthdayKey                     = @"birthday";
NSString *const kPAPUserFacebookGenderKey                       = @"gender";
NSString *const kPAPUserFacebookEmailKey                        = @"email";
NSString *const kPAPUserFacebookLocalsKey                       = @"fbLocale";
NSString *const kPAPUserFacebookFirstNameKey                    = @"fbFirstName";
NSString *const kPAPUserFacebookLastNameKey                     = @"fbLastName";

#pragma mark - Ask with Photo Class
// Class key
NSString *const kPAPPhotoClassKey = @"Question";

// Field keys

NSString *const kPAPPhotoPictureKey         = @"image";
NSString *const kPAPPhotoThumbnailKey       = @"thumbnail";
NSString *const kPAPPhotoUserKey            = @"user";
NSString *const kPAPPhotoOpenGraphIDKey     = @"fbOpenGraphID";
NSString *const kPAWParseTextKey            = @"text";
NSString *const kPAWParseComeFromKey        = @"comefrom";
NSString *const kPAWParseLocationKey        = @"location";
NSString *const kPAWParseCategoryKey        = @"Category";

#pragma mark - Cached Photo Attributes
// keys
NSString *const kPAPPhotoAttributesIsLikedByCurrentAndAskUserKey    = @"isLikedByCurrentAndAskUser";
NSString *const kPAPPhotoAttributesIsLikedByCurrentUserKey          = @"isLikedByCurrentUser";
NSString *const kPAPPhotoAttributesLikeCountKey                     = @"likeCount";
NSString *const kPAPPhotoAttributesLikersKey                        = @"likers";
NSString *const kPAPPhotoAttributesCommentCountKey                  = @"commentCount";
NSString *const kPAPPhotoAttributesCommentersKey                    = @"commenters";


#pragma mark - Cached User Attributes
// keys
NSString *const kPAPUserAttributesPhotoCountKey                 = @"photoCount";
NSString *const kPAPUserAttributesIsFollowedByCurrentUserKey    = @"isFollowedByCurrentUser";


#pragma mark - Push Notification Payload Keys

NSString *const kAPNSAlertKey = @"alert";
NSString *const kAPNSBadgeKey = @"badge";
NSString *const kAPNSSoundKey = @"sound";

// the following keys are intentionally kept short, APNS has a maximum payload limit
// 下面的鍵被故意盡量短，APNS的最大有效載荷限制
NSString *const kPAPPushPayloadPayloadTypeKey          = @"p";
NSString *const kPAPPushPayloadPayloadTypeActivityKey  = @"a";

NSString *const kPAPPushPayloadActivityTypeKey     = @"t";
NSString *const kPAPPushPayloadActivityLikeKey     = @"l";
NSString *const kPAPPushPayloadActivityCommentKey  = @"c";
NSString *const kPAPPushPayloadActivityFollowKey   = @"f";
NSString *const kPAPPushPayloadActivitySpanKey     = @"s";

NSString *const kPAPPushPayloadFromUserObjectIdKey = @"fu";
NSString *const kPAPPushPayloadToUserObjectIdKey   = @"tu";
NSString *const kPAPPushPayloadPhotoObjectIdKey    = @"pid";


#pragma mark - Category Keys

NSString *const kPAPChoseCategoryfoodNfunIdKey      = @"foodNfun";
NSString *const kPAPChoseCategoryroadTrafficIdKey   = @"roadTraffic";
NSString *const kPAPChoseCategoryTicketInfoIdKey    = @"TicketInfo";
NSString *const kPAPChoseCategoryshopSellIdKey      = @"shopSell";
NSString *const kPAPChoseCategoryShowOffIdKey       = @"ShowOff";
NSString *const kPAPChoseCategoryLostNFoundIdKey    = @"LostNFound";
NSString *const kPAPChoseCategorySocialIdKey        = @"Social";
NSString *const kPAPChoseCategoryEmergencyIdKey     = @"Emergency";
NSString *const kPAPChoseCategorystartAskIdKey      = @"startAsk";

NSString *const CategoryfoodNfunImageKey       = @"category_foodNfun.png";
NSString *const CategoryroadTrafficImageKey    = @"category_roadTraffic.png";
NSString *const CategoryTicketInfoImageKey     = @"category_TicketInfo.png";
NSString *const CategoryshopSellImageKey       = @"category_shopSell.png";
NSString *const CategoryShowOffImageKey        = @"category_ShowOff.png";
NSString *const CategoryLostNFoundImageKey     = @"category_LostNFound.png";
NSString *const CategorySocialImageKey         = @"category_Social.png";
NSString *const CategoryEmergencyImageKey      = @"category_Emergency.png";
NSString *const CategorystartAskImageKey       = @"category_startAsk.png";
