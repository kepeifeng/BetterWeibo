//
//  AKUserProfile.m
//  BetterWeibo
//
//  Created by Kent on 13-11-10.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKUserProfile.h"

@implementation AKUserProfile

-(id)initWithCoder:(NSCoder *)aDecoder{

    self = [super init];
    if(self){
    
        self.userID = [aDecoder decodeObjectForKey:@"userID"];
        self.accessToken = [aDecoder decodeObjectForKey:@"accessToken"];
    
    
    }
    
    return self;

}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    
    [aCoder encodeObject:self.userID forKey:@"userID"];
    [aCoder encodeObject:self.accessToken forKey:@"accessToken"];

}

@end
