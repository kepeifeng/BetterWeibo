//
//  AKError.h
//  BetterWeibo
//
//  Created by Kent on 14-3-21.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//
/*
 
 错误代码说明
 http://open.weibo.com/wiki/Error_code
 
 */

#import <Foundation/Foundation.h>

@interface AKError : NSObject

-(id)initWithErrorCode:(NSInteger)code error:(NSString *)error request:(NSString *)request;

@property NSInteger code;
@property NSString *error;
@property NSString *request;

@end
