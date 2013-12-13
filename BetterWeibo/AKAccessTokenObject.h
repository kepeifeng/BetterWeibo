//
//  AKAccessTokenObject.h
//  BetterWeibo
//
//  Created by Kent on 13-12-10.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKAccessTokenObject : NSObject<NSCoding>
/*
 uid        string 	授权用户的uid。
 appkey 	string 	access_token所属的应用appkey。
 scope      string 	用户授权的scope权限。
 create_at 	string 	access_token的创建时间，从1970年到创建时间的秒数。
 expire_in 	string 	access_token的剩余时间，单位是秒数。
 */

/**
*  授权用户的uid。
*/
@property NSString *userID;
/**
 *  用户授权时生成的access_token。
 */
@property NSString *accessToken;
/**
 *  access_token的剩余时间，单位是秒数。
 */
@property NSString *expireIn;
/**
 *  用户授权的scope权限。
 */
@property NSString *scope;
/**
 *  access_token的创建时间，从1970年到创建时间的秒数。
 */
@property NSString *createAt;



@end
