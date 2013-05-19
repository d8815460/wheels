//
//  PAPConstants.h
//  Anypic
//
//  Created by Mattieu Gamache-Asselin on 5/25/12.
//  Copyright (c) 2012 Parse. All rights reserved.
//

typedef enum {
	AYIHomeTabBarItemIndex = 0,
	PAPEmptyTabBarItemIndex = 1,
	PAPActivityTabBarItemIndex = 2
} PAPTabBarControllerViewControllerIndex;


#define kPAPParseEmployeeAccounts [NSArray array]

#pragma mark - MapViewNeed
extern NSUInteger const kPAWWallPostMaximumCharacterCount;

extern double const kPAWFeetToMeters;                               // this is an exact value.
extern double const kPAWFeetToMiles;                                // this is an exact value.
extern double const kPAWWallPostMaximumSearchDistance;
extern double const kPAWMetersInAKilometer;                         // this is an exact value.

extern NSUInteger const kPAWWallPostsSearch;                        // query limit for pins and tableviewcells
extern NSUInteger const kPAWWallPostsSearchForMap;

// NSNotification userInfo keys:
extern NSString * const kPAWFilterDistanceKey;
extern NSString * const kPAWLocationKey;

// Notification names:
extern NSString * const kPAWFilterDistanceChangeNotification;
extern NSString * const kPAWLocationChangeNotification;
extern NSString * const kPAWPostCreatedNotification;

// UI strings:
extern NSString * const kPAWWallCantViewPost;

// 個人檔案照片儲存位置
extern NSString * const MediumImagefilePath;
extern NSString * const SmallRoundedImagefilePath;


#define PAWLocationAccuracy double


#pragma mark - NSUserDefaults
extern NSString *const kPAPUserDefaultsActivityFeedViewControllerLastRefreshKey;    //用戶默認設置的活動資訊 - 視圖 - 控制器刷新鍵
extern NSString *const kPAPUserDefaultsHomeFeedViewControllerLastRefreshKey;        //首頁最後一次刷新鍵
extern NSString *const kPAPUserDefaultsMyQChannelFeedViewControllerLastRefreshKey;  //L2刷新鍵
extern NSString *const kPAPUserDefaultsMyQuestionFeedViewControllerLastRefreshKey;  //我的問題最後一次刷新鍵
extern NSString *const kPAPUserDefaultsMyAnswerFeedViewControllerLastRefreshKey;    //我的回答最後一次刷新鍵
extern NSString *const kPAPUserDefaultsAnnouncementFeedViewControllerLastRefreshKey;//公告最後一次刷新鍵
extern NSString *const kPAPUserDefaultsCacheFacebookFriendsKey;                     //用戶默認緩存給好友鍵
extern NSString *const kPAPUserDefaultsCacheQueryChannelsKey;                       //用戶默認緩存問題頻道鍵


#pragma mark - Launch URLs

extern NSString *const kPAPLaunchURLHostTakePicture;                                //啟動URL主機拍照


#pragma mark - NSNotification
extern NSString *const PAPAppDelegateApplicationDidReceiveRemoteNotification;
extern NSString *const PAPUtilityUserFollowingChangedNotification;
extern NSString *const PAPUtilityUserLikedUnlikedPhotoCallbackFinishedNotification;
extern NSString *const PAPUtilityDidFinishProcessingProfilePictureNotification;
extern NSString *const PAPTabBarControllerDidFinishEditingPhotoNotification;
extern NSString *const PAPTabBarControllerDidFinishImageFileUploadNotification;
extern NSString *const PAPPhotoDetailsViewControllerUserDeletedPhotoNotification;
extern NSString *const PAPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotification;
extern NSString *const PAPPhotoDetailsViewControllerUserCommentedOnPhotoNotification;


#pragma mark - User Info Keys
extern NSString *const PAPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotificationUserInfoLikedKey;
extern NSString *const kPAPEditPhotoViewControllerUserInfoCommentKey;


#pragma mark - Installation Class

// Field keys
extern NSString *const kPAPInstallationUserKey;
extern NSString *const kPAPInstallationChannelsKey;


#pragma mark - PFObject Announcement Class
// Class key
extern NSString *const kPAPAnnouncementsKey;                                        //公告鍵

//Field keys
extern NSString *const kPAPAnnouncementTitleKey;                                    //公告標題
extern NSString *const kPAPAnnouncementContentKey;                                  //公告內容
extern NSString *const kPAPAnnouncementImageKey;                                    //大圖片
extern NSString *const kPAPAnnouncementThumbnailKey;                                //小圖片


#pragma mark - PFObject QuestionChannel Class
// Class key
extern NSString *const kPAPQueryChannelsKey;                                        //問題頻道鍵

//Field keys
extern NSString *const kPAPQueryChannelQuestionKey;                                 //問題頻道的問題鍵
extern NSString *const kPAPQueryChannelAskUserKey;                                  //發問者鍵
extern NSString *const kPAPQueryChannelAnswerUserKey;                               //回復者鍵
extern NSString *const kPAPQueryChannelChannelKey;                                  //發問者＋回復者頻道鍵
extern NSString *const kPAPQueryChannelTypeKey;                                     //類型 （喜歡、檢舉、刪除）
extern NSString *const kPAPQueryChannelLikeKey;
extern NSString *const kPAPQueryChannelSpanKey;
extern NSString *const kPAPQueryChannelDeleteKey;

