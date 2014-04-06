//
//  AKWeiboManager.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-11-2.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKWeiboManager.h"
#import "AKWeiboFactory.h"
#import "AKCacheDatabaseManager.h"
#import "AKUserManager.h"
#import "AKWeiboRequestQueueItem.h"

@implementation AKWeiboManager{

    BOOL logined;
    id<AKWeiboMethodProtocol> weiboMethods;
    NSMutableArray *userProfileArray;
    AKAccessTokenObject *_currentAccessToken;
    AKCacheDatabaseManager *cacheManager;
    AKUserManager *userManager;
    NSMutableDictionary * callbackDictionary;
    
    NSMutableArray *_observedObjects;

}

@synthesize clientID = _clientID;
@synthesize redirectURL = _redirectURL;
@synthesize appSecret = _appSecret;

static id<AKWeibo> weibo;
static AKWeiboManager * _currentManager;

-(void)dealloc{

    for(AKAccessTokenObject *accessTokenObject in _observedObjects){
        [accessTokenObject removeObserver:self forKeyPath:AKAccessTokenObjectPropertyNamedAccessToken];
    }
    
}


-(id)initWithClientID:(NSString *)clientID appSecret:(NSString *)appSecret redirectURL:(NSString *)redirectURL{

    self = [super init];
    if(self){
    
        
        _clientID = clientID;
        _appSecret = appSecret;
        _redirectURL = redirectURL;
        
        if(!weibo){
        
            weibo = [AKWeiboFactory getWeibo];
            
            [weibo setDelegate:self];
            [weibo startUp];
            [weibo setConsumer:_clientID secret:_appSecret];
        }
        
        weiboMethods = [weibo getMethod];
        
        callbackDictionary = [NSMutableDictionary new];
        cacheManager = [[AKCacheDatabaseManager alloc]init];
        userManager = [AKUserManager defaultUserManager];
        [userManager addListener:self];
        if(userManager.currentUserID){
        
            [self setAccessToken:[userManager currentAccessToken]];
        
        }

    
    }
    
    return self;
    
}
+(AKWeiboManager *)currentManager{

    return _currentManager;
    
}
+(void)setCurrentManager:(AKWeiboManager *)manager{
    _currentManager = manager;
}


-(void)setupWeibo{
    

}

-(void)setAccessToken:(AKAccessTokenObject *)accessToken{
    
    _currentAccessToken = accessToken;
    [weibo setAccessToken:accessToken.accessToken];


}

- (void)startOauthLogin {
    
    
    
    //https://api.weibo.com/oauth2/authorize?client_id=YOUR_CLIENT_ID&response_type=code&redirect_uri=YOUR_REGISTERED_REDIRECT_URI
    //https://api.weibo.com/oauth2/access_token?client_id=YOUR_CLIENT_ID&client_secret=YOUR_CLIENT_SECRET&grant_type=authorization_code&redirect_uri=YOUR_REGISTERED_REDIRECT_URI&code=CODE
    
    NSString *authorizeURL =[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?diplay=client&forcelogin=true&client_id=%@&response_type=code&redirect_uri=%@", _clientID, [_redirectURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [[NSWorkspace sharedWorkspace]openURL:[NSURL URLWithString:authorizeURL]];

}

-(void)setOauth2Code:(NSString *)code{
    
    [weiboMethods oauth2Code:code url:_redirectURL pTask:nil];

}
//-(void)currentUserIDChanged:(NSNotification*)notification{

//    if(!_observedObjects){
//        _observedObjects = [NSMutableArray new];
//    }
//    AKAccessTokenObject *accessTokenObject = [userManager currentAccessToken];
//    if(![_observedObjects containsObject:accessTokenObject]){
//        [accessTokenObject addObserver:self forKeyPath:AKAccessTokenObjectPropertyNamedAccessToken options:0 context:NULL];
//        [_observedObjects addObject:accessTokenObject];
//    }

//    [self setAccessToken:accessTokenObject];

//}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if([keyPath isEqualToString:AKAccessTokenObjectPropertyNamedAccessToken]){
        AKAccessTokenObject *accessTokenObject = object;
        if ([userManager currentAccessToken] == accessTokenObject) {
            [self setAccessToken:accessTokenObject];
        }
        
    }

}

