//
//  AKPrivacyInfo.h
//  BetterWeibo
//
//  Created by Kent on 13-12-4.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKPrivacyInfo : NSObject

/**
 *是否可以评论我的微博，0：所有人、1：关注的人、2：可信用户
 */
@property NSInteger comment;

/**
 *是否开启地理信息，0：不开启、1：开启
 */
@property NSInteger geo;

/**
 *是否可以给我发私信，0：所有人、1：我关注的人、2：可信用户
 */
@property NSInteger message;

/**
 *是否可以通过真名搜索到我，0：不可以、1：可以
 */
@property NSInteger realname;

/**
 *勋章是否可见，0：不可见、1：可见
 */
@property NSInteger badge;

/**
 *是否可以通过手机号码搜索到我，0：不可以、1：可以
 */
@property NSInteger mobile;

/**
 *是否开启webim，0：不开启、1：开启
 */
@property NSInteger webim;



@end
