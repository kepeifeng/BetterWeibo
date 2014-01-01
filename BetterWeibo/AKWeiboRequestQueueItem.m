//
//  AKWeiboRequestQueueItem.m
//  BetterWeibo
//
//  Created by Kent on 13-12-26.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKWeiboRequestQueueItem.h"

@implementation AKWeiboRequestQueueItem

@synthesize ID = _id;

- (id)init
{
    self = [super init];
    if (self) {
        _id = [AKWeiboRequestQueueItem generateUUID];
    }
    return self;
}

+ (NSString *)generateUUID
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    return (__bridge NSString *)uuidStringRef;
}


@end
