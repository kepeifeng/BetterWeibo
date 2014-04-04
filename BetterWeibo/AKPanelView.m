//
//  AKPanelView.m
//  BetterWeibo
//
//  Created by Kent on 13-12-9.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKPanelView.h"

@interface AKPanelView()
@property NSColor *backgroundColor;

@end

@implementation AKPanelView{

}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
//        self.wantsLayer = YES;
//        self.layer.backgroundColor = CGColorCreateGenericRGB(0.1, 0, 0, 1);
        self.backgroundColor = [NSColor colorWithPatternImage:[NSImage imageNamed:@"app_content_background"]];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code here.
        self.backgroundColor = [NSColor colorWithPatternImage:[NSImage imageNamed:@"app_content_background"]];
//        self.wantsLayer = YES;
//        self.layer.backgroundColor = CGColorCreateGenericRGB(0.1, 0, 0, 1);
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    if(self.backgroundColor){
        [self.backgroundColor setFill];
        [[NSBezierPath bezierPathWithRect:self.bounds] fill];
    }
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

//-(NSView *)hitTest:(NSPoint)aPoint{
//
//    return nil;
//}


-(void)scrollWheel:(NSEvent *)theEvent{


}

-(void)mouseDown:(NSEvent *)theEvent{

}

-(BOOL)acceptsFirstResponder{
    return NO;
}

//-(void)viewDidMoveToSuperview{
//
//    NSLog(@"AKPanelView - viewDidMoveToSuperview");
//    [super viewDidMoveToSuperview];
//}
//
//-(void)viewDidMoveToWindow{
//
//    NSLog(@"AKPanelView - viewDidMoveToWindow");
//    [super viewDidMoveToWindow];
//}
@end
