//
//  AKCommentViewCell.h
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-12-13.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "PXListViewCell.h"
#import "AKComment.h"
#import "AKTextView.h"
#import "AKUserButton.h"

@interface AKCommentViewCell : NSTableCellView


@property AKComment *comment;

@property (nonatomic, retain) IBOutlet AKUserButton *userAvatar;
@property (nonatomic, retain) IBOutlet NSTextField *userAliasField;
@property (nonatomic, retain) IBOutlet AKTextView *commentField;

@end
