//
//  AKWeiboDetailViewController.h
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-10-2.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AKWeiboStatus.h"
#import "PXListView.h"
#import "AKTabViewController.h"
#import "AKWeiboStatusDetailView.h"
#import "AKWeiboManager.h"

@interface AKWeiboDetailViewController : AKTabViewController<PXListViewDelegate, AKWeiboManagerDelegate, NSTableViewDataSource, NSTableViewDelegate>{



}

@property AKWeiboStatus *status;
@property IBOutlet AKWeiboStatusDetailView *statusDetailView;
- (IBAction)tabBarSelectionChanged:(id)sender;

@end
