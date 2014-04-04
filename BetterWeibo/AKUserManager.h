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

@protocol AKUserManagerListenerProtocol <NSObject>

@optional
-(void)userProfileDidInserted:(AKUserProfile *)userProfile atIndex:(NSInteger)index;

-(void)userProfileDidRemoved:(AKUserProfile *)userProfile atIndex:(NSInteger)index;

-(void)userProfileDidUpdated:(AKUserProfile *)userProfile atIndex:(NSInteger)index;

-(void)currentUserDidChanged;

-(void)accessTokenDidUpdated:(AKUserProfile *)userProfile accessToken:(AKAccessTokenObject *)accessToken;

@end

@interface AKUserManager : NSObject

+(AKUserManager *)defaultUserManager;

-(BOOL)hasUserExisted;




-(NSArray *)allUserProfiles;
-(AKUserProfile *)loadUserProfile:(NSString *)userID;

-(NSArray *)getAllUserProfileFromDisk;
-(NSArray *)getAllAccessTokenFromDisk;

-(void)saveUserProfileToDisk:(AKUserProfile *)userProfile;
-(void)saveAccessTokenToDisk:(AKAccessTokenObject *)accessTokenObject;

-(void)addUserProfile:(AKUserProfile *)userProfile;
-(void)addAccessToken:(AKAccessTokenObject *)accessTokenObject;

-(void)updateUserProfile:(AKUserProfile *)userProfile;
-(void)updateUserAccessToken:(AKAccessTokenObject *)accessTokenObject;


-(NSArray *)allAccessTokens;

-(BOOL)isAppUser:(NSString *)userID;

@property NSString *currentUserID;
@property (readonly) AKAccessTokenObject *currentAccessToken;
@property (readonly) AKUserProfile *currentUserProfile;
@property (readonly) NSUInteger numberOfUser;

-(NSString *)getUserIDByAccessToken:(NSString *)accessToken;
-(AKAccessTokenObject *)getAccessTokenByUserID:(NSString *)userID;
-(AKUserProfile *)getUserProfileByUserID:(NSString *)userID;

-(AKUserProfile *)userAtIndex:(NSUInteger)index;
-(NSUInteger)indexOfUserProfile:(AKUserProfile *)userProfile;

-(void)removeUserAtIndex:(NSInteger)index;

#pragma mark - Listener
-(void)addListener:(id<AKUserManagerListenerProtocol>)listener;
-(void)removeListener:(id<AKUserManagerListenerProtocol>)listener;

@end
