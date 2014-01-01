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
    AKAccessTokenObject *currentAccessToken;
    AKCacheDatabaseManager *cacheManager;
    AKUserManager *userManager;
    NSMutableDictionary * callbackDictionary;

}

@synthesize clientID = _clientID;
@synthesize redirectURL = _redirectURL;
@synthesize appSecret = _appSecret;

static id<AKWeibo> weibo;
static AKWeiboManager * _currentManager;

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
        [userManager addObserver:self selector:@selector(currentUserIDChanged:)];
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
    
    [weibo setAccessToken:accessToken.accessToken];


}

- (void)startOauthLogin {
    
    
    
    //https://api.weibo.com/oauth2/authorize?client_id=YOUR_CLIENT_ID&response_type=code&redirect_uri=YOUR_REGISTERED_REDIRECT_URI
    //https://api.weibo.com/oauth2/access_token?client_id=YOUR_CLIENT_ID&client_secret=YOUR_CLIENT_SECRET&grant_type=authorization_code&redirect_uri=YOUR_REGISTERED_REDIRECT_URI&code=CODE
    
    NSString *authorizeURL =[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&response_type=code&redirect_uri=%@", _clientID, [_redirectURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [[NSWorkspace sharedWorkspace]openURL:[NSURL URLWithString:authorizeURL]];
    
    
    
    //[method oauth2Code:@"84f2dc2b14d64160dd0b39b01d572604" url:redirectURL pTask:nil];
    
    
    
    //    [weibo stopAll];
    //    [weibo shutDown];
}

-(void)setOauth2Code:(NSString *)code{
    
    [weiboMethods oauth2Code:code url:_redirectURL pTask:nil];

}
-(void)currentUserIDChanged:(NSNotification*)notification{

    [weibo setAccessToken:[[userManager currentAccessToken] accessToken]];

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
            
//        case AKUserTimeline:
//            [weiboMethods getStatusesUserTimeline:@"" var:variableParams pTask:nil];
       
        default:
            break;
    }
    

}


-(void)getUserDetail:(NSString *)userID{

    [weiboMethods getUsersShow:[[AKID alloc] initWithIdType:AKIDTypeID text:userID key:nil] extend:nil var:nil pTask:nil];

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
    [weiboMethods getStatusesRepostTimeline:weiboID var:nil pTask:taskInfo];

}




-(BOOL)existUser:(NSString *)userID{
    
    //TODO: implement checking user.
    return NO;
    
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
            NSString * expires_in = [result getSubStringByKey:@"expires_in"];
            NSString * uid = [result getSubStringByKey:@"uid"];
            
            //[self.loginView setHidden:YES];
            
            
//            
//            if(![self existUser:uid ]){
//                
//                [ addObject:userProfile];
//    
//                //create user profile.
//                //[self creatLocalProfileForUser:uid];
//                
//                [[AKUserManager defaultUserManager]createUserProfile:userProfile];
//                
//                
//            }
//            else{
//                
//                for (NSInteger i=0; i<userProfileArray.count; i++) {
//                    if ([[[userProfileArray objectAtIndex:i] IDString] isEqualToString:uid]) {
//                        
//                        [userProfileArray replaceObjectAtIndex:i withObject:userProfile];
//                        break;
//                    }
//                }
//                
//                
//                //Update Access Token in existed profile.
//                [[AKUserManager defaultUserManager]updateUserAccessToken:userProfile];
//                
//                
//            }
            
            //[self getUserDetail:uid];
            
            // Note: Must set acess token to sdk!
            NSLog(@"Access Token = %@", access_token);
            //[theWeibo setAccessToken:access_token];

            
            
        }
    }
    else if (methodOption == AKWBOPT_POST_STATUSES_UPDATE)
    {
        // Send weibo successed!
        // ...
        NSLog(@"Weibo Send.");
    }
    else if (methodOption == AKWBOPT_GET_STATUSES_HOME_TIMELINE || methodOption == AKWBOPT_GET_STATUSES_MENTIONS || methodOption == AKWBOPT_GET_STATUSES_PUBLIC_TIMELINE){

        NSDictionary *resultDictionary = (NSDictionary *)[result getObject];
        NSArray *statusArray = (NSArray *)[resultDictionary objectForKey:@"statuses"];
        NSMutableArray *statusObjectArray = [[NSMutableArray alloc]init];
        for(NSDictionary *status in statusArray){
            
            AKWeiboStatus *statusObject = [AKWeiboStatus getStatusFromDictionary:status];
            [statusObjectArray addObject:statusObject];

        }
        
        [userInfoDictionary setObject:statusObjectArray forKey:@"statuses"];
    
    }
    else if(methodOption == AKWBOPT_GET_FAVORITES){
        
        NSDictionary *resultDictionary = (NSDictionary *)[result getObject];
        NSArray *statusArray = (NSArray *)[resultDictionary objectForKey:@"favorites"];
        NSMutableArray *statusObjectArray = [[NSMutableArray alloc]init];
        for(NSDictionary *status in statusArray){
            
            AKWeiboStatus *statusObject = [AKWeiboStatus getStatusFromDictionary:[status objectForKey:@"status"]];
            [statusObjectArray addObject:statusObject];
            
        }
        
        [userInfoDictionary setObject:statusObjectArray forKey:@"statuses"];
        
    
        
    }
    else if (methodOption == AKWBOPT_GET_USERS_SHOW){
    
        //TODO:Update user profile.
        NSLog(@"User Screename = %@", [result getSubStringByKey:@"screen_name"]);
    
    }
    
    NSNotification *notification = [NSNotification notificationWithName:METHOD_OPTION_NOTIFICATION object:self userInfo:userInfoDictionary];
    
    [[NSNotificationCenter defaultCenter]postNotification:notification];
    


    if (callbackDictionary && [callbackDictionary objectForKey:pTask.taskId]) {
        AKWeiboRequestQueueItem * queueItem = [callbackDictionary objectForKey:pTask.taskId];
        [queueItem.delegate OnDelegateComplete:self methodOption:(AKMethodAction)methodOption httpHeader:httpHeader result:result pTask:pTask];
        [callbackDictionary removeObjectForKey:pTask.taskId];
    }
    
    //[self pushMethodNotification:(AKMethodAction)methodOption httpHeader:httpHeader result:result pTask:pTask];
    
    
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
