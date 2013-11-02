//
//  AKWeibo.h
//  weibosdk
//
//  Created by Kent Peifeng Ke on 13-10-18.
//
//

#import <Foundation/Foundation.h>
#import "AKWeiboDef.h"
#import "AKWeiboMethod.h"
#import "AKParsingObject.h"

@protocol AKWeiboDelegate;

@protocol AKWeibo

-(NSInteger) startUp;
-(NSInteger) shutDown;
-(void)stopAll;

//Options

/**
 *  Set consumer for weibo
 *
 *  @param key    Key
 *  @param secret Secret Key
 */
-(void)setConsumer:(NSString *)key secret:(NSString *)secret;
-(void)setProxy:(AKWeiboProxyType)proxyType server:(NSString *)server port:(NSInteger)port username:(NSString *)username password:(NSString *)password;
-(void)setResponseFormat:(AKWeiboRequestFormat)format;
-(void)setAccessToken:(NSString *)token;
-(void)setLogFile:(NSString *)filepath;
-(id<AKWeiboMethodProtocol>)getMethod;

@property id<AKWeiboDelegate> delegate;


@end

@protocol AKWeiboDelegate

-(void)OnDelegateComplated:(id<AKWeibo>)weibo methodOption:(NSUInteger)methodOption httpHeader:(NSString *)httpHeader result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask;

-(void)OnDelegateErrored:(id<AKWeibo>)weibo methodOption:(NSUInteger)methodOption errCode:(NSInteger)errCode subErrCode:(NSInteger)subErrCode result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask;

-(void)OnDelegateWillRelease:(id<AKWeibo>)weibo methodOption:(NSUInteger)methodOption pTask:(AKUserTaskInfo *)pTask;

@end


