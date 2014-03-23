//
//  AKView.h
//  BetterWeibo
//
//  Created by Kent on 14-3-4.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>


typedef NS_ENUM(NSUInteger, AKViewBackgrondType) {

    AKViewGlassWithShadowAtTop,
    AKViewGlassWithShadowAtBottom,
    AKViewGlass,
    AKViewLightGrayGraient,
    AKViewCustomBackground
    

};
@interface AKView : NSView


@property AKViewBackgrondType backgroundType;
@property NSInteger customLeftWidth;
@property NSInteger customRightWidth;
@property NSImage *customBackgroundImage;

@end