-(void)pushMethodNotification:(AKMethodAction)methodOption httpHeader:(NSString *)httpHeader result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask{

    NSMutableDictionary *userInfoDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[[AKMethodActionObject alloc] initWithMethodAction:methodOption],@"methodOption", nil];
    
    if(httpHeader){

        [userInfoDictionary setObject:httpHeader forKey:@"httpHeader"];
    }
    
    if(result){
        [userInfoDictionary setObject:result forKey:@"result"];
    }
    
    if(pTask){
        [userInfoDictionary setObject:pTask forKey:@"task"];
    }

    
    NSNotification *notification = [NSNotification notificationWithName:METHOD_OPTION_NOTIFICATION object:self userInfo:userInfoDictionary];
    
    [[NSNotificationCenter defaultCenter]postNotification:notification];

}


-(void)addMethodActionObserver:(id)observer selector:(SEL)selector{

    [[NSNotificationCenter defaultCenter]addObserver:observer selector:selector name:METHOD_OPTION_NOTIFICATION object:self];

}

-(void)getStatus{

    [weiboMethods getStatusesHomeTimeline:nil pTask:nil];

}

-(void)getStatusForUser:(NSString *)userID sinceWeiboID:(NSString *)sinceWeiboID maxWeiboID:(NSString *)maxWeiboID count:(int)count page:(int)page baseApp:(BOOL)baseApp feature:(int)feature trimUser:(int)trimUser timelineType:(AKWeiboTimelineType)timelineType{

    NSLog(@"正在获取微博...");
    AKVariableParams *variableParams = [[AKVariableParams alloc]init];
    
    variableParams.since_id = [sinceWeiboID longLongValue];
    variableParams.max_id = [maxWeiboID longLongValue];
    variableParams.count = count;
    variableParams.page = page;
    variableParams.base_app = baseApp;
    variableParams.feature = feature;
    variableParams.trim_user = trimUser;
    
    
    switch (timelineType) {
        case AKFriendsTimeline:
            [weiboMethods getStatusesHomeTimeline:variableParams pTask:nil];
            break;
            
        case AKMentionTimeline:
            [weiboMethods getStatusesMentions:variableParams pTask:nil];
            break;
            
        case AKFavoriteTimeline:
            [weiboMethods getFavorites:variableParams pTask:nil];
            break;
       
        case AKPublicTimeline:
            [weiboMethods getStatusesPublicTimeline:variableParams pTask:nil];
            break;
            
        case AKUserTimeline:
            AKID *userIDObject = [[AKID alloc]initWithIdType:AKIDTypeID text:userID key:@""];
            [weiboMethods getStatusesUserTimeline:userIDObject var:variableParams pTask:nil];
            break;
            
    }
    

}

-(void)getStatusForUser:(AKID *)userID sinceWeiboID:(NSString *)sinceWeiboID maxWeiboID:(NSString *)maxWeiboID count:(int)count page:(int)page baseApp:(BOOL)baseApp feature:(int)feature trimUser:(int)trimUser timelineType:(AKWeiboTimelineType)timelineType callbackTarget:(id<AKWeiboManagerDelegate>)target{

    
    NSLog(@"正在获取微博...");
    AKVariableParams *variableParams = [[AKVariableParams alloc]init];
    
    variableParams.since_id = (sinceWeiboID)?[sinceWeiboID longLongValue]:0;
    variableParams.max_id = (maxWeiboID)?[maxWeiboID longLongValue]:0;
    variableParams.count = count;
    variableParams.page = page;
    variableParams.base_app = baseApp;
    variableParams.feature = feature;
    variableParams.trim_user = trimUser;
    
    AKUserTaskInfo *task = [self newTask:target];
    
    switch (timelineType) {
        case AKFriendsTimeline:
            [weiboMethods getStatusesHomeTimeline:variableParams pTask:task];
            break;
            
        case AKMentionTimeline:
            [weiboMethods getStatusesMentions:variableParams pTask:task];
            break;
            
        case AKFavoriteTimeline:
            [weiboMethods getFavorites:variableParams pTask:task];
            break;
            
        case AKPublicTimeline:
            [weiboMethods getStatusesPublicTimeline:variableParams pTask:task];
            break;
            
        case AKUserTimeline:
            
            [weiboMethods getStatusesUserTimeline:userID var:variableParams pTask:task];
            break;
            
    }


}

