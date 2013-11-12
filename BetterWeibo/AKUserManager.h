//
//  AKUserManager.h
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-11-1.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKUserProfile.h"

@interface AKUserManager : NSObject

+(AKUserManager *)defaultUserManager;

-(BOOL)hasUserExisted;

-(NSArray *)getAllUserProfile;
-(AKUserProfile *)loadUserProfile:(NSString *)userID;
-(void)createUserProfile:(AKUserProfile *)userProfile;
-(void)updateUserAccessToken:(AKUserProfile *)userProfile;

@end
