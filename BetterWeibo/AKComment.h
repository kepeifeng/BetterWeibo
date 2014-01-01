//
//  AKComment.h
//  BetterWeibo
//
//  Created by Kent on 13-12-4.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKUserProfile.h"
#import "AKWeiboStatus.h"
@interface AKComment : NSObject

//评论（comment）

/**
 *评论创建时间
 */
@property NSString * created_at;
/**
 *评论的ID
 */
@property long long ID;
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
@property AKUserProfile * user;
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
@property AKWeiboStatus * status;
/**
 *评论来源评论，当本评论属于对另一评论的回复时返回此字段
 */
@property AKComment * reply_comment;

+(AKComment *)getCommentFromDictionary:(NSDictionary *)dictionary;
+(AKComment *)getCommentFromDictionary:(NSDictionary *)dictionary forStatus:(AKWeiboStatus *)status;

@end
