//
//  AKUserManager.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-11-1.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKUserManager.h"
#import "AKAccessTokenObject.h"
#import "NSFileManager+DirectoryLocations.h"
#define CURRENT_ID_CHANGED @"CURRENT_ID_CHANGED"

@implementation AKUserManager{

    NSMutableDictionary *_userProfiles;
    NSMutableDictionary *_userAccessTokens;
    //NSString *currentUserID;

}
@synthesize currentUserID = _currentUserID;
//Private static variable for defaultUserManager.
static AKUserManager * _defaultUserManager;

- (id)init
{
    self = [super init];
    if (self) {
        _userAccessTokens = [[NSMutableDictionary alloc]init];
        _userProfiles = [[NSMutableDictionary alloc]init];
        
        NSArray *accessTokensOnDisk = [self getAllAccessTokenFromDisk];
        for(AKAccessTokenObject *accessTokenObject in accessTokensOnDisk){
        
            [_userAccessTokens setObject:accessTokenObject forKey:accessTokenObject.userID];
            if(!self.currentUserID){
                self.currentUserID = accessTokenObject.userID;
            }
        
        }
        
        NSArray *userProfilesOnDisk = [self getAllUserProfile];
        for(AKUserProfile *userProfile in userProfilesOnDisk){
            
            [_userProfiles setObject:userProfile forKey:userProfile.IDString];
        
            

            
        }
        
        
        
    }
    return self;
}

-(NSString *)currentUserID{
    return _currentUserID;
}

-(void)setCurrentUserID:(NSString *)currentUserID{
    
    
    
    if(!currentUserID || [currentUserID isEqualToString:_currentUserID]){
        return;
    }
    
    _currentUserID = currentUserID;
    //Push current id changed notification;
    NSNotification *notification = [NSNotification notificationWithName:CURRENT_ID_CHANGED object:self userInfo:nil];
    
    [[NSNotificationCenter defaultCenter]postNotification:notification];
    
    

}

-(void)addObserver:(id)observer selector:(SEL)selector{
    
    [[NSNotificationCenter defaultCenter]addObserver:observer selector:selector name:CURRENT_ID_CHANGED object:self];
    
}


+(AKUserManager *)defaultUserManager{

    
    if(!_defaultUserManager){
        _defaultUserManager = [[AKUserManager alloc]init];
    }
    
    return _defaultUserManager;
}

-(AKAccessTokenObject *)currentAccessToken{

    return [_userAccessTokens objectForKey:self.currentUserID];
}

-(AKUserProfile *)currentUserProfile{
    
    return [_userProfiles objectForKey:self.currentUserID];
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

/**
 *  Get all user profile files saved on disk.
 *
 *  @return Pathes of all user profile files saved on disk.
 */
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
    
    NSString *userAccountDirectory = [NSString stringWithFormat:@"%@/%@.account",applicationSupportDirectory,userProfile.IDString];
    NSString *userProfilePath = [userAccountDirectory stringByAppendingString:@"/profile"];
    
    NSError *error;
    
    //Create a user account folder.
    BOOL createDirectorySucceed = [[NSFileManager defaultManager]createDirectoryAtPath:userAccountDirectory withIntermediateDirectories:YES attributes:nil error:&error];

    if(createDirectorySucceed){
        
        [NSKeyedArchiver archiveRootObject:userProfile toFile:userProfilePath];
    
    }

}

-(void)updateUserProfile:(AKUserProfile *)userProfile{

    //保存用户到内存
    [_userProfiles setObject:userProfile forKey:userProfile.IDString];
    //保存用户资料到硬盘
    [self createUserProfile:userProfile];

}

-(void)updateUserAccessToken:(AKAccessTokenObject *)accessTokenObject;{

    [_userAccessTokens setObject:accessTokenObject forKey:accessTokenObject.userID];
    [self saveAccessToken:accessTokenObject];

}


-(NSArray *)allAccessTokens{

    return [_userAccessTokens allValues];

}

-(NSArray *)allUserProfiles{

    return [_userProfiles allValues];

}


/**
 *  Get all Access Token from file
 *
 *  @return A NSArray of AKAccessTokeObject.
 */
-(NSArray *)getAllAccessTokenFromDisk{
    
    NSMutableArray *accessTokenArray = [[NSMutableArray alloc]initWithCapacity:5];
    
    NSString *applicationSupportDirectory = [[NSFileManager defaultManager]applicationSupportDirectory];
    NSDirectoryEnumerator * enumerator = [[NSFileManager defaultManager] enumeratorAtPath:applicationSupportDirectory];
    NSString * file;
    while((file = [enumerator nextObject])){
        
        if([file hasSuffix:@".account"]){
            
            NSString *userAccountDirectory = [NSString stringWithFormat:@"%@/%@",applicationSupportDirectory,file];
            NSString *userProfilePath = [userAccountDirectory stringByAppendingString:@"/access"];
            
            if([[NSFileManager defaultManager] fileExistsAtPath:userProfilePath]){
                
                AKAccessTokenObject *accessToken = [NSKeyedUnarchiver unarchiveObjectWithFile:userProfilePath];
                [accessTokenArray addObject:accessToken];
                
            }
            
        }
        
    }
    
    return accessTokenArray;
    
}

-(AKAccessTokenObject *)getAccessTokenFromFile:(NSString *)userID{
    
    NSString *applicationSupportDirectory = [[NSFileManager defaultManager]applicationSupportDirectory];
    NSString *userAccountDirectory = [NSString stringWithFormat:@"%@/%@.account",applicationSupportDirectory,userID];
    NSString *userProfilePath = [userAccountDirectory stringByAppendingString:@"/access"];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:userAccountDirectory] && [[NSFileManager defaultManager] fileExistsAtPath:userProfilePath]){
        
        return (AKAccessTokenObject *)[NSKeyedUnarchiver unarchiveObjectWithFile:userProfilePath];
        
    }
    
    return nil;
    
}


-(void)saveAccessToken:(AKAccessTokenObject *)accessTokenObject;{
    
    NSString *applicationSupportDirectory = [[NSFileManager defaultManager]applicationSupportDirectory];
    
    NSString *userAccountDirectory = [NSString stringWithFormat:@"%@/%@.account",applicationSupportDirectory,accessTokenObject.userID];
    NSString *userProfilePath = [userAccountDirectory stringByAppendingString:@"/access"];
    
    NSError *error;
    
    //Create a user account folder.
    BOOL createDirectorySucceed = [[NSFileManager defaultManager]createDirectoryAtPath:userAccountDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    
    if(createDirectorySucceed){
        
        [NSKeyedArchiver archiveRootObject:accessTokenObject toFile:userProfilePath];
        
    }
    
}


-(BOOL)isAppUser:(NSString *)userID{

    if(!userID){
        return NO;
    }
    
    NSArray *userIDArray = [_userAccessTokens allKeys];
    for (NSString * item in userIDArray) {
        if([item isEqualToString:userID]){
            return YES;
        }
    }
    
    return NO;

}

-(NSString *)getUserIDByAccessToken:(NSString *)accessToken{


    for(NSString *userID in _userAccessTokens){
    
        AKAccessTokenObject *accessTokenObject =(AKAccessTokenObject *)[_userAccessTokens objectForKey:userID];
        if([ accessTokenObject.accessToken isEqualToString:accessToken]){
        
            return accessTokenObject.userID;
        
        }
    
    }
    return nil;

}

@end
