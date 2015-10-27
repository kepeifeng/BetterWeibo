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
    NSMutableArray *_listeners;

}
@synthesize currentUserID = _currentUserID;
//Private static variable for defaultUserManager.


- (id)init
{
    self = [super init];
    if (self) {
        _userAccessTokens = [[NSMutableDictionary alloc]init];
        _userProfiles = [[NSMutableDictionary alloc]init];
        
                
        _listeners = [NSMutableArray new];
        
        
        
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
//    NSNotification *notification = [NSNotification notificationWithName:CURRENT_ID_CHANGED object:self userInfo:nil];
//    
//    [[NSNotificationCenter defaultCenter]postNotification:notification];
    
    for (id<AKUserManagerListenerProtocol> listener in _listeners) {
        if(![listener respondsToSelector:@selector(currentUserDidChanged)]){
            continue;
        }
        [listener currentUserDidChanged];
    }

}

-(NSUInteger)numberOfUser{
    return [_userProfiles count];
}

-(void)addObserver:(id)observer selector:(SEL)selector{
    
    [[NSNotificationCenter defaultCenter]addObserver:observer selector:selector name:CURRENT_ID_CHANGED object:self];
    
}


+(AKUserManager *)defaultUserManager{

    static AKUserManager * _defaultUserManager;
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
-(NSArray *)getAllUserProfileFromDisk{

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

-(void)saveUserProfileToDisk:(AKUserProfile *)userProfile;{

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

-(void)addUserProfile:(AKUserProfile *)userProfile{
    
    [_userProfiles setObject:userProfile forKey:userProfile.IDString];
    
    for (id<AKUserManagerListenerProtocol> listener in _listeners) {
        if(![listener respondsToSelector:@selector(userProfileDidInserted:atIndex:)]){
            continue;
        }
        [listener userProfileDidInserted:userProfile atIndex:[self.allUserProfiles indexOfObject:userProfile]];
    }
    
//    if(!self.currentUserID){
//        self.currentUserID = userProfile.IDString;
//    }
    
}

-(void)addAccessToken:(AKAccessTokenObject *)accessTokenObject{

    [_userAccessTokens setObject:accessTokenObject forKey:accessTokenObject.userID];
//    if(!self.currentUserID){
//        self.currentUserID = accessTokenObject.userID;
//    }
    AKUserProfile *userProfile = [self getUserProfileByUserID:accessTokenObject.userID];
    for (id<AKUserManagerListenerProtocol> listener in _listeners) {
        if(![listener respondsToSelector:@selector(accessTokenDidUpdated:accessToken:)]){
            continue;
        }
        [listener accessTokenDidUpdated:userProfile accessToken:accessTokenObject];
    }
    
    
}


-(void)updateUserProfile:(AKUserProfile *)userProfile{

    //保存用户到内存
    AKUserProfile *oldUserProfile = [_userProfiles objectForKey:userProfile.IDString];
    
    if(oldUserProfile){
    
        oldUserProfile.screen_name = userProfile.screen_name;
        oldUserProfile.profile_image_url = userProfile.profile_image_url;
        oldUserProfile.avatar_hd = userProfile.avatar_hd;
        oldUserProfile.avatar_large = userProfile.avatar_large;
        oldUserProfile.userDescription = userProfile.userDescription;
        
    }
    else{
//        oldUserProfile = userProfile;
        [_userProfiles setObject:userProfile forKey:userProfile.IDString];
    }
    //保存用户资料到硬盘
    [self saveUserProfileToDisk:userProfile];
    


    if(oldUserProfile){
    
        for (id<AKUserManagerListenerProtocol> listener in _listeners) {
            if(![listener respondsToSelector:@selector(userProfileDidUpdated:atIndex:)]){
                continue;
            }
            
            [listener userProfileDidUpdated:oldUserProfile atIndex:[self.allUserProfiles indexOfObject:oldUserProfile]];
        }
    }
    else{
        for (id<AKUserManagerListenerProtocol> listener in _listeners) {
            if(![listener respondsToSelector:@selector(userProfileDidInserted:atIndex:)]){
                continue;
            }
            [listener userProfileDidInserted:userProfile atIndex:[self.allUserProfiles indexOfObject:userProfile]];
        }
    }
    
//    if(!self.currentUserID){
//        [self setCurrentUserID:userProfile.IDString];
//    }

    

}

-(void)updateUserAccessToken:(AKAccessTokenObject *)accessTokenObject;{

    AKAccessTokenObject *oldAccessTokenObject = (AKAccessTokenObject *)[_userAccessTokens objectForKey:accessTokenObject.userID];
    if(oldAccessTokenObject){
        oldAccessTokenObject.accessToken = accessTokenObject.accessToken;
        oldAccessTokenObject.expireIn = accessTokenObject.expireIn;
        oldAccessTokenObject.scope = accessTokenObject.scope;
        oldAccessTokenObject.createAt = accessTokenObject.createAt;
    }else{
        oldAccessTokenObject = accessTokenObject;
        [_userAccessTokens setObject:accessTokenObject forKey:accessTokenObject.userID];
    }
    
    //[self saveAccessTokenToDisk:accessTokenObject];
    
    AKUserProfile *userProfile = [self getUserProfileByUserID:accessTokenObject.userID];
    for (id<AKUserManagerListenerProtocol> listener in _listeners) {
        if(![listener respondsToSelector:@selector(accessTokenDidUpdated:accessToken:)]){
            continue;
        }
        [listener accessTokenDidUpdated:userProfile accessToken:oldAccessTokenObject];
    }

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


-(void)saveAccessTokenToDisk:(AKAccessTokenObject *)accessTokenObject{
    
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

-(AKAccessTokenObject *)getAccessTokenByUserID:(NSString *)userID{
    return [_userAccessTokens objectForKey:userID];
}

-(AKUserProfile *)getUserProfileByUserID:(NSString *)userID{
    return [_userProfiles objectForKey:userID];
}


-(AKUserProfile *)userAtIndex:(NSUInteger)index{
    return [[self allUserProfiles] objectAtIndex:index];
}

-(NSUInteger)indexOfUserProfile:(AKUserProfile *)userProfile{
    return [[self allUserProfiles] indexOfObject:userProfile];
}

-(void)removeUserAtIndex:(NSInteger)index{

    AKUserProfile *userProfile = [self userAtIndex:index];
    
    NSString *applicationSupportDirectory = [[NSFileManager defaultManager]applicationSupportDirectory];
    
    NSString *userAccountDirectory = [NSString stringWithFormat:@"%@/%@.account",applicationSupportDirectory,userProfile.IDString];
    
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:userAccountDirectory error:&error];
    
    if(!error){
        
        
        [_userAccessTokens removeObjectForKey:userProfile.IDString];
        [_userProfiles removeObjectForKey:userProfile.IDString];
        for (id<AKUserManagerListenerProtocol> listener in _listeners) {
            if(![listener respondsToSelector:@selector(userProfileDidRemoved:atIndex:)]){
                continue;
            }
            [listener userProfileDidRemoved:userProfile atIndex:index];
        }
    }
    
    if(_userProfiles.count>0){
        [self setCurrentUserID:[[self userAtIndex:0] IDString]];
    }else{
        [self setCurrentUserID:nil];
    }
    

    
}


#pragma mark - Listener
-(void)addListener:(id<AKUserManagerListenerProtocol>)listener{
    [_listeners addObject:listener];
}
-(void)removeListener:(id<AKUserManagerListenerProtocol>)listener{
    [_listeners removeObject:listener];
}


@end
