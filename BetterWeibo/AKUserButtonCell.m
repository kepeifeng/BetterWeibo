//
//  AKUserButtonCell.m
//  BetterWeibo
//
//  Created by Kent on 14-3-19.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKUserButtonCell.h"
#import "AKUserProfile.h"


@implementation AKUserButtonCell

@synthesize borderType = _borderType;

-(AKUserButtonBorderType)borderType{
    return _borderType;
}

-(void)setBorderType:(AKUserButtonBorderType)borderType{
    _borderType = borderType;
    
}


-(void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView{

//    [self.image drawInRect:cellFrame];
    NSImage *image = self.image;
    NSRect frame = cellFrame;
    
    switch (_borderType) {
        case AKUserButtonBorderTypeBezel:
            [self drawBezelTypeImageFrom:image withFrame:frame inView:controlView];
            break;
        case AKUserButtonBorderTypeGlassOutline:
            [self drawGlassOutlineTypeImageFrom:image withFrame:frame inView:controlView];
            break;
        case AKUserButtonBorderTypeNone:
        default:
            [super drawImage:image withFrame:frame inView:controlView];
            break;
    }
    
}

-(void)drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView{

}

-(void)drawImage:(NSImage *)image withFrame:(NSRect)frame inView:(NSView *)controlView{

    //[image drawInRect:frame];
//    [super drawImage:image withFrame:frame inView:controlView];
    return;
    
    switch (_borderType) {
        case AKUserButtonBorderTypeBezel:
            [self drawBezelTypeImageFrom:image withFrame:frame inView:controlView];
            break;
        case AKUserButtonBorderTypeGlassOutline:
            [self drawGlassOutlineTypeImageFrom:image withFrame:frame inView:controlView];
            break;
        case AKUserButtonBorderTypeNone:
        default:
            [super drawImage:image withFrame:frame inView:controlView];
            break;
    }

}




-(void)drawBezelTypeImageFrom:(NSImage *)image withFrame:(NSRect)frame inView:(NSView *)controlView{
    
    NSInteger roundedConnerRadius = 5;
//    NSImage *bezelTypeImage = [[NSImage alloc] initWithSize:imageSize];
    
    NSRect drawingRect = frame;
    drawingRect = NSInsetRect(drawingRect, 0.5, 0.5);
    
    NSInteger shadowInsetWidth = 2;
    NSRect shadowRect = NSInsetRect(drawingRect, -shadowInsetWidth, -shadowInsetWidth);
//    [bezelTypeImage lockFocus];
    NSColor *strokeColor = [NSColor colorWithCalibratedWhite:0.6 alpha:1];
    
    NSBezierPath *roundedRect = [NSBezierPath bezierPathWithRoundedRect:drawingRect xRadius:roundedConnerRadius yRadius:roundedConnerRadius];
    NSBezierPath *roundedShadowRect = [NSBezierPath bezierPathWithRoundedRect:shadowRect xRadius:roundedConnerRadius+shadowInsetWidth yRadius:roundedConnerRadius+shadowInsetWidth];
    
    [[NSGraphicsContext currentContext] saveGraphicsState];
    
    [roundedRect addClip];//Don't use -setClip
    
    [image drawInRect:NSInsetRect(drawingRect, -0.5, -0.5)];
    [strokeColor setStroke];
    NSShadow * shadow = [[NSShadow alloc] init];
    [shadow setShadowColor:[NSColor colorWithCalibratedWhite:0 alpha:0.2]];
    [shadow setShadowBlurRadius:shadowInsetWidth];
    [shadow setShadowOffset:NSMakeSize(shadowInsetWidth,-shadowInsetWidth)];
    [shadow set];
    [roundedShadowRect setLineWidth:shadowInsetWidth*2];
    [roundedShadowRect stroke];
    
    [[NSGraphicsContext currentContext] restoreGraphicsState];
    
    [strokeColor setStroke];
    [roundedRect setLineWidth:1];
    [roundedRect stroke];
    
//    [bezelTypeImage unlockFocus];
    
//    return bezelTypeImage;
    
    
}


//带有黑色玻璃边框的图片
-(void)drawGlassOutlineTypeImageFrom:(NSImage *)image withFrame:(NSRect)frame inView:(NSView *)controlView{
    
    NSInteger borderWidth = 6;
    NSInteger radius = 6;
//    NSImage *newImage = [[NSImage alloc] initWithSize:frame.size];
    NSRect roundedRectFrame = frame;
    roundedRectFrame.size.height -= 1;
    roundedRectFrame = NSInsetRect(roundedRectFrame, 0.5, 0.5);
    
    NSColor *highlightColor = [NSColor colorWithCalibratedWhite:1 alpha:0.2];
    
//    [newImage lockFocus];
    
    //底部高亮线
    NSBezierPath *roundedRectPath = [NSBezierPath bezierPathWithRoundedRect:roundedRectFrame xRadius:radius yRadius:radius];
    roundedRectPath.lineWidth = 1.0;
    [highlightColor setStroke];
    [roundedRectPath stroke];
    
    //最外层的边线和底色（边框颜色）
    roundedRectFrame.origin.y += 1;
    roundedRectPath = [NSBezierPath bezierPathWithRoundedRect:roundedRectFrame xRadius:radius yRadius:radius];
    [[NSColor colorWithCalibratedWhite:0 alpha:1] setStroke];
    [[NSColor colorWithCalibratedWhite:0.2 alpha:1] setFill];
    [roundedRectPath fill];
    [roundedRectPath stroke];
    
    //最外层边线的内高亮线
    roundedRectFrame = NSInsetRect(roundedRectFrame, 1, 1);
    roundedRectPath = [NSBezierPath bezierPathWithRoundedRect:roundedRectFrame xRadius:radius-1 yRadius:radius-1];
    [highlightColor setStroke];
    [roundedRectPath stroke];
    
    //里层边线的高亮线
    roundedRectFrame = NSInsetRect(roundedRectFrame, borderWidth-2, borderWidth-2);
    roundedRectPath = [NSBezierPath bezierPathWithRoundedRect:roundedRectFrame xRadius:3 yRadius:3];
    [highlightColor setStroke];
    [roundedRectPath stroke];
    
    //里层边线和图片的位置和尺寸
    roundedRectFrame = NSInsetRect(roundedRectFrame, 1, 1);
    roundedRectPath = [NSBezierPath bezierPathWithRoundedRect:roundedRectFrame xRadius:2 yRadius:2];
    
//    [NSGraphicsContext saveGraphicsState];
//    [roundedRectPath setClip];
    
    //图片(图片的绘制方式和路径不同，因此位置和尺寸要用整数点来绘制)
    [image drawInRect:NSInsetRect(roundedRectFrame, 0.5, 0.5) fromRect:NSMakeRect(0, 0, image.size.width, image.size.height) operation:NSCompositeCopy fraction:1];
    
    //[NSGraphicsContext restoreGraphicsState];
    
    //里层边线
    [[NSColor colorWithCalibratedWhite:0 alpha:1] setStroke];
    [roundedRectPath stroke];
    
}

@end
