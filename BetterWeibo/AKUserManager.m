//
//  AKUserManager.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-11-1.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKUserManager.h"
#import "NSFileManager+DirectoryLocations.h"

@implementation AKUserManager{

    NSMutableArray *_userProfiles;

}

//Private static variable for defaultUserManager.
static AKUserManager * _defaultUserManager;

+(AKUserManager *)defaultUserManager{

    
    if(!_defaultUserManager){
        _defaultUserManager = [[AKUserManager alloc]init];
    }
    
    return _defaultUserManager;
}

-(BOOL)hasUserExisted{

    //~/Library/Application Support/BetterWeibo
    NSString *applicationSupportDirectory = [[NSFileManager defaultManager]applicationSupportDirectory];
    NSDirectoryEnumerator * enumerator = [[NSFileManager defaultManager] enumeratorAtPath:applicationSupportDirectory];
    NSString * file;
    while((file = [enumerator nextObject])){
    
        if([file hasSuffix:@".account"]){
        
            return YES;
            
        }
    
    }
    
    return false;
    

}

-(NSArray *)getAllUserProfile{

    NSMutableArray *userProfileArray = [[NSMutableArray alloc]initWithCapacity:5];
    
    NSString *applicationSupportDirectory = [[NSFileManager defaultManager]applicationSupportDirectory];
    NSDirectoryEnumerator * enumerator = [[NSFileManager defaultManager] enumeratorAtPath:applicationSupportDirectory];
    NSString * file;
    while((file = [enumerator nextObject])){
        
        if([file hasSuffix:@".account"]){
            
            NSString *userAccountDirectory = [NSString stringWithFormat:@"%@/%@",applicationSupportDirectory,file];
            NSString *userProfilePath = [userAccountDirectory stringByAppendingString:@"/profile"];
            
            if([[NSFileManager defaultManager] fileExistsAtPath:userProfilePath]){
            
                AKUserProfile *userProfile = [NSKeyedUnarchiver unarchiveObjectWithFile:userProfilePath];
                [userProfileArray addObject:userProfile];
            
            }
            
        }
        
    }
    
    return userProfileArray;

}

-(AKUserProfile *)loadUserProfile:(NSString *)userID{

    NSString *applicationSupportDirectory = [[NSFileManager defaultManager]applicationSupportDirectory];
    NSString *userAccountDirectory = [NSString stringWithFormat:@"%@/%@.account",applicationSupportDirectory,userID];
    NSString *userProfilePath = [userAccountDirectory stringByAppendingString:@"/profile"];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:userAccountDirectory] && [[NSFileManager defaultManager] fileExistsAtPath:userProfilePath]){
    
        return [NSKeyedUnarchiver unarchiveObjectWithFile:userProfilePath];
    
    }
    
    return nil;

}

-(void)createUserProfile:(AKUserProfile *)userProfile;{

    NSString *applicationSupportDirectory = [[NSFileManager defaultManager]applicationSupportDirectory];
    
    NSString *userAccountDirectory = [NSString stringWithFormat:@"%@/%@.account",applicationSupportDirectory,userProfile.userID];
    NSString *userProfilePath = [userAccountDirectory stringByAppendingString:@"/profile"];
    
    NSError *error;
    
    //Create a user account folder.
    BOOL createDirectorySucceed = [[NSFileManager defaultManager]createDirectoryAtPath:userAccountDirectory withIntermediateDirectories:YES attributes:nil error:&error];

    if(createDirectorySucceed){
        
        [NSKeyedArchiver archiveRootObject:userProfile toFile:userProfilePath];
    
    }
        
    
    
    

}

-(void)updateUserAccessToken:(AKUserProfile *)userProfile;{


}



@end
