//
//  AKWeibo.h
//  BetterWeibo
//
//  Created by Kent on 13-10-6.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKWeiboStatus : NSObject

@property NSString * weiboId;
@property NSString * weiboContent;
@property NSString * username;
@property NSString *userAlias;
@property NSDate *date;
@property NSArray *images;
@property NSString *videoURL;
@property NSString *numberOfComments;
@property NSString *numberOfReposts;
@property NSString *numberOfLikes;
//@property BOOL hasRepostedWeibo;
@property AKWeiboStatus *repostedWeibo;

@end
