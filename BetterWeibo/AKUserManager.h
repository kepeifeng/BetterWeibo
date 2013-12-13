//
//  AKUserManager.h
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-11-1.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKUserProfile.h"
#import "AKAccessTokenObject.h"

@interface AKUserManager : NSObject

+(AKUserManager *)defaultUserManager;

-(BOOL)hasUserExisted;


-(NSArray *)allUserProfiles;
-(AKUserProfile *)loadUserProfile:(NSString *)userID;
-(void)createUserProfile:(AKUserProfile *)userProfile;
-(void)updateUserProfile:(AKUserProfile *)userProfile;
-(void)updateUserAccessToken:(AKAccessTokenObject *)accessTokenObject;
-(void)addObserver:(id)observer selector:(SEL)selector;

-(NSArray *)allAccessTokens;

-(BOOL)isAppUser:(NSString *)userID;

@property NSString *currentUserID;
@property (readonly) AKAccessTokenObject *currentAccessToken;
@property (readonly) AKUserProfile *currentUserProfile;

-(NSString *)getUserIDByAccessToken:(NSString *)accessToken;

@end
