//
//  AKUserManager.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-11-1.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKUserManager.h"
#import "NSFileManager+DirectoryLocations.h"

@implementation AKUserManager

//Private static variable for defaultUserManager.
static AKUserManager * _defaultUserManager;

+(AKUserManager *)defaultUserManager{

    
    if(!_defaultUserManager){
        _defaultUserManager = [[AKUserManager alloc]init];
    }
    
    return _defaultUserManager;
}

-(void)createUserProfile:(NSString *)userID withAccessToken:(NSString *)accessToken{

    NSString *applicationSupportDirectory = [[NSFileManager defaultManager]applicationSupportDirectory];
    
    NSString *userAccountDirectory = [NSString stringWithFormat:@"%@%@.account/",applicationSupportDirectory,userID];
    
    NSError *error;
    
    //Create a user account folder.
    BOOL createDirectorySucceed = [[NSFileManager defaultManager]createDirectoryAtPath:userAccountDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    
    if(createDirectorySucceed){
        NSDictionary *userProfileDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:userID, @"UserID", accessToken, @"AccessToken",nil];
        
    }
    

}



@end
