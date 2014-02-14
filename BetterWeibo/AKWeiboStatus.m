//
//  AKWeibo.m
//  BetterWeibo
//
//  Created by Kent on 13-10-6.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKWeiboStatus.h"
#import "AKUserProfile.h"
#import "AKImageDownloader.h"


@implementation AKWeiboStatus
@synthesize pic_urls = _pic_urls;

-(NSArray *)pic_urls{

    return _pic_urls;

}


-(void)setPic_urls:(NSArray *)pic_urls{

    _pic_urls = pic_urls;
    if(_pic_urls){
    
        
    
    }

}



+(AKWeiboStatus *)getStatusFromDictionary:(NSDictionary *)status{
    
    if(!status){
        return nil;
    }
    /*
     created_at 	string 	微博创建时间
     id 	int64 	微博ID
     mid 	int64 	微博MID
     idstr 	string 	字符串型的微博ID
     text 	string 	微博信息内容
     source 	string 	微博来源
     favorited 	boolean 	是否已收藏，true：是，false：否
     truncated 	boolean 	是否被截断，true：是，false：否
     in_reply_to_status_id 	string 	（暂未支持）回复ID
     in_reply_to_user_id 	string 	（暂未支持）回复人UID
     in_reply_to_screen_name 	string 	（暂未支持）回复人昵称
     thumbnail_pic 	string 	缩略图片地址，没有时不返回此字段
     bmiddle_pic 	string 	中等尺寸图片地址，没有时不返回此字段
     original_pic 	string 	原始图片地址，没有时不返回此字段
     geo 	object 	地理信息字段 详细
     user 	object 	微博作者的用户信息字段 详细
     retweeted_status 	object 	被转发的原微博信息字段，当该微博为转发微博时返回 详细
     reposts_count 	int 	转发数
     comments_count 	int 	评论数
     attitudes_count 	int 	表态数
     mlevel 	int 	暂未支持
     visible 	object 	微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
     pic_urls 	object 	微博配图地址。多图时返回多图链接。无配图返回“[]”
     ad 	object array 	微博流内的推广微博ID
     */
    
    
    AKWeiboStatus *statusObject = [[AKWeiboStatus alloc]init];
    statusObject.ID = [(NSNumber *)[status objectForKey:@"id"] longLongValue];
    statusObject.mid = [(NSNumber *)[status objectForKey:@"mid"] longLongValue];
    statusObject.idstr =(NSString *)[status objectForKey:@"idstr"];
    statusObject.created_at = (NSString *)[status objectForKey:@"created_at"];
    statusObject.thumbnail_pic = (NSString *)[status objectForKey:@"thumbnail_pic"];
    statusObject.bmiddle_pic =(NSString *)[status objectForKey:@"bmiddle_pic"];
    statusObject.original_pic = (NSString *)[status objectForKey:@"created_at"];
    statusObject.retweeted_status = [AKWeiboStatus getStatusFromDictionary:(NSDictionary  *)[status objectForKey:@"retweeted_status"]];
    statusObject.favorited = [(NSNumber *)[status objectForKey:@"favorited"] boolValue];
    //            statusObject.geo =
    statusObject.in_reply_to_screen_name = (NSString *)[status objectForKey:@"in_reply_to_screen_name"];
    statusObject.in_reply_to_status_id = (NSString *)[status objectForKey:@"in_reply_to_status_id"];
    statusObject.in_reply_to_user_id = (NSString *)[status objectForKey:@"in_reply_to_user_id"];
    statusObject.reposts_count = [(NSNumber *)[status objectForKey:@"reposts_count"] longLongValue];
    statusObject.comments_count = [(NSNumber *)[status objectForKey:@"comments_count"] integerValue];
    statusObject.attitudes_count = [(NSNumber *)[status objectForKey:@"attitudes_count"] integerValue];
    statusObject.visible = [AKWeiboVisibility getVisibilityFromDictionary:(NSDictionary *)[status objectForKey:@"visible"]];
    statusObject.pic_urls = (NSArray *)[status objectForKey:@"pic_urls"];
    statusObject.source = (NSString *)[status objectForKey:@"source"];
    statusObject.text = (NSString *)[status objectForKey:@"text"];
    statusObject.truncated = [(NSNumber *)[status objectForKey:@"favorited"] boolValue];
    
    NSDictionary *userProfileDictionary = (NSDictionary *)[status objectForKey:@"user"];
    
    statusObject.user = [AKUserProfile getUserProfileFromDictionary:userProfileDictionary];

    return statusObject;
    
}

