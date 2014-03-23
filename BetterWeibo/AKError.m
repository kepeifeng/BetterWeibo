//
//  AKError.m
//  BetterWeibo
//
//  Created by Kent on 14-3-21.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKError.h"

@implementation AKError

-(id)initWithErrorCode:(NSInteger)code error:(NSString *)error request:(NSString *)request;
{
    self = [super init];
    if (self) {
        self.code = code;
        self.error = error;
        self.request = request;
    }
    return self;
}

@end
