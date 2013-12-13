//
//  AKUserButton.h
//  BetterWeibo
//
//  Created by Kent on 13-12-10.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AKUserButton : NSButton{

    NSImage *_defaultAvatarImage;
    NSImage *_topLayerImage;
}

@property NSString *avatarURL;
@property NSImage *avatarImage;
@property NSString *userID;


@end
