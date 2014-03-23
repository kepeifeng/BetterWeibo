//
//  AKWeiboCommentTableView.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 14-2-15.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKWeiboCommentTableView.h"

@implementation AKWeiboCommentTableView

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

-(void)resizeSubviewsWithOldSize:(NSSize)oldSize{

    NSRange visibleRows = NSMakeRange(0, self.numberOfRows);
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0];
    [self noteHeightOfRowsWithIndexesChanged:[NSIndexSet indexSetWithIndexesInRange:visibleRows]];
    [NSAnimationContext endGrouping];
    

}



@end