-(void)postStatus:(NSString *)status forUser:(AKUserProfile *)user callbackTarget:(id<AKWeiboManagerDelegate>)target{

    AKUserTaskInfo *taskInfo = [self newTask:target];
    AKVariableParams *params = [AKVariableParams new];
    params.accessToken = [[[AKUserManager defaultUserManager] getAccessTokenByUserID:user.IDString] accessToken];
    [weiboMethods postStatusesUpdate:status var:params pTask:taskInfo];

}
-(void)postStatus:(NSString *)status withImages:(NSArray *)images forUser:(AKUserProfile *)user callbackTarget:(id<AKWeiboManagerDelegate>)target{

    AKUserTaskInfo *taskInfo = [self newTask:target];
    AKVariableParams *params = [AKVariableParams new];
    params.accessToken = [[[AKUserManager defaultUserManager] getAccessTokenByUserID:user.IDString] accessToken];
    if(!images || images.count==0){
        [weiboMethods postStatusesUpdate:status var:params pTask:taskInfo];
    }
    [weiboMethods postStatusesUpload:status filePath:images var:params pTask:taskInfo];

}


-(void)postFavorite:(NSString *)statusID callbackTarget:(id<AKWeiboManagerDelegate>)target{
    
    AKUserTaskInfo *taskInfo = [self newTask:target];
    [weiboMethods postFavoritesCreate:statusID var:nil pTask:taskInfo];

}


-(void)postRemoveFavorite:(NSString *)statusID callbackTarget:(id<AKWeiboManagerDelegate>)target{
    
    AKUserTaskInfo *taskInfo = [self newTask:target];
    [weiboMethods postFavoritesDestroy:statusID var:nil pTask:taskInfo];

}


-(void)getUserDetail:(NSString *)userID{

    [weiboMethods getUsersShow:[[AKID alloc] initWithIdType:AKIDTypeID text:userID key:nil] extend:nil var:nil pTask:nil];

}

-(void)getUserDetail:(AKID *)userID callbackTarget:(id<AKWeiboManagerDelegate>)target{

    AKUserTaskInfo *task = [self newTask:target];
    [weiboMethods getUsersShow:userID extend:nil var:nil pTask:task];

}

//-(void)addUser:(AKAccessTokenObject *)accessTokenObject{
//
//    //[userProfileArray addObject:accessTokenObject];
//    
//    if(!currentAccessToken){
//    
//        [weibo setAccessToken:accessTokenObject.accessToken];
//        
//        currentAccessToken = accessTokenObject;
//    }
//
//}

-(BOOL)userExist:(NSString *)userID{

    for(AKUserProfile *userProfile in userProfileArray){
    
        if ([userProfile.IDString isEqualToString:userID]) {
            return YES;
        }
        
    }
    return NO;

}

//-(NSArray *)users{
//
//    return userProfileArray;
//
//}


-(AKUserTaskInfo *)newTask:(id<AKWeiboManagerDelegate>)callbackTarget{

    AKWeiboRequestQueueItem *queueItem = [AKWeiboRequestQueueItem new];
    queueItem.delegate = callbackTarget;
    
    AKUserTaskInfo *userTaskInfo = [AKUserTaskInfo new];
    userTaskInfo.taskId = queueItem.ID;
    
    [callbackDictionary setObject:queueItem forKey:queueItem.ID];
    
    return userTaskInfo;
}

-(void)getStatusComment:(NSString *)weiboID callbackTarget:(id<AKWeiboManagerDelegate>)target{
    
    AKUserTaskInfo *taskInfo = [self newTask:target];
    [weiboMethods getCommentsShow:weiboID var:nil pTask:taskInfo];
    
}

