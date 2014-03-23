//
//  AKView.m
//  BetterWeibo
//
//  Created by Kent on 14-3-4.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKView.h"
#import "AKImageHelper.h"

@implementation AKView{
    NSImage *_leftPartImage;
    NSImage *_middlePartImage;
    NSImage *_rightPartImage;
    NSImage *_backgroundImage;
    NSInteger _leftWidth;
    NSInteger _rightWidth;
    NSImageView *_backgroundImageView;
}

@synthesize backgroundType = _backgroundType;
@synthesize customLeftWidth = _customLeftWidth;
@synthesize customRightWidth = _customRightWidth;
@synthesize customBackgroundImage = _customBackgroundImage;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        self.backgroundType = AKViewGlass;
        
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
//    NSColor *backgroundColor = [NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:0.5];
//    
//    [backgroundColor setFill];
//    
//    [[NSBezierPath bezierPathWithRect:self.bounds] fill];
    
    // Drawing code here.
    if(self.needsDisplay){
    
        
        NSDrawThreePartImage(self.bounds, _leftPartImage, _middlePartImage, _rightPartImage, NO, NSCompositeSourceOver, 1, self.isFlipped);
    }
    
}




-(NSInteger)customRightWidth{
    return _customRightWidth;
}
-(void)setCustomRightWidth:(NSInteger)customRightWidth{
    _customRightWidth = customRightWidth;
    [self updateThreePartImages];
}

-(NSInteger)customLeftWidth{
    return _customLeftWidth;
}

-(void)setCustomLeftWidth:(NSInteger)customLeftWidth{
    _customLeftWidth = customLeftWidth;
    [self updateThreePartImages];
}

-(NSImage *)customBackgroundImage{
    return _customBackgroundImage;
}

-(void)setCustomBackgroundImage:(NSImage *)customBackgroundImage{
    _customBackgroundImage = customBackgroundImage;
    [self updateThreePartImages];
}

-(AKViewBackgrondType)backgroundType{
    return _backgroundType;
}

-(void)setBackgroundType:(AKViewBackgrondType)backgroundType{
    
    _backgroundType = backgroundType;
    [self updateThreePartImages];
}

-(void)updateThreePartImages{
    
    if(_backgroundType == AKViewGlass){
        _backgroundImage = [NSImage imageNamed:@"glassbar"];
        _leftWidth = 10;
        _rightWidth = 10;
    }else if (_backgroundType == AKViewGlassWithShadowAtTop){
        _backgroundImage = [NSImage imageNamed:@"glassbar-shadow-top"];
        _leftWidth = 10;
        _rightWidth = 10;
    }else if(_backgroundType == AKViewGlassWithShadowAtBottom){
        _backgroundImage = [NSImage imageNamed:@"glassbar-shadow-bottom"];
        _leftWidth = 10;
        _rightWidth = 10;
    }else if(_backgroundType == AKViewCustomBackground){
        _backgroundImage = _customBackgroundImage;
        _leftWidth = _customLeftWidth;
        _rightWidth = _customRightWidth;
        
    }else if (_backgroundType == AKViewLightGrayGraient){
        _backgroundImage = [NSImage imageNamed:@"light-gray-gradient"];
        _leftWidth = 10;
        _rightWidth = 10;
    }
    
    NSImage *_leftPart, *_middlePart, *_rightPart;
    
    if(!_backgroundImage || _leftWidth == 0 || _rightWidth == 0){
        return;
    }
    
    [AKImageHelper getThreePartImageFrom:_backgroundImage leftWidth:_leftWidth rightWidth:_rightWidth leftPart:&_leftPart middlePart:&_middlePart rightPart:&_rightPart];
    
    _leftPartImage = _leftPart;
    _middlePartImage = _middlePart;
    _rightPartImage = _rightPart;

    
}

@end
