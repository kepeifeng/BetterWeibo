//
//  AKStatusBar.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-29.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKStatusBar.h"

@implementation AKStatusBar

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
    
    NSImage *statusBar = [NSImage imageNamed:@"window_normal.png"];;
    
    if(self.window && !self.window.isOnActiveSpace){
        statusBar = [NSImage imageNamed:@"window_outoffucos.png"];
    
    }
    
    
    [statusBar drawInRect:NSMakeRect(0, 0, dirtyRect.size.width, 24) fromRect:NSMakeRect(8, 0, 157, 24) operation:NSCompositeSourceOver fraction:1];
    
    [statusBar drawInRect:NSMakeRect(0, 0, 7, 24) fromRect:NSMakeRect(0, 0, 7, 24) operation:NSCompositeSourceOver fraction:1];
    
    [statusBar drawInRect:NSMakeRect(dirtyRect.size.width - 7, 0, 7, 24) fromRect:NSMakeRect(165, 0, 7, 24) operation:NSCompositeSourceOver fraction:1];
    
    
    //NSLog(@"%@",self.window);
    
    
	
    // Drawing code here.
}

@end