+(AKWeiboStatus *)getStatusFromDictionary:(NSDictionary *)statusDictionary forStatus:(AKWeiboStatus *)repostedStatus{

    
    
    AKWeiboStatus *statusObject = [[AKWeiboStatus alloc]init];
    statusObject.ID = [(NSNumber *)[statusDictionary objectForKey:@"id"] longLongValue];
    statusObject.mid = [(NSNumber *)[statusDictionary objectForKey:@"mid"] longLongValue];
    statusObject.idstr =(NSString *)[statusDictionary objectForKey:@"idstr"];
    statusObject.created_at = (NSString *)[statusDictionary objectForKey:@"created_at"];
    statusObject.thumbnail_pic = (NSString *)[statusDictionary objectForKey:@"thumbnail_pic"];
    statusObject.bmiddle_pic =(NSString *)[statusDictionary objectForKey:@"bmiddle_pic"];
    statusObject.original_pic = (NSString *)[statusDictionary objectForKey:@"created_at"];
    statusObject.retweeted_status = repostedStatus;
    statusObject.favorited = [(NSNumber *)[statusDictionary objectForKey:@"favorited"] boolValue];
    //            statusObject.geo =
    statusObject.in_reply_to_screen_name = (NSString *)[statusDictionary objectForKey:@"in_reply_to_screen_name"];
    statusObject.in_reply_to_status_id = (NSString *)[statusDictionary objectForKey:@"in_reply_to_status_id"];
    statusObject.in_reply_to_user_id = (NSString *)[statusDictionary objectForKey:@"in_reply_to_user_id"];
    statusObject.reposts_count = [(NSNumber *)[statusDictionary objectForKey:@"reposts_count"] longLongValue];
    statusObject.comments_count = [(NSNumber *)[statusDictionary objectForKey:@"comments_count"] integerValue];
    statusObject.attitudes_count = [(NSNumber *)[statusDictionary objectForKey:@"attitudes_count"] integerValue];
    statusObject.visible = [AKWeiboVisibility getVisibilityFromDictionary:(NSDictionary *)[statusDictionary objectForKey:@"visible"]];
    statusObject.pic_urls = (NSArray *)[statusDictionary objectForKey:@"pic_urls"];
    statusObject.source = (NSString *)[statusDictionary objectForKey:@"source"];
    statusObject.text = (NSString *)[statusDictionary objectForKey:@"text"];
    statusObject.truncated = [(NSNumber *)[statusDictionary objectForKey:@"favorited"] boolValue];
    
    NSDictionary *userProfileDictionary = (NSDictionary *)[statusDictionary objectForKey:@"user"];
    
    statusObject.user = [AKUserProfile getUserProfileFromDictionary:userProfileDictionary];
    
    return statusObject;

}


@end


@implementation AKWeiboVisibility

+(AKWeiboVisibility *)getVisibilityFromDictionary:(NSDictionary *)visibilityDictionary{

    if(!visibilityDictionary)
        return nil;
    
    AKWeiboVisibility *visibilityObject = [[AKWeiboVisibility alloc]init];
    visibilityObject.type = [(NSNumber *)[visibilityDictionary objectForKey:@"type"] integerValue];
    visibilityObject.list_id = [(NSNumber *)[visibilityDictionary objectForKey:@"list_id"] integerValue];
    
    return visibilityObject;

}

@end
