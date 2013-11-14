//
//  AKWeiboManager.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-11-2.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKWeiboManager.h"
#import "AKWeiboFactory.h"


@implementation AKWeiboManager{


    BOOL logined;
    id<AKWeiboMethodProtocol> weiboMethods;
    NSMutableArray *userProfileArray;
    AKUserProfile *currentUserProfile;


}

@synthesize clientID = _clientID;
@synthesize redirectURL = _redirectURL;
@synthesize appSecret = _appSecret;

static id<AKWeibo> weibo;

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
        


    
    }
    
    return self;
    
}

-(void)setupWeibo{
    

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

-(void)getUserDetail:(NSString *)userID{

    [weiboMethods getUsersShow:[[AKID alloc] initWithIdType:AKIDTypeID text:userID key:nil] extend:nil var:nil pTask:nil];

}

-(void)addUser:(AKUserProfile *)userProfile{

    [userProfileArray addObject:userProfile];
    
    if(!currentUserProfile){
    
        [weibo setAccessToken:userProfile.accessToken];
        
        currentUserProfile = userProfile;
    }
    
    
    

}



#pragma mark - Weibo Delegate

-(void)OnDelegateComplated:(id<AKWeibo>)theWeibo methodOption:(NSUInteger)methodOption httpHeader:(NSString *)httpHeader result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask{
    
    if (methodOption == WBOPT_OAUTH2_ACCESS_TOKEN)
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
            
            AKUserProfile *userProfile = [AKWeiboManager getUserProfileFromParsingObject:result];
            
            
            if(![self existUser:uid ]){
                
                [userProfileArray addObject:userProfile];
    
                //create user profile.
                //[self creatLocalProfileForUser:uid];
                
                [[AKUserManager defaultUserManager]createUserProfile:userProfile];
                
                
            }
            else{
                
                for (NSInteger i=0; i<userProfileArray.count; i++) {
                    if ([[[userProfileArray objectAtIndex:i] userID] isEqualToString:uid]) {
                        
                        [userProfileArray replaceObjectAtIndex:i withObject:userProfile];
                        break;
                    }
                }
                
                
                //Update Access Token in existed profile.
                [[AKUserManager defaultUserManager]updateUserAccessToken:userProfile];
                
                
            }
            
            //[self getUserDetail:uid];
            
            // Note: Must set acess token to sdk!
            NSLog(@"Access Token = %@", access_token);
            [theWeibo setAccessToken:access_token];
            
            
            
            //Create UI Components for the user
            
            //switch to Status page.
            
            /*
            Tab controllers SHOULD do the following stuff:
            - Get Status from cache database
            - if there is no status in the cache database, get latest status.
            - Otherwise, put Status on screen, and check the number of new Status.
            */
            
            
        }
    }
    else if (methodOption == WBOPT_POST_STATUSES_UPDATE)
    {
        // Send weibo successed!
        // ...
        NSLog(@"Weibo Send.");
    }
    else if (methodOption == WBOPT_GET_STATUSES_HOME_TIMELINE){
        
        NSLog(@"WBOPT_GET_STATUSES_HOME_TIMELINE");
        
    
    
    }
    else if (methodOption == WBOPT_GET_USERS_SHOW){
    
    
        NSLog(@"User Screename = %@", [result getSubStringByKey:@"screen_name"]);
    
    }
    
    
    [self pushMethodNotification:(AKMethodAction)methodOption httpHeader:httpHeader result:result pTask:pTask];
    
    
}


-(BOOL)existUser:(NSString *)userID{
    
    //TODO: implement checking user.
    return NO;
    
}

-(void)OnDelegateErrored:(id<AKWeibo>)theWeibo methodOption:(NSUInteger)methodOption errCode:(NSInteger)errCode subErrCode:(NSInteger)subErrCode result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask{
    
    // Please reference http://open.weibo.com/wiki/Help/error
    if (methodOption == WBOPT_OAUTH2_ACCESS_TOKEN)
    {
        if (result && result.isUseable)
        {
            
            NSString * error_code = [result getSubStringByKey:@"error_code"];
            NSString * request = [result getSubStringByKey:@"request"];
            NSString * error = [result getSubStringByKey:@"error"];
            
            NSLog(@"ERROR_CODE = %@\nREQUEST = %@\nERROR = %@",error_code, request, error);
        }
    }
    else if (methodOption == WBOPT_POST_STATUSES_UPDATE)
    {
        // Send weibo failed!
        // ...
        NSLog(@"Send weibo failed.");
    }
    
    
    
}

-(void)OnDelegateWillRelease:(id<AKWeibo>)theWeibo methodOption:(NSUInteger)methodOption pTask:(AKUserTaskInfo *)pTask{
    
    
    
}


#pragma mark - Public Static Mehtods

+(AKUserProfile *)getUserProfileFromParsingObject:(AKParsingObject *)object{
    
    /*
     access_token	string	用于调用access_token，接口获取授权后的access token。
     expires_in     string	access_token的生命周期，单位是秒数。
     remind_in      string	access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
     uid            string	当前授权用户的UID。
     */
    NSString * access_token = [object getSubStringByKey:@"access_token"];
    NSString * expires_in = [object getSubStringByKey:@"expires_in"];
    NSString * uid = [object getSubStringByKey:@"uid"];
    
    //[self.loginView setHidden:YES];
    
    AKUserProfile *userProfile = [[AKUserProfile alloc]init];
    userProfile.userID = uid;
    userProfile.accessToken = access_token;
    userProfile.accessTokenExpiresIn = expires_in;
    
    
    return userProfile;

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
