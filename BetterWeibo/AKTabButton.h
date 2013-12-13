//
//  AKTabButton.h
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-29.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSInteger, AKTabButtonIcon){
    
    
    AKTabButtonIconHome,
    AKTabButtonIconMention,
    AKTabButtonIconMessage,
    AKTabButtonIconFavorite,
    AKTabButtonIconSearch,
    AKTabButtonIconUser,
    AKTabButtonIconList,
    AKTabButtonIconBlocked
    
};

typedef NS_ENUM(NSInteger, AKTabButtonType) {

    AKTabButtonTop,
    AKTabButtonMiddle,
    AKTabButtonBottom

};

@interface AKTabButton : NSButtonCell

@property NSImage *icon;
@property NSImage *alternateIcon;
@property AKTabButtonIcon tabButtonIcon;
@property AKTabButtonType tabButtonType;
@property BOOL lightUpIndicator;
@property NSString *tag;

@end
