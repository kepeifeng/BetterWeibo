//
//  AKButton.m
//  controlLabs
//
//  Created by Kent on 14-2-24.
//  Copyright (c) 2014年 Kent. All rights reserved.
//

#import "AKButtonCell.h"

@implementation AKButtonCell
{
    NSImage *_leftPartImage;
    NSImage *_middlePartImage;
    NSImage *_rightPartImage;
    
    NSImage *_leftPartHighlightImage;
    NSImage *_middlePartHighlightImage;
    NSImage *_rightPartHighlightImage;
    
    NSImage *_normalImage;
    NSImage *_highlightImage;
    
}
@synthesize buttonCellStyle = _buttonCellStyle;
- (id)init
{
    self = [super init];
    if (self) {
        [self setButtonCellStyle:AKButtonStyleDarkButton];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if(self){
    
        [self setButtonCellStyle:AKButtonStyleDarkButton];
        
        
    }
    return self;

}
//- (id)initWithFrame:(NSRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code here.
//        [self setButtonBackgroundImage:[NSImage imageNamed:@"navbar_button"]];
//        
//        
//    }
//    return self;
//}

-(AKButtonStyle)buttonCellStyle{

    return _buttonCellStyle;

}

-(void)setButtonCellStyle:(AKButtonStyle)style{
    
    _buttonCellStyle = style;
    switch (style) {
        case AKButtonStyleDarkButton:
            [self setButtonBackgroundImage:[NSImage imageNamed:@"navbar_button"] highlightImage:[NSImage imageNamed:@"navbar_highlighted_button"] leftPartWidth:10 rightPartWidth:10];
            break;
        case AKButtonStyleBlueButton:
            [self setButtonBackgroundImage:[NSImage imageNamed:@"preferences_blue_button"] highlightImage:[NSImage imageNamed:@"preferences_blue_highlighted_button"] leftPartWidth:10 rightPartWidth:10];
            break;
        case AKButtonStyleRedButton:
            [self setButtonBackgroundImage:[NSImage imageNamed:@"preferences_red_button"] highlightImage:[NSImage imageNamed:@"preferences_red_highlighted_button"] leftPartWidth:10 rightPartWidth:10];
            break;
        case AKButtonStyleGrayButton:
            [self setButtonBackgroundImage:[NSImage imageNamed:@"preferences_grey_button"] highlightImage:[NSImage imageNamed:@"preferences_grey_highlighted_button"] leftPartWidth:10 rightPartWidth:10];
            break;
        case AKButtonStyleNavBackButton:
            [self setButtonBackgroundImage:[NSImage imageNamed:@"navbar_back_button"] highlightImage:[NSImage imageNamed:@"navbar_back_highlighted_button"] leftPartWidth:12 rightPartWidth:10];

        default:
            break;
    }
    
    

}


-(void)setButtonBackgroundImage:(NSImage *)image
                 highlightImage:(NSImage *)highlightImage
                  leftPartWidth:(NSInteger)leftPartWidth
                 rightPartWidth:(NSInteger)rightPartWidth
{

    
    _leftPartImage = [[NSImage alloc]initWithSize:NSMakeSize(leftPartWidth, image.size.height)];
    _middlePartImage = [[NSImage alloc]initWithSize:NSMakeSize(image.size.width - leftPartWidth - rightPartWidth, image.size.height)];
    _rightPartImage = [[NSImage alloc]initWithSize:NSMakeSize(rightPartWidth, image.size.height)];

    _leftPartHighlightImage = [[NSImage alloc]initWithSize:NSMakeSize(leftPartWidth, highlightImage.size.height)];
    _middlePartHighlightImage = [[NSImage alloc]initWithSize:NSMakeSize(highlightImage.size.width - leftPartWidth - rightPartWidth, highlightImage.size.height)];
    _rightPartHighlightImage = [[NSImage alloc]initWithSize:NSMakeSize(rightPartWidth, highlightImage.size.height)];
    
    //For Normal Status Button
    [_leftPartImage lockFocus];
    [image drawInRect:NSMakeRect(0, 0, _leftPartImage.size.width, _leftPartImage.size.height)
             fromRect:NSMakeRect(0, 0, _leftPartImage.size.width, _leftPartImage.size.height)
            operation:NSCompositeSourceOver
             fraction:1];
    [_leftPartImage unlockFocus];
    
    [_middlePartImage lockFocus];
    [image drawInRect:NSMakeRect(0, 0, _middlePartImage.size.width, _middlePartImage.size.height)
             fromRect:NSMakeRect(_leftPartImage.size.width, 0, _middlePartImage.size.width, _middlePartImage.size.height)
            operation:NSCompositeSourceOver
             fraction:1];
    [_middlePartImage unlockFocus];
    
    [_rightPartImage lockFocus];
    [image drawInRect:NSMakeRect(0, 0, _rightPartImage.size.width, _rightPartImage.size.height)
             fromRect:NSMakeRect(image.size.width - _rightPartImage.size.width, 0, _rightPartImage.size.width, _rightPartImage.size.height)
            operation:NSCompositeSourceOver
             fraction:1];
    [_rightPartImage unlockFocus];
    
    //For Highlight Status Button
    [_leftPartHighlightImage lockFocus];
    [highlightImage drawInRect:NSMakeRect(0, 0, _leftPartHighlightImage.size.width, _leftPartHighlightImage.size.height)
             fromRect:NSMakeRect(0, 0, _leftPartHighlightImage.size.width, _leftPartHighlightImage.size.height)
            operation:NSCompositeSourceOver
             fraction:1];
    [_leftPartHighlightImage unlockFocus];
    
    [_middlePartHighlightImage lockFocus];
    [highlightImage drawInRect:NSMakeRect(0, 0, _middlePartHighlightImage.size.width, _middlePartHighlightImage.size.height)
             fromRect:NSMakeRect(_leftPartHighlightImage.size.width, 0, _middlePartHighlightImage.size.width, _middlePartHighlightImage.size.height)
            operation:NSCompositeSourceOver
             fraction:1];
    [_middlePartHighlightImage unlockFocus];
    
    [_rightPartHighlightImage lockFocus];
    [highlightImage drawInRect:NSMakeRect(0, 0, _rightPartHighlightImage.size.width, _rightPartHighlightImage.size.height)
             fromRect:NSMakeRect(highlightImage.size.width - _rightPartHighlightImage.size.width, 0, _rightPartHighlightImage.size.width, _rightPartHighlightImage.size.height)
            operation:NSCompositeSourceOver
             fraction:1];
    [_rightPartHighlightImage unlockFocus];
    
    
    

}

-(void)drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView{
    

    
    NSRect drawingRect = controlView.bounds;
    if(self.isHighlighted){
    
        NSDrawThreePartImage(drawingRect, _leftPartHighlightImage, _middlePartHighlightImage, _rightPartHighlightImage, NO, NSCompositeSourceOver, 1, controlView.isFlipped);
    }
    else{
    
        NSDrawThreePartImage(drawingRect, _leftPartImage, _middlePartImage, _rightPartImage, NO, NSCompositeSourceOver, 1, controlView.isFlipped);
        
    }

    
}


-(NSRect)drawTitle:(NSAttributedString *)title withFrame:(NSRect)frame inView:(NSView *)controlView{

    NSShadow *titleShadow = [NSShadow new];
    titleShadow.shadowColor = [NSColor blackColor];
    titleShadow.shadowBlurRadius = 0;
    titleShadow.shadowOffset = NSMakeSize(-1, 1);
    
    NSMutableAttributedString *newTitle = [[NSMutableAttributedString alloc] initWithAttributedString:title];
    [newTitle addAttribute:NSShadowAttributeName value:titleShadow range:NSMakeRange(0, newTitle.length)];
    [newTitle addAttribute:NSForegroundColorAttributeName value:[NSColor whiteColor] range:NSMakeRange(0, newTitle.length)];
    

    return [super drawTitle:newTitle withFrame:frame inView:controlView];

}


@end
