//
//  AKMenuItemRemindView.m
//  Wukong
//
//  Created by Kent on 14-4-1.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKMenuItemRemindView.h"
#import "AKView.h"

@implementation AKMenuItemRemindView{
    
    NSImageView *_imageView;
    NSTextField *_titleField;
    AKView *_countView;
    NSTextField *_countField;
    
    NSTrackingArea *_trackingArea;
    
    
}

@synthesize image = _image;
@synthesize title = _title;
@synthesize count = _count;
@synthesize alternateImage = _alternateImage;
@synthesize isHighlight = _isHighlight;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        
         _imageView = [[NSImageView alloc] initWithFrame:NSMakeRect(10, 4, 22, 22)];
        [self addSubview:_imageView];
        
//        //水平中间对齐
//        [_imageView addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
//        
        
        _titleField = [[NSTextField alloc] initWithFrame:NSMakeRect(_imageView.frame.origin.x + _imageView.frame.size.width + 5, 5, 100, 20)];
        [_titleField setEditable:NO];
        [_titleField setBordered:NO];
        [_titleField setDrawsBackground:NO];
        [_titleField setSelectable:NO];
        [_titleField.cell setLineBreakMode:NSLineBreakByTruncatingTail];
        [_titleField setFont:[NSFont systemFontOfSize:14.0]];
         
        [self addSubview:_titleField];
        
//        //水平中间对齐
//        [_titleField addConstraint:[NSLayoutConstraint constraintWithItem:_titleField attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
//        
        
        _countView = [[AKView alloc] initWithFrame:NSMakeRect(90, 5, 40, 22)];
        _countView.backgroundType = AKViewCustomImageBackground;
        _countView.customBackgroundImage = [NSImage imageNamed:@"status_item_background_count"];
        _countView.customLeftWidth = 8;
        _countView.customRightWidth = 8;
        
//        //水平中间对齐
//        [_countView addConstraint:[NSLayoutConstraint constraintWithItem:_countView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        
        
        _countField = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 40, 20)];
        [_countField setEditable:NO];
        [_countField setBordered:NO];
        [_countField setDrawsBackground:NO];
        [_countField setTextColor:[NSColor whiteColor]];
        [_countField setFont:[NSFont boldSystemFontOfSize:12.0]];
        [_countField setAlignment:NSCenterTextAlignment];
        
        [_countView addSubview:_countField];
        [self addSubview:_countView];

        self.count = 0;
        
//        //Set edge constraints between count view and count field
//        [[self class] addEdgeConstraint:NSLayoutAttributeLeft superview:_countView subview:_countField];
//        [[self class] addEdgeConstraint:NSLayoutAttributeRight superview:_countView subview:_countField];
//        [[self class] addEdgeConstraint:NSLayoutAttributeTop superview:_countView subview:_countField];
//        [[self class] addEdgeConstraint:NSLayoutAttributeBottom superview:_countView subview:_countField];
//        
    }
    return self;
}

+ (void)addEdgeConstraint:(NSLayoutAttribute)edge superview:(NSView *)superview subview:(NSView *)subview {
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:subview
                                                          attribute:edge
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superview
                                                          attribute:edge
                                                         multiplier:1
                                                           constant:0]];
}

- (void)drawRect:(NSRect)dirtyRect
{
    
    NSColor *backgroundColor = (self.isHighlight)?[NSColor colorWithCalibratedRed:204/255.0 green:226/255.0 blue:238/255.0 alpha:1]:[NSColor clearColor];
    
    [backgroundColor setFill];
    [[NSBezierPath bezierPathWithRect:self.bounds] fill];
    
    
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}




-(NSImage *)image{
    return _image;
}

-(void)setImage:(NSImage *)image{
    _image = image;
    [_imageView setImage:_image];
    
}

-(NSImage *)alternateImage{
    return _alternateImage;
}

-(void)setAlternateImage:(NSImage *)alternateImage{
    _alternateImage = alternateImage;
}

-(NSString *)title{
    return _title;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    [_titleField setStringValue:title];
}

-(NSInteger)count{
    return _count;
}

-(void)setCount:(NSInteger)count{
    _count = count;
    [_countField setStringValue:[NSString stringWithFormat:@"%ld",_count]];
    if(_count == 0){
        [_countView setHidden:YES];
    }
    else{
        [_countView setHidden:NO];
    }
    
    NSSize newCountViewSize = _countView.frame.size;
    newCountViewSize.width = 8*2 + _countField.intrinsicContentSize.width;
    
    NSRect newCountViewFrame = NSMakeRect(self.frame.size.width - newCountViewSize.width - 10,
                                          _countView.frame.origin.y,
                                          newCountViewSize.width,
                                          newCountViewSize.height);
    [_countView setFrame:newCountViewFrame];
    
    [_countField setFrame:NSMakeRect(0, 0, newCountViewSize.width, 20)];

//    [_countView setFrameSize:_countField.intrinsicContentSize];
}

-(BOOL)isHighlight{
    return _isHighlight;
}

-(void)setIsHighlight:(BOOL)isHighlight{
    _isHighlight = isHighlight;
    if(_isHighlight && self.alternateImage){
        _imageView.image = self.alternateImage;
    }else{
        _imageView.image = self.image;
    }
    
    [self setNeedsDisplay:YES];
}

-(void)updateTrackingAreas{
    
    if(_trackingArea){
        [self removeTrackingArea:_trackingArea];
    }
    
    NSTrackingAreaOptions trackingOptions = NSTrackingMouseEnteredAndExited | NSTrackingActiveInActiveApp | NSTrackingEnabledDuringMouseDrag;
    
    _trackingArea = [[NSTrackingArea alloc] initWithRect:self.bounds options:trackingOptions owner:self userInfo:nil];
    
    
    [self addTrackingArea:_trackingArea];
    
}


/* Do everything associated with sending the action from user selection such as terminating menu tracking.
 */
- (void)sendAction {
    NSMenuItem *actualMenuItem = [self enclosingMenuItem];
    
    // Send the action set on the actualMenuItem to the target set on the actualMenuItem, and make come from the actualMenuItem.
    [NSApp sendAction:[actualMenuItem action] to:[actualMenuItem target] from:actualMenuItem];
	
//	// dismiss the menu being tracked
	NSMenu *menu = [actualMenuItem menu];
	[menu cancelTracking];
    self.isHighlight = NO;

}

-(void)mouseUp:(NSEvent *)theEvent{
    
    [self sendAction];
}

-(void)mouseEntered:(NSEvent *)theEvent{
    
//    [_closeButton setHidden:NO];
    self.isHighlight = true;
    
}

-(void)mouseExited:(NSEvent *)theEvent{
    
//    [_closeButton setHidden:YES];
    self.isHighlight = false;
}



@end
