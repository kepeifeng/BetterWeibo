//
//  AKTableRowView.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-10-8.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKTableRowView.h"

@implementation AKTableRowView

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
	
    // Drawing code here.
}


-(void)drawSelectionInRect:(NSRect)dirtyRect{

    if(self.selectionHighlightStyle != NSTableViewSelectionHighlightStyleNone){

        NSColor *startColor = [NSColor colorWithCalibratedRed:(231/255.0) green:(244/255.0) blue:(255/255.0) alpha:1];
        NSColor *endColor = [NSColor colorWithCalibratedRed:(204/255.0) green:(230/255.0) blue:(255/255.0) alpha:1];
        NSGradient *gradient = [[NSGradient alloc]initWithStartingColor:startColor endingColor:endColor];
        [gradient drawInRect:dirtyRect angle:90];
    
    }

}

@end
