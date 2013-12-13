//
//  AKCacheDatabaseManager.h
//  BetterWeibo
//
//  Created by Kent on 13-11-2.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKCacheDatabaseManager : NSObject

-(BOOL)insertData:(NSData *)data appKey:(NSString *)appKey accessToken:(NSString *)accessToken;
-(void)insertStatuses:(NSArray *)statuses withUserID:(NSString *)userID;

@end
