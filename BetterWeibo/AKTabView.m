//
//  AKTabView.m
//  BetterWeibo
//
//  Created by Kent on 13-11-5.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKTabView.h"

@implementation AKTabView


-(void)addUser:(AKUserProfile *)userProfile{

    [self.tabControl addControlGroup:userProfile];
    
    
}

-(BOOL)isUserExist:(NSString *)userID{

    return [self.tabControl isUserExist:userID];

}

@end
