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
#import "AKError.h"

#define METHOD_OPTION_NOTIFICATION @"METHOD_OPTION_NOTIFICATION"

@protocol AKWeiboManagerDelegate;

typedef  NS_ENUM(NSUInteger, AKWeiboTimelineType){
    
    AKPublicTimeline,
    AKFriendsTimeline,
    AKUserTimeline,
    AKRepostTimeline,
    AKMentionTimeline,
    AKFavoriteTimeline,
    AKSearchTimeline
    
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
-(void)getUserDetail:(AKID *)userID callbackTarget:(id<AKWeiboManagerDelegate>)target;
-(void)getStatus;
-(void)getStatusForUser:(NSString *)userID sinceWeiboID:(NSString *)sinceWeiboID maxWeiboID:(NSString *)maxWeiboID count:(int)count page:(int)page baseApp:(BOOL)baseApp feature:(int)feature trimUser:(int)trimUser timelineType:(AKWeiboTimelineType)timelineType;

-(void)getStatusForUser:(AKID *)userID sinceWeiboID:(NSString *)sinceWeiboID maxWeiboID:(NSString *)maxWeiboID count:(int)count page:(int)page baseApp:(BOOL)baseApp feature:(int)feature trimUser:(int)trimUser timelineType:(AKWeiboTimelineType)timelineType callbackTarget:(id<AKWeiboManagerDelegate>)target;

-(void)getStatusComment:(NSString *)weiboID callbackTarget:(id<AKWeiboManagerDelegate>)target;
-(void)getStatusRepost:(NSString *)weiboID callbackTarget:(id<AKWeiboManagerDelegate>)target;
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

-(void)postStatus:(NSString *)status forUser:(AKUserProfile *)user callbackTarget:(id<AKWeiboManagerDelegate>)target;
/**
 *  发表带图片的微博
 *
 *  @param status 微博文本
 *  @param images 图片，一个NSURL的数组
 *  @param user   发微博的用户
 *  @param target callback target
 */
-(void)postStatus:(NSString *)status withImages:(NSArray *)images forUser:(AKUserProfile *)user callbackTarget:(id<AKWeiboManagerDelegate>)target;

/**
 *  转发一条微博
 *
 *  @param statusID            要转发的微博ID。
 *  @param content             添加的转发文本，必须做URLencode，内容不超过140个汉字，不填则默认为“转发微博”。
 *  @param commentOriginStatus 是否在转发的同时发表评论，0：否、1：评论给当前微博、2：评论给原微博、3：都评论，默认为0 。
 *  @param target              callback
 */
-(void)postRepostStatus:(NSString *)statusID content:(NSString *)content   shouldComment:(BOOL)commentOriginStatus callbackTarget:(id<AKWeiboManagerDelegate>)target;

/**
 *  评论微博
 *
 *  @param statusID            微博ID
 *  @param comment             评论内容
 *  @param commentOriginStatus 当评论转发微博时，是否评论给原微博，0：否、1：是，默认为0。
 *  @param target              callback
 */
-(void)postCommentOnStatus:(NSString *)statusID comment:(NSString *)comment   shouldCommentOriginStatus:(BOOL)commentOriginStatus callbackTarget:(id<AKWeiboManagerDelegate>)target;
/**
 *  回复评论
 *
 *  @param commentID           评论的ID
 *  @param statusID            评论所属的微博
 *  @param comment             回复内容
 *  @param withoutMention      回复中是否自动加入“回复@用户名”，0：是、1：否，默认为0。
 *  @param commentOriginStatus 当评论转发微博时，是否评论给原微博，0：否、1：是，默认为0。
 *  @param target              callback
 */
-(void)postcommentReply:(NSString *)commentID ofStatus:(NSString *)statusID comment:(NSString *)comment withoutMention:(BOOL)withoutMention shouldCommentOriginStatus:(BOOL)commentOriginStatus callbackTarget:(id<AKWeiboManagerDelegate>)target;


-(void)postFavorite:(NSString *)statusID callbackTarget:(id<AKWeiboManagerDelegate>)target;

-(void)postRemoveFavorite:(NSString *)statusID callbackTarget:(id<AKWeiboManagerDelegate>)target;

#pragma mark - Users

-(void)getFollowingListOfUser:(AKID *)userID callbackTarget:(id<AKWeiboManagerDelegate>)target;

-(void)getFollowerListOfUser:(AKID *)userID callbackTarget:(id<AKWeiboManagerDelegate>)target;

/**
 *  搜索用户
 * 【注意】由于新浪未对外开放用户搜索接口，因此目前只能使用联想搜索功能，搜索范围为：V用户、粉丝500以上的达人、粉丝600以上的普通用户
 *  search/suggestions/users
 *  @param searchQuery 要搜索的内容
 *  @param target      callback
 */
-(void)searchUser:(NSString *)searchQuery callbackTarget:(id<AKWeiboManagerDelegate>)target;

-(void)followUser:(AKID *)userID callbackTarget:(id<AKWeiboManagerDelegate>)target;
-(void)unfollowUser:(AKID *)userID callbackTarget:(id<AKWeiboManagerDelegate>)target;

-(void)checkUnreadForUser:(AKUserProfile *)user callbackTarget:(id<AKWeiboManagerDelegate>)target;
-(void)resetUnreadCountOfType:(AKMessageType)messageType callbackTarget:(id<AKWeiboManagerDelegate>)target;

+(AKWeiboManager *)currentManager;
+(void)setCurrentManager:(AKWeiboManager *)manager;
+(AKError *)getErrorFromResult:(AKParsingObject *)result;
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