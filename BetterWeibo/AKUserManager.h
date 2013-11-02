//
//  AKUserManager.h
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-11-1.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKUserManager : NSObject

+(AKUserManager *)defaultUserManager;

-(void)createUserProfile:(NSString *)userID withAccessToken:(NSString *)accessToken;
-(void)updateUserAccessToken:(NSString *)userID accessToken:(NSString *)accessToken;

@end
