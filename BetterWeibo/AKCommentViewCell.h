//
//  AKCommentViewCell.h
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-12-13.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "PXListViewCell.h"
#import "AKComment.h"
@interface AKCommentViewCell : PXListViewCell


@property AKComment *comment;
@property (weak) IBOutlet NSTextField *userAliasField;
@property (weak) IBOutlet NSTextField *commentField;

@end