-(void)getStatusRepost:(NSString *)weiboID callbackTarget:(id<AKWeiboManagerDelegate>)target{

    
    AKUserTaskInfo *taskInfo = [self newTask:target];
    AKVariableParams *params = [AKVariableParams new];
    params.filter_by_source = 1;
    [weiboMethods getStatusesRepostTimeline:weiboID var:nil pTask:taskInfo];

}



/**
 *  转发一条微博
 *
 *  @param statusID            要转发的微博ID。
 *  @param content             添加的转发文本，必须做URLencode，内容不超过140个汉字，不填则默认为“转发微博”。
 *  @param commentOriginStatus 是否在转发的同时发表评论，0：否、1：评论给当前微博、2：评论给原微博、3：都评论，默认为0 。
 *  @param target              callback
 */
-(void)postRepostStatus:(NSString *)statusID content:(NSString *)content   shouldComment:(BOOL)commentOriginStatus callbackTarget:(id<AKWeiboManagerDelegate>)target{
    
    AKUserTaskInfo *taskInfo = [self newTask:target];
    [weiboMethods postStatusesRepost:statusID statusText:content isComment:commentOriginStatus var:nil pTask:taskInfo];
    
}

/**
 *  评论微博
 *
 *  @param statusID            微博ID
 *  @param comment             评论内容
 *  @param commentOriginStatus 当评论转发微博时，是否评论给原微博，0：否、1：是，默认为0。
 *  @param target              callback
 */
-(void)postCommentOnStatus:(NSString *)statusID comment:(NSString *)comment   shouldCommentOriginStatus:(BOOL)commentOriginStatus callbackTarget:(id<AKWeiboManagerDelegate>)target{

    AKUserTaskInfo *taskInfo = [self newTask:target];
    [weiboMethods postCommentsCreate:statusID comment:comment commentOri:commentOriginStatus var:nil pTask:taskInfo];

}
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
-(void)postcommentReply:(NSString *)commentID ofStatus:(NSString *)statusID comment:(NSString *)comment withoutMention:(BOOL)withoutMention shouldCommentOriginStatus:(BOOL)commentOriginStatus callbackTarget:(id<AKWeiboManagerDelegate>)target{

    AKUserTaskInfo *taskInfo = [self newTask:target];
    [weiboMethods postCommentsReply:commentID comment:comment weiboId:statusID withoutMention:withoutMention commentOri:commentOriginStatus var:nil pTask:taskInfo];

}


#pragma mark - Users

-(void)getFollowingListOfUser:(AKID *)userID callbackTarget:(id<AKWeiboManagerDelegate>)target{

    AKUserTaskInfo *taskInfo = [self newTask:target];
    [weiboMethods getFriendshipsFriends:userID order:0 var:nil pTask:taskInfo];

}

-(void)getFollowerListOfUser:(AKID *)userID callbackTarget:(id<AKWeiboManagerDelegate>)target{
    
    AKUserTaskInfo *taskInfo = [self newTask:target];
    [weiboMethods getFriendshipsFriendsFollowers:userID var:nil pTask:taskInfo];

}

/**
 *  搜索用户
 * 【注意】由于新浪未对外开放用户搜索接口，因此目前只能使用联想搜索功能，搜索范围为：V用户、粉丝500以上的达人、粉丝600以上的普通用户
 *  search/suggestions/users
 *  @param searchQuery 要搜索的内容
 *  @param target      callback
 */
-(void)searchUser:(NSString *)searchQuery callbackTarget:(id<AKWeiboManagerDelegate>)target{

    AKUserTaskInfo *taskInfo = [self newTask:target];
    [weiboMethods getSearchSuggestionsUsers:searchQuery count:200 pTask:taskInfo];

}

-(void)followUser:(AKID *)userID callbackTarget:(id<AKWeiboManagerDelegate>)target{
    
    AKUserTaskInfo *taskInfo = [self newTask:target];
    [weiboMethods postFriendshipsCreate:userID skipCheck:0 var:nil pTask:taskInfo];
    
}

