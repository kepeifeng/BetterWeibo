//
//  AKLoadMoreCell.h
//  BetterWeibo
//
//  Created by Kent on 13-12-1.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AKLoadMoreCell : NSTableCellView

@property IBOutlet NSButton *loadMoreButton;

-(IBAction)loadMoreButtonClicked:(id)sender;

@end
