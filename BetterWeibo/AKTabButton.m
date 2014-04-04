//
//  AKTabButton.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-29.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKTabButton.h"

@implementation AKTabButton{

    NSImageView *lightIndicator;
    NSImage *lightIndicatorImage;
    NSImage *buttonNormalBackgroundImage;
    NSImage *buttonActiveBackgroundImage;

}

@synthesize tabButtonIcon = _tabButtonIcon;
@synthesize tabButtonType = _tabButtonType;
@synthesize lightUpIndicator = _lightUpIndicator;
@synthesize tag = _myTag;

-(id)init{

    self = [super init];
    if(self){
    
        [self setButtonType:NSRadioButton];
        [self setImagePosition:NSImageOnly];
        
        lightIndicatorImage = [NSImage imageNamed:@"light-indicator"];
        buttonNormalBackgroundImage = [NSImage imageNamed:@"tab-control-button-normal"];
        buttonActiveBackgroundImage = [NSImage imageNamed:@"tab-control-button-active"];
        
        self.image = buttonNormalBackgroundImage;
        self.alternateImage = buttonActiveBackgroundImage;
        
//        lightIndicator = [[NSImageView alloc]initWithFrame:NSMakeRect(5, 5, 10, 10)];
//        [lightIndicator setImage:[NSImage imageNamed:@"light-indicator"]];
//        [lightIndicator setImageAlignment:NSImageAlignBottom];
//        [lightIndicator setImageScaling:NSImageScaleNone];
        
        
        
    
    }
    return self;

}

//-(void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView{
//
//}


-(void)drawImage:(NSImage *)image withFrame:(NSRect)frame inView:(NSView *)controlView{

    BOOL isHighlight = (image == self.alternateImage);
 
    NSRect drawingRect = [self getDrawingRect];
    
    NSImage *icon = (isHighlight)?self.alternateIcon:self.icon;
    NSPoint iconDrawingPoint = NSMakePoint((frame.size.width - icon.size.width)/2 + frame.origin.x,
                                           (frame.size.height - icon.size.height)/2 + frame.origin.y);
    
    NSRect iconDrawingRect = NSMakeRect(iconDrawingPoint.x, iconDrawingPoint.y, icon.size.width, icon.size.height);
    
//    [image drawAtPoint:NSMakePoint(frame.origin.x, frame.origin.y+frame.size.height) fromRect:drawingRect operation:NSCompositeSourceOver fraction:1];
    [image compositeToPoint:NSMakePoint(frame.origin.x, frame.origin.y+frame.size.height) fromRect:drawingRect operation:NSCompositeSourceOver];
    
    if(self.lightUpIndicator){
        [lightIndicatorImage drawInRect:NSMakeRect(5, 5 + frame.origin.y, 10, 10) fromRect:NSMakeRect(0, 10, 10, 10) operation:NSCompositeSourceOver fraction:1];
    
    }
    else{
        [lightIndicatorImage drawInRect:NSMakeRect(5, 5 + frame.origin.y, 10, 10) fromRect:NSMakeRect(0, 0, 10, 10) operation:NSCompositeSourceOver fraction:1];
    
    }
    
    [super drawImage:icon withFrame:iconDrawingRect inView:controlView];
    

}


-(NSRect)getDrawingRect{

    
    switch (self.tabButtonType) {
        case AKTabButtonTop:
            return NSMakeRect(0, 96, 49, 48);
            break;
            
        case AKTabButtonMiddle:
            return NSMakeRect(0, 48, 49, 48);
            break;
            
        case AKTabButtonBottom:
            return NSMakeRect(0, 0, 49, 48);
            
        default:
            return NSZeroRect;
            break;
    }

    
}

-(BOOL)lightUpIndicator{
    return _lightUpIndicator;
}

-(void)setLightUpIndicator:(BOOL)lightUpIndicator{
    _lightUpIndicator = lightUpIndicator;
    
    
    
}

-(void)setState:(NSInteger)value{

    NSLog(@"State Value = %ld",value);
    [super setState:value];
    
}

-(AKTabButtonType)tabButtonType{
    
    return _tabButtonType;
    
}

-(void)setTabButtonType:(AKTabButtonType)tabButtonType{
    
    _tabButtonType = tabButtonType;


}


-(AKTabButtonIcon)tabButtonIcon{

    return _tabButtonIcon;

}

-(void)setTabButtonIcon:(AKTabButtonIcon)tabButtonIcon{
    
    _tabButtonIcon = tabButtonIcon;
    
    switch (tabButtonIcon) {
        case AKTabButtonIconHome:
            self.icon = [NSImage imageNamed:@"timeline_tab"];
            self.alternateIcon = [NSImage imageNamed:@"timeline_selected_tab"];
            break;
        case AKTabButtonIconMention:
            self.icon = [NSImage imageNamed:@"mentions_tab"];
            self.alternateIcon = [NSImage imageNamed:@"mentions_selected_tab"];
            break;
            
        case AKTabButtonIconMessage:
            self.icon = [NSImage imageNamed:@"messages_tab"];
            self.alternateIcon = [NSImage imageNamed:@"messages_selected_tab"];
            break;
            
        case AKTabButtonIconFavorite:
            self.icon = [NSImage imageNamed:@"favorites_tab"];
            self.alternateIcon = [NSImage imageNamed:@"favorites_selected_tab"];
            break;
        
        case AKTabButtonIconSearch:
            self.icon = [NSImage imageNamed:@"search_tab"];
            self.alternateIcon = [NSImage imageNamed:@"search_selected_tab"];
            break;
        
        case AKTabButtonIconUser:
            self.icon = [NSImage imageNamed:@"profile_tab"];
            self.alternateIcon = [NSImage imageNamed:@"profile_selected_tab"];
            break;
            
        case AKTabButtonIconList:
            self.icon = [NSImage imageNamed:@"lists_tab"];
            self.alternateIcon = [NSImage imageNamed:@"lists_selected_tab"];
            break;
            
        case AKTabButtonIconBlocked:
            self.icon = [NSImage imageNamed:@"lists_tab"];
            self.alternateIcon = [NSImage imageNamed:@"lists_selected_tab"];
            break;
            
        default:
            break;
            

    }
    
    
    //[self.icon lockFocusFlipped:NO];



}



@end