-(void)unfollowUser:(AKID *)userID callbackTarget:(id<AKWeiboManagerDelegate>)target{
    
    AKUserTaskInfo *taskInfo = [self newTask:target];
    [weiboMethods postFriendshipsDestroy:userID var:nil pTask:taskInfo];
    
}


-(BOOL)existUser:(NSString *)userID{
    
    //TODO: implement checking user.
    return NO;
    
}



-(void)checkUnreadForUser:(AKUserProfile *)user callbackTarget:(id<AKWeiboManagerDelegate>)target{

    AKUserTaskInfo *taskInfo = [self newTask:target];
    taskInfo.userData = (__bridge void *)user;
    AKVariableParams *params = [AKVariableParams new];
    params.accessToken = [[[AKUserManager defaultUserManager] getAccessTokenByUserID:user.IDString] accessToken];
//    [weiboMethods getRemindUnreadCount:user.IDString pTask:taskInfo];
    [weiboMethods getRemindUnreadCount:user.IDString var:params pTask:taskInfo];
    

}

-(void)resetUnreadCountOfType:(AKMessageType)messageType callbackTarget:(id<AKWeiboManagerDelegate>)target{
    
//    NSString *unreadTypeString = [self getSetCountTypeStringOfMessageType:messageType];
    
    
}


#pragma mark - Weibo Delegate

-(void)OnDelegateCompleted:(id<AKWeibo>)theWeibo methodOption:(NSUInteger)methodOption httpHeader:(NSString *)httpHeader result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask{
    
    [cacheManager insertData:result.originData appKey:self.clientID accessToken:theWeibo.accessToken];
    
    NSMutableDictionary *userInfoDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[[AKMethodActionObject alloc] initWithMethodAction:(AKMethodAction)methodOption],@"methodOption", nil];
    
    if(httpHeader){
        
        [userInfoDictionary setObject:httpHeader forKey:@"httpHeader"];
    }
    
    if(result){
        [userInfoDictionary setObject:result forKey:@"result"];
    }
    
    if(pTask){
        [userInfoDictionary setObject:pTask forKey:@"task"];
    }
    

   
    if (methodOption == AKWBOPT_OAUTH2_ACCESS_TOKEN)
    {
        if (result.isUseable)
        {
            logined = TRUE;
            /*
             access_token	string	用于调用access_token，接口获取授权后的access token。
             expires_in     string	access_token的生命周期，单位是秒数。
             remind_in      string	access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
             uid            string	当前授权用户的UID。
             */
            NSString * access_token = [result getSubStringByKey:@"access_token"];

            // Note: Must set acess token to sdk!
            NSLog(@"Access Token = %@", access_token);
            
        }
    }
    else if (methodOption == AKWBOPT_POST_STATUSES_UPDATE)
    {
        // Send weibo successed!
        // ...
        NSLog(@"Weibo Send.");
    }
    else if (methodOption == AKWBOPT_GET_USERS_SHOW){
    
        //TODO:Update user profile.
        NSLog(@"User Screename = %@", [result getSubStringByKey:@"screen_name"]);
    
    }
    
    //广播（勿移除）
    NSNotification *notification = [NSNotification notificationWithName:METHOD_OPTION_NOTIFICATION object:self userInfo:userInfoDictionary];
    
    [[NSNotificationCenter defaultCenter]postNotification:notification];
    

    AKError *error = [AKWeiboManager getErrorFromResult:result];
    //Callback
    if (callbackDictionary && [callbackDictionary objectForKey:pTask.taskId]) {
        AKWeiboRequestQueueItem * queueItem = [callbackDictionary objectForKey:pTask.taskId];
        
        if(!error){
            [queueItem.delegate OnDelegateComplete:self methodOption:(AKMethodAction)methodOption httpHeader:httpHeader result:result pTask:pTask];
        }else{
            [queueItem.delegate OnDelegateErrored:self methodOption:(AKMethodAction)methodOption error:error result:result pTask:pTask];
        }
        
        [callbackDictionary removeObjectForKey:pTask.taskId];
    }
    
    
    
    
}



