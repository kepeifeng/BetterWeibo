//
//  AKRemind.h
//  BetterWeibo
//
//  Created by Kent on 13-12-4.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKRemind : NSObject

//消息未读数（remind）

/**
 *新微博未读数
 */
@property NSInteger status;
/**
 *新粉丝数
 */
@property NSInteger follower;
/**
 *新评论数
 */
@property NSInteger cmt;
/**
 *新私信数
 */
@property NSInteger dm;
/**
 *新提及我的微博数
 */
@property NSInteger mention_status;
/**
 *新提及我的评论数
 */
@property NSInteger mention_cmt;
/**
 *微群消息未读数
 */
@property NSInteger group;
/**
 *私有微群消息未读数
 */
@property NSInteger private_group;
/**
 *新通知未读数
 */
@property NSInteger notice;
/**
 *新邀请未读数
 */
@property NSInteger invite;
/**
 *新勋章数
 */
@property NSInteger badge;
/**
 *相册消息未读数
 */
@property NSInteger photo;
/**
 *{{{3}}}
 */
@property NSInteger msgbox;

@end
