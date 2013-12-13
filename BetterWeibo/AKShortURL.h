//
//  AKShortURL.h
//  BetterWeibo
//
//  Created by Kent on 13-12-4.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKShortURL : NSObject

//评论（comment）

/**
 *评论创建时间
 */
@property NSString * created_at;
/**
 *评论的ID
 */
@property long long id;
/**
 *评论的内容
 */
@property NSString * text;
/**
 *评论的来源
 */
@property NSString * source;
/**
 *评论作者的用户信息字段详细
 */
@property NSObject * user;
/**
 *评论的MID
 */
@property NSString * mid;
/**
 *字符串型的评论ID
 */
@property NSString * idstr;
/**
 *评论的微博信息字段详细
 */
@property NSObject * status;
/**
 *评论来源评论，当本评论属于对另一评论的回复时返回此字段
 */
@property NSObject * reply_comment;



//短链（url_short）

/**
 *短链接
 */
@property NSString * url_short;
/**
 *原始长链接
 */
@property NSString * url_long;
/**
 *链接的类型，0：普通网页、1：视频、2：音乐、3：活动、5、投票
 */
@property NSInteger type;
/**
 *短链的可用状态，true：可用、false：不可用。
 */
@property BOOL result;




@end