-(void)OnDelegateErrored:(id<AKWeibo>)theWeibo methodOption:(NSUInteger)methodOption errCode:(NSInteger)errCode subErrCode:(NSInteger)subErrCode result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask{
    
    // Please reference http://open.weibo.com/wiki/Help/error
    if (methodOption == AKWBOPT_OAUTH2_ACCESS_TOKEN)
    {
        if (result && result.isUseable)
        {
            
            NSString * error_code = [result getSubStringByKey:@"error_code"];
            NSString * request = [result getSubStringByKey:@"request"];
            NSString * error = [result getSubStringByKey:@"error"];
            
            NSLog(@"ERROR_CODE = %@\nREQUEST = %@\nERROR = %@",error_code, request, error);
        }
    }
    else if (methodOption == AKWBOPT_POST_STATUSES_UPDATE)
    {
        // Send weibo failed!
        // ...
        NSLog(@"Send weibo failed.");
    }
    
    
    
}

-(void)OnDelegateWillRelease:(id<AKWeibo>)theWeibo methodOption:(NSUInteger)methodOption pTask:(AKUserTaskInfo *)pTask{
    
    
    
}


#pragma mark - Public Static Mehtods

+(AKError *)getErrorFromResult:(AKParsingObject *)result{
    
    //Check Error
    NSObject *object = [result getObject];
    if([object isKindOfClass:[NSDictionary class]] && [(NSDictionary *)object objectForKey:@"error"]){
        NSDictionary *errorDictionary = (NSDictionary *)object;
        AKError *error = [[AKError alloc] initWithErrorCode:[(NSString *)[errorDictionary objectForKey:@"error_code"] integerValue]
                                                      error:[errorDictionary objectForKey:@"error"]
                                                    request:[errorDictionary objectForKey:@"request"]];
        return error;
        
    }
    
    return nil;

}

+(AKAccessTokenObject *)getAccessTokenFromParsingObject:(AKParsingObject *)object{
    
    /*
     access_token	string	用于调用access_token，接口获取授权后的access token。
     expires_in     string	access_token的生命周期，单位是秒数。
     remind_in      string	access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
     uid            string	当前授权用户的UID。
     */
    NSDictionary *result = (NSDictionary *)[object getObject];
//    
//    NSString * access_token = [object getSubStringByKey:@"access_token"];
//    NSString * expires_in = [object getSubStringByKey:@"expires_in"];
//    NSString * uid = [object getSubStringByKey:@"uid"];
//    
//    //[self.loginView setHidden:YES];

    AKAccessTokenObject *accessToken = [[AKAccessTokenObject alloc]init];
    accessToken.userID = [result objectForKey:@"uid"];
    accessToken.accessToken = [result objectForKey:@"access_token"];
    accessToken.expireIn = [result objectForKey:@"expires_in"];
//    
//    AKUserProfile *userProfile = [[AKUserProfile alloc]init];
//    userProfile.IDString = uid;
//    userProfile.accessToken = access_token;
//    userProfile.accessTokenExpiresIn = expires_in;
//    
    
    return accessToken;

}

#pragma mark - User Manager Listener

//-(void)userProfileDidInserted:(AKUserProfile *)userProfile atIndex:(NSInteger)index{
//
//    
//}

-(void)accessTokenDidUpdated:(AKUserProfile *)userProfile accessToken:(AKAccessTokenObject *)accessToken{


    if (userProfile != nil && [userManager currentUserProfile] == userProfile) {
        [self setAccessToken:accessToken];
    }

}

-(void)currentUserDidChanged{
    
    if([userManager currentAccessToken]){
    
        [self setAccessToken:[userManager currentAccessToken]];
    }

}


@end





//Implemetation of AKMethodActionObject

@implementation AKMethodActionObject

@synthesize methodAction = _methodAction;

-(id)initWithMethodAction:(AKMethodAction)methodAction{
    
    self = [super init];
    if(self){
    
        self.methodAction = methodAction;
    
    }
    
    return self;

}

@end
