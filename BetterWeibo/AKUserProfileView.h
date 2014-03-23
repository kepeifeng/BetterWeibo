//
//  AKUserProfileView.h
//  BetterWeibo
//
//  Created by Kent on 14-3-3.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AKTextField.h"
#import "AKUserProfile.h"
#import "AKUserButton.h"
#import "AKButton.h"

@interface AKUserProfileView : NSView

@property AKUserButton *userAvatar;
@property NSTextField *screenName;
@property NSTextField *varifiedInfo;
@property AKTextField *userDescription;
@property NSButton *numberOfFollowing;
@property NSButton *numberOfFollower;
@property NSButton *numberOfStatuses;
@property AKButton *followButton;
@property AKUserProfile *userProfile;
@property NSProgressIndicator *followingProgrecessIndicator;

@end
