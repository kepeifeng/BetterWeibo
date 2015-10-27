//
//  AKUserProfile.h
//  BetterWeibo
//
//  Created by Kent on 13-11-10.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKWeiboStatus.h"
extern NSString *const AKUserProfilePropertyNamedProfileImage;
extern NSString *const AKUserProfilePropertyNamedIsProcessingFollowingRequest;
extern NSString *const AKUserProfilePropertyNamedScreenName;

@interface AKUserProfile : NSObject<NSCoding>

/**
 *  用户UID
 */
@property long long ID;

/**
 *  字符串型的用户UID
 */
@property NSString *IDString;

/**
 *  Access Token
 */
//@property NSString * accessToken;

/**
 *  Access Token有效期
 */
//@property NSString * accessTokenExpiresIn;

/**
 *用户名
 */
@property NSString * name;
/**
 *用户昵称
 */
@property NSString * screen_name;

/**
 *所在省份代码ID
 */
@property NSString * province;


/**
 *所在城市代码ID
 */
@property NSString * city;
/**
 *所在地信息
 */
@property NSString * location;
/**
 *用户创建时间
 */
@property NSString * created_at;
/**
 *用户描述信息
 */
@property NSString * userDescription;
/**
 *个性化域名
 */
@property NSString * domain;

/**
 *  用户微号
 */
@property NSString * weihao;

/**
 *性别，m：男、f：女 n：未知
 */
@property NSString * gender;
/**
 *证件号码
 */
@property NSString * credentials_num;
/**
 *证件类型
 */
@property NSString * credentials_type;
/**
 *语言设置,用户当前的语言版本，zh-cn：简体中文，zh-tw：繁体中文，en：英语
 */
@property NSString * lang;
/**
 *头像地址
 */
@property NSString * profile_image_url;

@property NSImage * profileImage;

/**
 *  用户的微博统一URL地址
 */
@property NSString * profile_url;

/**
 *生日信息
 */
@property NSString * birthday;
/**
 *生日隐私类型，0：保密、1：只显示月日、2：只显示星座、3：所有人可见
 */
@property NSString * birthday_visible;
/**
 *联系邮箱地址
 */
@property NSString * email;
/**
 *邮箱地址隐私类型，0：自己可见、1：我关注人可见、2：所有人可见
 */
@property NSString * email_visible;
/**
 *账号信息
 */
@property NSString * msn;
/**
 *账号隐私类型，0：自己可见、1：我关注人可见、2：所有人可见
 */
@property NSString * msn_visible;
/**
 *号码
 */
@property NSString * qq;
/**
 *号码隐私类型，0：自己可见、1：我关注人可见、2：所有人可见
 */
@property NSString * qq_visible;
/**
 *真实姓名
 */
@property NSString * real_name;
/**
 *真实姓名隐私类型，0：自己可见、1：我关注人可见、2：所有人可见
 */
@property NSString * real_name_visible;
/**
 *用户博客地址
 */
@property NSString * url_string;
/**
 *用户博客地址隐私类型，0：自己可见、1：我关注人可见、2：所有人可见
 */
@property NSString * url_visible;

/**
 *  粉丝数
 */
@property NSInteger followers_count;


/**
 *  关注数
 */
@property NSInteger friends_count;
/**
 *  微博数
 */
@property NSInteger statuses_count;

/**
 *  收藏数
 */
@property NSInteger favourites_count;

/**
 *  是否允许所有人给我发私信，true：是，false：否
 */
@property BOOL allow_all_act_msg;

/**
 *  是否允许标识用户的地理位置，true：是，false：否
 */
@property BOOL geo_enabled;

/**
 *  是否是微博认证用户，即加V用户，true：是，false：否
 */
@property BOOL verified;

/**
 *  (暂未支持)
 */
@property NSInteger verified_type;


/**
 *  用户备注信息，只有在查询用户关系时才返回此字段
 */
@property NSString * remark;

/**
 *  用户的最近一条微博信息字段 详细
 */
@property AKWeiboStatus *status;

/**
 *  是否允许所有人对我的微博进行评论，true：是，false：否
 */
@property BOOL allow_all_comment;

/**
 *  用户头像地址（大图），180×180像素
 */
@property NSString *avatar_large;

/**
 *  用户头像地址（高清），高清头像原图
 */
@property NSString *avatar_hd;

/**
 *  认证原因
 */
@property NSString *verified_reason;

/**
 *  该用户是否关注当前登录用户，true：是，false：否
 */
@property BOOL follow_me;

/**
 *  本用户是否关注该用户
 */
@property BOOL following;

/**
 *  用户的在线状态，0：不在线、1：在线
 */
@property NSInteger online_status;

/**
 *  用户的互粉数
 */
@property NSInteger bi_followers_count;

@property NSInteger star;

@property BOOL isLoadingAvatarImage;

@property BOOL isProcessingFollowingRequest;


-(void)loadAvatarImages;

+(AKUserProfile *)getUserProfileByID:(NSString *)userID;
+(AKUserProfile *)getUserProfileFromDictionary:(NSDictionary *)userProfileDictionary;
+(void)addUserToDictionary:(AKUserProfile *)userProfile;
+(NSImage *)defaultAvatarImage;


@end
