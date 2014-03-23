//
//  AKUserTableCellView.h
//  BetterWeibo
//
//  Created by Kent on 14-3-7.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AKUserProfile.h"
#import "AKUserButton.h"
#import "AKButton.h"

@interface AKUserTableCellView : NSTableCellView

@property IBOutlet AKButton *followButton;
@property IBOutlet NSProgressIndicator *followingProgrecessIndicator;
@property IBOutlet NSTextField *userAlisaTextField;
@property IBOutlet NSTextField *userDescription;
@property IBOutlet NSTextField *numberOfFollowerField;
@property IBOutlet AKUserButton *userAvatar;

@property AKUserProfile *userProfile;



@end
