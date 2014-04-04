//
//  AKToolBarItemView.m
//  Wukong
//
//  Created by Kent on 14-4-3.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKToolBarItemView.h"

@implementation AKToolBarItemView

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
    
    NSImage *image = [NSImage imageNamed:@"avatar_default"];
    [image drawInRect:self.bounds];
    
}

-(void)mouseUp:(NSEvent *)theEvent{
    if (self.enclosingToolbarItem) {
        [NSApp sendAction:self.enclosingToolbarItem.action to:self.enclosingToolbarItem.target];
    }
}

@end
