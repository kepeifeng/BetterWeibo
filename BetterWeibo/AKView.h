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
    AKViewCustomImageBackground,
    AKViewCustomDrawingBlock
    
    

};
@interface AKView : NSView


@property AKViewBackgrondType backgroundType;
@property NSInteger customLeftWidth;
@property NSInteger customRightWidth;
@property NSImage *customBackgroundImage;
@property (nonatomic, copy) void(^customDrawingBlock)(NSRect dirtyRect);

@end
