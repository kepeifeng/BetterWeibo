//
//  AKAccessTokenObject.m
//  BetterWeibo
//
//  Created by Kent on 13-12-10.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKAccessTokenObject.h"

NSString *const AKAccessTokenObjectPropertyNamedAccessToken = @"accessToken";

@implementation AKAccessTokenObject

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
    
        self.userID = [aDecoder decodeObjectForKey:@"userID"];
        self.accessToken = [aDecoder decodeObjectForKey:@"accessToken"];
        self.expireIn = [aDecoder decodeObjectForKey:@"expireIn"];
        self.scope = [aDecoder decodeObjectForKey:@"scope"];
        self.createAt = [aDecoder decodeObjectForKey:@"createAt"];
    
    }
    return self;


}


-(void)encodeWithCoder:(NSCoder *)aCoder{

    [aCoder encodeObject:self.userID forKey:@"userID"];
    [aCoder encodeObject:self.accessToken forKey:@"accessToken"];
    [aCoder encodeObject:self.expireIn forKey:@"expireIn"];
    [aCoder encodeObject:self.scope forKey:@"scope"];
    [aCoder encodeObject:self.createAt forKey:@"createAt"];

}

@end
