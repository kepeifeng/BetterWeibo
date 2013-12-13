//
//  AKWeiboManager.h
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-11-2.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKWeibo.h"
#import "AKUserManager.h"
#import "AKAccessTokenObject.h"

#define METHOD_OPTION_NOTIFICATION @"METHOD_OPTION_NOTIFICATION"

@protocol AKWeiboManagerDelegate;

typedef  NS_ENUM(NSUInteger, AKWeiboTimelineType){
    
    AKPublicTimeline,
    AKFriendsTimeline,
    AKUserTimeline,
    AKRepostTimeline,
    AKMentionTimeline,
    AKFavoriteTimeline
    
};

@interface AKWeiboManager : NSObject <AKWeiboDelegate>


@property NSString *clientID;
@property NSString *redirectURL;
@property NSString *appSecret;
@property id<AKWeiboManagerDelegate> delegate;
@property (readonly) NSArray *users;

-(id)initWithClientID:(NSString *)clientID appSecret:(NSString *)appSecret redirectURL:(NSString *)redirectURL;

-(void)setOauth2Code:(NSString *)code;
-(void)startOauthLogin;
-(void)addMethodActionObserver:(id)observer selector:(SEL)selector;
//-(void)addUser:(AKAccessTokenObject *)accessTokenObject;

-(void)getUserDetail:(NSString *)userID;
-(void)getStatus;
-(void)getStatusForUser:(NSString *)userID sinceWeiboID:(NSString *)sinceWeiboID maxWeiboID:(NSString *)maxWeiboID count:(int)count page:(int)page baseApp:(BOOL)baseApp feature:(int)feature trimUser:(int)trimUser timelineType:(AKWeiboTimelineType)timelineType;

-(void)setAccessToken:(AKAccessTokenObject*)accessToken;

//-(BOOL)userExist:(NSString *)userID;

/**
 *  Get an AKUserProfile object from a AKParsingObject.
 *
 *  @param object An AKParsingObject.
 *
 *  @return An AKUserProfile
 */
+(AKAccessTokenObject *)getAccessTokenFromParsingObject:(AKParsingObject *)object;


@end



//============================================================================

@protocol AKWeiboManagerDelegate

-(void)OnDelegateComplete:(AKWeiboManager*)weiboManager methodOption:(AKMethodAction)methodOption  httpHeader:(NSString *)httpHeader result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask;

-(void)OnDelegateErrored:(AKWeiboManager *)weiboManager methodOption:(AKMethodAction)methodOption errCode:(NSInteger)errCode subErrCode:(NSInteger)subErrCode result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask;

-(void)OnDelegateWillRelease:(AKWeiboManager *)weiboManager methodOption:(AKMethodAction)methodOption pTask:(AKUserTaskInfo *)pTask;

@end

//============================================================================

@interface AKMethodActionObject : NSObject

-(id)initWithMethodAction:(AKMethodAction)methodAction;

@property AKMethodAction methodAction;

@end