// Type values
extern BOOL const kPAPQueryChannelTypeLike;        //like = 1
extern BOOL const kPAPQueryChannelTypeUnLike;      //unlike = 0
extern BOOL const kPAPQueryChannelTypeSpan;        //span = 1
extern BOOL const kPAPQueryChannelTypeUnSpan;      //unspan = 0
extern BOOL const kPAPQueryChannelTypeDelete;      //delete = 1
extern BOOL const kPAPQueryChannelTypeUnDelete;    //undelete = 0
extern NSInteger const kPAPQueryChannelTypeComment;     //comment = 0

#pragma mark - PFObject Activity Class
// Class key
extern NSString *const kPAPActivityClassKey;

// Field keys
extern NSString *const kPAPActivityTypeKey;
extern NSString *const kPAPActivityFromUserKey;
extern NSString *const kPAPActivityToUserKey;
extern NSString *const kPAPActivityContentKey;
extern NSString *const kPAPActivityPhotoKey;

// Type values
extern NSInteger const kPAPActivityTypeComment;         //comment = 0
extern NSInteger const kPAPActivityTypeFollow;          //follow = 1
extern NSInteger const kPAPActivityTypeJoined;          //joined = 2
extern NSInteger const kPAPActivityTypeLike;            //like   = 3

#pragma mark - PFObject User Class
// Field keys
extern NSString *const kPAPUserDisplayNameKey;
extern NSString *const kPAPUserFacebookIDKey;
extern NSString *const kPAPUserPhotoIDKey;
extern NSString *const kPAPUserProfilePicSmallKey;
extern NSString *const kPAPUserProfilePicMediumKey;
extern NSString *const kPAPUserFacebookFriendsKey;
extern NSString *const kPAPUserAlreadyAutoFollowedFacebookFriendsKey;
extern NSString *const kPAPUserPrivateChannelKey;
//facebook 生日、性別、email、地區、姓氏、名字
extern NSString *const kPAPUserFacebookBirthdayKey;
extern NSString *const kPAPUserFacebookGenderKey;
extern NSString *const kPAPUserFacebookEmailKey;
extern NSString *const kPAPUserFacebookLocalsKey;
extern NSString *const kPAPUserFacebookFirstNameKey;
extern NSString *const kPAPUserFacebookLastNameKey;
extern NSString *const kPAPUserFacebookLocation;


#pragma mark - PFObject Photo Class
// Class key
extern NSString *const kPAPPhotoClassKey;

// Field keys
extern NSString *const kPAPPhotoPictureKey;
extern NSString *const kPAPPhotoThumbnailKey;
extern NSString *const kPAPPhotoUserKey;
extern NSString *const kPAPPhotoOpenGraphIDKey;
extern NSString *const kPAWParseTextKey;
extern NSString *const kPAWParseComeFromKey;
extern NSString *const kPAWParseLocationKey;
extern NSString *const kPAWParseCategoryKey;


#pragma mark - Cached Photo Attributes
// keys
// 發問用戶給愛心
extern NSString *const kPAPPhotoAttributesIsLikedByCurrentAndAskUserKey;
extern NSString *const kPAPPhotoAttributesIsLikedByCurrentUserKey;
extern NSString *const kPAPPhotoAttributesLikeCountKey;
extern NSString *const kPAPPhotoAttributesLikersKey;
extern NSString *const kPAPPhotoAttributesCommentCountKey;
extern NSString *const kPAPPhotoAttributesCommentersKey;


#pragma mark - Cached User Attributes
// keys
extern NSString *const kPAPUserAttributesPhotoCountKey;
extern NSString *const kPAPUserAttributesIsFollowedByCurrentUserKey;


#pragma mark - PFPush Notification Payload Keys

extern NSString *const kAPNSAlertKey;
extern NSString *const kAPNSBadgeKey;
extern NSString *const kAPNSSoundKey;

extern NSString *const kPAPPushPayloadPayloadTypeKey;
extern NSString *const kPAPPushPayloadPayloadTypeActivityKey;

extern NSString *const kPAPPushPayloadActivityTypeKey;
extern NSString *const kPAPPushPayloadActivityLikeKey;
extern NSString *const kPAPPushPayloadActivityCommentKey;
extern NSString *const kPAPPushPayloadActivityFollowKey;
extern NSString *const kPAPPushPayloadActivitySpanKey;

extern NSString *const kPAPPushPayloadFromUserObjectIdKey;
extern NSString *const kPAPPushPayloadToUserObjectIdKey;
extern NSString *const kPAPPushPayloadPhotoObjectIdKey;


#pragma mark - Category Keys

extern NSString *const kPAPChoseCategoryfoodNfunIdKey;
extern NSString *const kPAPChoseCategoryroadTrafficIdKey;
extern NSString *const kPAPChoseCategoryTicketInfoIdKey;
extern NSString *const kPAPChoseCategoryshopSellIdKey;
extern NSString *const kPAPChoseCategoryShowOffIdKey;
extern NSString *const kPAPChoseCategoryLostNFoundIdKey;
extern NSString *const kPAPChoseCategorySocialIdKey;
extern NSString *const kPAPChoseCategoryEmergencyIdKey;
extern NSString *const kPAPChoseCategorystartAskIdKey;

extern NSString *const kPAPChoseCategoryfoodNfunImageKey;
extern NSString *const kPAPChoseCategoryroadTrafficImageKey;
extern NSString *const kPAPChoseCategoryTicketInfoImageKey;
extern NSString *const kPAPChoseCategoryshopSellImageKey;
extern NSString *const kPAPChoseCategoryShowOffImageKey;
extern NSString *const kPAPChoseCategoryLostNFoundImageKey;
extern NSString *const kPAPChoseCategorySocialImageKey;
extern NSString *const kPAPChoseCategoryEmergencyImageKey;
extern NSString *const kPAPChoseCategorystartAskImageKey;





