//
//  AKWeibo.h
//  BetterWeibo
//
//  Created by Kent on 13-10-6.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AKUserProfile;
/**
 *  微博内容
 * @see http://open.weibo.com/wiki/%E5%B8%B8%E8%A7%81%E8%BF%94%E5%9B%9E%E5%AF%B9%E8%B1%A1%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84#.E5.BE.AE.E5.8D.9A.EF.BC.88status.EF.BC.89
 */
@interface AKWeiboStatus : NSObject


 /**
 *微博创建时间
 */
@property NSString * created_at;
 /**
 *微博ID
 */
@property long long ID;
 /**
 *微博MID
 */
@property long long mid;
 /**
 *字符串型的微博ID
 */
@property NSString * idstr;
 /**
 *微博信息内容
 */
@property NSString * text;
 /**
 *微博来源
 */
@property NSString * source;
 /**
 *是否已收藏，true：是，false：否
 */
@property BOOL favorited;
 /**
 *是否被截断，true：是，false：否
 */
@property BOOL truncated;

/**
 *（暂未支持）回复ID
 */
@property NSString * in_reply_to_status_id;

/**
 *（暂未支持）回复人UID
 */
@property NSString * in_reply_to_user_id;

/**
 *（暂未支持）回复人昵称
 */
@property NSString * in_reply_to_screen_name;
 /**
 *缩略图片地址，没有时不返回此字段
 */
@property NSString * thumbnail_pic;
 /**
 *中等尺寸图片地址，没有时不返回此字段
 */
@property NSString * bmiddle_pic;
 /**
 *原始图片地址，没有时不返回此字段
 */
@property NSString * original_pic;
 /**
 *地理信息字段详细
 */
@property NSObject * geo;
 /**
 *微博作者的用户信息字段详细
 */
@property AKUserProfile * user;
 /**
 *被转发的原微博信息字段，当该微博为转发微博时返回详细
 */
@property AKWeiboStatus * retweeted_status;
 /**
 *转发数
 */
@property NSInteger reposts_count;
 /**
 *评论数
 */
@property NSInteger comments_count;
 /**
 *表态数
 */
@property NSInteger attitudes_count;
 /**
 *暂未支持
 */
@property NSInteger mlevel;
 /**
 *微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
 */
@property NSObject * visible;
 /**
 *微博配图地址。多图时返回多图链接。无配图返回“[]”
 */
@property NSArray * pic_urls;
 /**
 *微博流内的推广微博ID
 */
@property NSArray * ad;
 
/*
@property NSString * weiboId;
@property NSString * weiboContent;
@property NSString * username;
@property NSString *userAlias;
@property NSDate *date;
@property NSArray *images;
@property NSString *videoURL;
@property NSString *numberOfComments;
@property NSString *numberOfReposts;
@property NSString *numberOfLikes;
 */
//@property BOOL hasRepostedWeibo;
//@property AKWeiboStatus *repostedWeibo;

+(AKWeiboStatus *)getStatusFromDictionary:(NSDictionary *)statusDictionary;
+(AKWeiboStatus *)getStatusFromDictionary:(NSDictionary *)statusDictionary forStatus:(AKWeiboStatus *)repostedStatus;

@end

/**
 *  Weibo Visibility
 */
@interface AKWeiboVisibility : NSObject

/**
 *  0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；
 */
@property NSInteger type;
/**
 *  分组的组号
 */
@property NSInteger list_id;

/**
 *  Get a AKWeiboVisibility object from a NSDictionary object.
 *
 *  @param visibilityDictionary A NSDictionary object contains visibility information of a status.
 *
 *  @return A AKWeiboVisibility object.
 */
+(AKWeiboVisibility *)getVisibilityFromDictionary:(NSDictionary *)visibilityDictionary;


@end


/**
 *  Weibo Ad
 */
@interface AKWeiboAd : NSObject

@property long long ID;
@property NSString * mark;



@end

