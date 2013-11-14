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

#define METHOD_OPTION_NOTIFICATION @"METHOD_OPTION_NOTIFICATION"

@protocol AKWeiboManagerDelegate;

@interface AKWeiboManager : NSObject <AKWeiboDelegate>


@property NSString *clientID;
@property NSString *redirectURL;
@property NSString *appSecret;
@property id<AKWeiboManagerDelegate> delegate;

-(id)initWithClientID:(NSString *)clientID appSecret:(NSString *)appSecret redirectURL:(NSString *)redirectURL;

-(void)setOauth2Code:(NSString *)code;
-(void)startOauthLogin;
-(void)addMethodActionObserver:(id)observer selector:(SEL)selector;
-(void)addUser:(AKUserProfile *)userProfile;
-(void)getUserDetail:(NSString *)userID;
-(void)getStatus;

/**
 *  Get an AKUserProfile object from a AKParsingObject.
 *
 *  @param object An AKParsingObject.
 *
 *  @return An AKUserProfile
 */
+(AKUserProfile *)getUserProfileFromParsingObject:(AKParsingObject *)object;


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