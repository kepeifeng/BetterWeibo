//
//  AKUserButtonCell.h
//  BetterWeibo
//
//  Created by Kent on 14-3-19.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSUInteger, AKUserButtonBorderType) {
    
    AKUserButtonBorderTypeNone,
    AKUserButtonBorderTypeBezel,
    AKUserButtonBorderTypeGlassOutline,
    AKUserButtonBorderTypeLine,
    AKUserButtonBorderTypeRounedConnerRect
    
};

@interface AKUserButtonCell : NSButtonCell

@property AKUserButtonBorderType borderType;

@end
