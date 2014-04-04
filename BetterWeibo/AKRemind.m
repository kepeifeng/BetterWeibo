//
//  AKRemind.m
//  BetterWeibo
//
//  Created by Kent on 13-12-4.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKRemind.h"

@implementation AKRemind


+(instancetype)getRemindFromDictionary:(NSDictionary *)dictionary{
    
    AKRemind *remind = [AKRemind new];
    /*
     "status": 0,
     "follower": 1,
     "cmt": 0,
     "dm": 1,
     "mention_status": 0,
     "mention_cmt": 0,
     "group": 0,
     "private_group": 0,
     "notice": 0,
     "invite": 0,
     "badge": 0,
     "photo": 0,
     "msgbox": 0
     */
    
    remind.status = [(NSNumber *)[dictionary objectForKey:@"status"] integerValue];
    remind.follower = [(NSNumber *)[dictionary objectForKey:@"follower"] integerValue];
    remind.comment = [(NSNumber *)[dictionary objectForKey:@"cmt"] integerValue];
    remind.directMessage = [(NSNumber *)[dictionary objectForKey:@"dm"] integerValue];
    remind.mentionStatus = [(NSNumber *)[dictionary objectForKey:@"mention_status"] integerValue];
    remind.mentionComment = [(NSNumber *)[dictionary objectForKey:@"mention_cmt"] integerValue];
    remind.group = [(NSNumber *)[dictionary objectForKey:@"group"] integerValue];
    remind.privateGroup = [(NSNumber *)[dictionary objectForKey:@"private_group"] integerValue];
    remind.notice = [(NSNumber *)[dictionary objectForKey:@"notice"] integerValue];
    remind.invite = [(NSNumber *)[dictionary objectForKey:@"invite"] integerValue];
    remind.badge = [(NSNumber *)[dictionary objectForKey:@"badge"] integerValue];
    remind.photo = [(NSNumber *)[dictionary objectForKey:@"photo"] integerValue];
    remind.messageBox = [(NSNumber *)[dictionary objectForKey:@"msgbox"] integerValue];
    
    return remind;
}

@end
