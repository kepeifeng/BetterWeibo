//
//  AKWeiboRequestQueueItem.h
//  BetterWeibo
//
//  Created by Kent on 13-12-26.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKWeiboManager.h"

@interface AKWeiboRequestQueueItem : NSObject

@property (readonly) NSString * ID;
@property id<AKWeiboManagerDelegate> delegate;

+ (NSString *)generateUUID;

@end
