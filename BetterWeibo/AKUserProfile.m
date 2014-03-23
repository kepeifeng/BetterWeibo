//
//  AKUserProfile.m
//  BetterWeibo
//
//  Created by Kent on 13-11-10.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKUserProfile.h"

NSString *const AKUserProfilePropertyNamedProfileImage = @"profileImage";
NSString *const AKUserProfilePropertyNamedIsProcessingFollowingRequest = @"isProcessingFollowingRequest";




static NSOperationQueue *ATSharedOperationQueue() {
    static NSOperationQueue *_ATSharedOperationQueue = nil;
    if (_ATSharedOperationQueue == nil) {
        _ATSharedOperationQueue = [[NSOperationQueue alloc] init];
        // We limit the concurrency to see things easier for demo purposes. The default value NSOperationQueueDefaultMaxConcurrentOperationCount will yield better results, as it will create more threads, as appropriate for your processor
        [_ATSharedOperationQueue setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
    }
    return _ATSharedOperationQueue;
}

@implementation AKUserProfile
@synthesize profile_image_url = _profile_image_url;
@synthesize profileImage = _profileImage;
//@synthesize avatar_hd = _avatar_hd;
@synthesize avatar_large = _avatar_large;

static NSMutableDictionary *userDictionary;

-(id)initWithCoder:(NSCoder *)aDecoder{

    self = [super init];
    if(self){
    
        self.IDString = [aDecoder decodeObjectForKey:@"userID"];
//        self.accessToken = [aDecoder decodeObjectForKey:@"accessToken"];
//        self.accessTokenExpiresIn = [aDecoder decodeObjectForKey:@"expireIn"];
    
    
    }
    
    return self;

}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    
    [aCoder encodeObject:self.IDString forKey:@"userID"];
//    [aCoder encodeObject:self.accessToken forKey:@"accessToken"];
//    [aCoder encodeObject:self.accessTokenExpiresIn forKey:@"expireIn"];

}


-(NSString *)profile_image_url{

    return _profile_image_url;

}

-(void)setProfile_image_url:(NSString *)profile_image_url{

    _profile_image_url = profile_image_url;
    
}

-(NSString *)avatar_large{
    return _avatar_large;
}

-(void)setAvatar_large:(NSString *)avatar_large{
    _avatar_large = avatar_large;
    if(!self.isLoadingAvatarImage){
        [self loadAvatarImages];
    }

}
//-(NSString *)avatar_large{
//    return _avatar_hd;
//}
//-(void)setAvatar_hd:(NSString *)avatar_hd{
//    _avatar_hd = avatar_hd;
//
//}

-(NSImage *)profileImage{
    if(_profileImage){
        return _profileImage;
    }else if(!self.isLoadingAvatarImage){
        [self loadAvatarImages];
    }
    return _profileImage;
}

-(void)setProfileImage:(NSImage *)profileImage{
    if(_profileImage != profileImage){
        _profileImage = profileImage;
    }
}

-(void)loadAvatarImages{
    
    @synchronized (self) {
        if (!self.isLoadingAvatarImage) {
            self.isLoadingAvatarImage = YES;
            // We would have to keep track of the block with an NSBlockOperation, if we wanted to later support cancelling operations that have scrolled offscreen and are no longer needed. That will be left as an exercise to the user.
            [ATSharedOperationQueue() addOperationWithBlock:^(void) {
                
                NSImage *profileImage;
                if(self.avatar_large){
                    profileImage = [[NSImage alloc]initWithContentsOfURL:[NSURL URLWithString:self.avatar_large]];
                }
                
                if(!self.avatar_large || !profileImage){
                    profileImage = [AKUserProfile defaultAvatarImage];
                }
                
                @synchronized (self) {
                    self.profileImage = profileImage;
                    self.isLoadingAvatarImage = NO;
                }

            }];
        }
    }
    
}

+(NSImage *)defaultAvatarImage{

    static NSImage *gAvatar;
    if(!gAvatar){
        gAvatar = [NSImage imageNamed:@"avatar_default"];
    }
    return gAvatar;
    
}

+(AKUserProfile *)getUserProfileByID:(NSString *)userID{

    return [userDictionary objectForKey:userID];
}

