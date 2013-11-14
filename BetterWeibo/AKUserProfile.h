//
//  AKUserProfile.h
//  BetterWeibo
//
//  Created by Kent on 13-11-10.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKUserProfile : NSObject<NSCoding>

@property NSString * userID;
@property NSString * accessToken;
@property NSString * accessTokenExpiresIn;

@end
