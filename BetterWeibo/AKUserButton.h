//
//  AKUserButton.h
//  BetterWeibo
//
//  Created by Kent on 13-12-10.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AKUserProfile.h"
#import "AKUserButtonCell.h"

@interface AKUserButton : NSButton{

    NSImage *_defaultAvatarImage;
    NSImage *_topLayerImage;
}

@property AKUserProfile *userProfile;
//@property NSString *avatarURL;
//@property (readonly) NSImage *avatarImage;
//@property NSImage *image;
@property NSString *userID;
@property AKUserButtonBorderType borderType;


@end
