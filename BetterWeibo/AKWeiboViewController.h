//
//  AKWeiboViewController.h
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-30.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AKTabControl.h"
#import "AKTabViewController.h"
#import "AKWeiboTableCellView.h"
#import "PXListViewDelegate.h"
#import "NS(Attributed)String+Geometrics.h"


@interface AKWeiboViewController : AKTabViewController< NSTableViewDataSource,NSTableViewDelegate>

@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSScrollView *scrollView;


@end
