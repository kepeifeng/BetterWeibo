//
//  AKWeiboStatusControlView.m
//  Wukong
//
//  Created by Kent on 10/27/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import "AKWeiboStatusControlView.h"

@implementation AKWeiboStatusControlView

- (instancetype)init
{
    self = [super initWithFrame:NSMakeRect(0, 0, 140, 29) mode:(NSRadioModeMatrix) cellClass:[NSButtonCell class] numberOfRows:1 numberOfColumns:4];
    if (self) {
        self.cellSize = CGSizeMake(35, 29);
        self.intercellSpacing = NSMakeSize(0, 0);
        NSArray * imageFiles = @[@"weibo-toolbar-normal_weibo",@"weibo-toolbar-active_weibo",
                                 @"weibo-toolbar-normal_comment",@"weibo-toolbar-active_comment",
                                 @"weibo-toolbar-normal_fav", @"weibo-toolbar-active_fav",
                                 @"weibo-toolbar-normal_share",@"weibo-toolbar-active_share"];
        
        for (NSInteger i = 0;  i< imageFiles.count/2; i++) {
            
            NSButtonCell * retweetCell = [self cellAtRow:0 column:i];
            retweetCell.image = [NSImage imageNamed:imageFiles[i*2]];
            retweetCell.alternateImage = [NSImage imageNamed:imageFiles[i*2+1]];
            retweetCell.bordered = NO;
            retweetCell.tag = i;
        }
        
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