+(AKUserProfile *)getUserProfileFromDictionary:(NSDictionary *)userProfileDictionary{

    if(!userProfileDictionary){
        return nil;
    }
    
    NSString *userID = (NSString *)[userProfileDictionary objectForKey:@"idstr"];
    if(!userID)
        return nil;
    
    AKUserProfile *userProfile = [userDictionary objectForKey:userID];
    
    if(userProfile){
        return userProfile;
    }
    
    
    userProfile = [[AKUserProfile alloc]init];
    userProfile.ID = [(NSNumber *)[userProfileDictionary objectForKey:@"id"] longLongValue];
    userProfile.IDString =(NSString *)[userProfileDictionary objectForKey:@"idstr"];
    userProfile.allow_all_act_msg = [(NSNumber *)[userProfileDictionary objectForKey:@"allow_all_act_msg"] boolValue];
    userProfile.allow_all_comment = [(NSNumber *)[userProfileDictionary objectForKey:@"allow_all_comment"] boolValue];
    userProfile.avatar_hd = (NSString *)[userProfileDictionary objectForKey:@"avatar_hd"];
    userProfile.avatar_large = (NSString *)[userProfileDictionary objectForKey:@"avatar_large"];
    userProfile.bi_followers_count =[(NSNumber *)[userProfileDictionary objectForKey:@"bi_followers_count"] integerValue];
    userProfile.city = (NSString *)[userProfileDictionary objectForKey:@"city"];
    userProfile.created_at =(NSString *)[userProfileDictionary objectForKey:@"created_at"];
    userProfile.description = (NSString *)[userProfileDictionary objectForKey:@"description"];
    userProfile.domain = (NSString *)[userProfileDictionary objectForKey:@"domain"];
    userProfile.favourites_count = [(NSNumber *)[userProfileDictionary objectForKey:@"favourites_count"] integerValue];
    userProfile.follow_me = [(NSNumber *)[userProfileDictionary objectForKey:@"follow_me"] boolValue];
    userProfile.followers_count = [(NSNumber *)[userProfileDictionary objectForKey:@"followers_count"] integerValue];
    userProfile.following = [(NSNumber *)[userProfileDictionary objectForKey:@"following"] boolValue];
    userProfile.friends_count = [(NSNumber *)[userProfileDictionary objectForKey:@"friends_count"] integerValue];
    userProfile.gender = (NSString *)[userProfileDictionary objectForKey:@"gender"];
    userProfile.geo_enabled = [(NSNumber *)[userProfileDictionary objectForKey:@"geo_enabled"] boolValue];
    userProfile.location = (NSString *)[userProfileDictionary objectForKey:@"location"];
    userProfile.name = (NSString *)[userProfileDictionary objectForKey:@"name"];
    userProfile.online_status = [(NSNumber *)[userProfileDictionary objectForKey:@"online_status"] integerValue];
    userProfile.profile_image_url = (NSString *)[userProfileDictionary objectForKey:@"profile_image_url"];
    userProfile.province = (NSString *)[userProfileDictionary objectForKey:@"province"];
    userProfile.remark = (NSString *)[userProfileDictionary objectForKey:@"remark"];
    userProfile.screen_name = (NSString *)[userProfileDictionary objectForKey:@"screen_name"];
    userProfile.statuses_count = [(NSNumber *)[userProfileDictionary objectForKey:@"statuses_count"] integerValue];
    userProfile.url_string = (NSString *)[userProfileDictionary objectForKey:@"url"];
    userProfile.verified = [(NSNumber *)[userProfileDictionary objectForKey:@"verified"] boolValue];
    userProfile.verified_reason = (NSString *)[userProfileDictionary objectForKey:@"verified_reason"];
    userProfile.verified_type =[(NSNumber *)[userProfileDictionary objectForKey:@"verified"] integerValue];
    userProfile.weihao = (NSString *)[userProfileDictionary objectForKey:@"weihao"];
    userProfile.star =[(NSNumber *)[userProfileDictionary objectForKey:@"star"] integerValue];

    
    
    [AKUserProfile addUserToDictionary:userProfile];
    
    return userProfile;
    

}

+(void)addUserToDictionary:(AKUserProfile *)userProfile{

    if(!userDictionary){
    
        userDictionary = [[NSMutableDictionary alloc]init];
    }
    
    [userDictionary setObject:userProfile forKey:userProfile.IDString];

}




@end
