//
//  AKRepostedWeiboView.m
//  BetterWeibo
//
//  Created by Kent on 13-10-8.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKRepostedWeiboView.h"

@implementation AKRepostedWeiboView

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
    
    //NSRect repostedWeiboDrawingRect = self.repostedWeiboView.bounds;
    NSImage *repostedWeiboViewBackground = [NSImage imageNamed:@"repost-background-frame"];
    
    //NSLog(@"(%f, %f, %f, %f", repostedWeiboDrawingRect.origin.x, repostedWeiboDrawingRect.origin.y
    //      , repostedWeiboDrawingRect.size.width, repostedWeiboDrawingRect.size.height);
    
    //Top
    [repostedWeiboViewBackground drawInRect:NSMakeRect(0, dirtyRect.size.height - 8, dirtyRect.size.width, 8) fromRect:NSMakeRect(0, 49, 81, 8) operation:NSCompositeSourceOver fraction:1];
    [repostedWeiboViewBackground drawInRect:NSMakeRect(0, 14, dirtyRect.size.width, dirtyRect.size.height - 8 - 14) fromRect:NSMakeRect(0, 14, 81, 34) operation:NSCompositeSourceOver fraction:1];
    [repostedWeiboViewBackground drawInRect:NSMakeRect(0, 0, 50, 14) fromRect:NSMakeRect(0, 0, 50, 14) operation:NSCompositeSourceOver fraction:1];
    [repostedWeiboViewBackground drawInRect:NSMakeRect(50, 0, dirtyRect.size.width - 50, 14) fromRect:NSMakeRect(50, 0, 31, 14) operation:NSCompositeSourceOver fraction:1];
    

}

@end
