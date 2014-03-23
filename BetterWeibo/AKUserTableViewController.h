//
//  AKUserTableViewController.h
//  BetterWeibo
//
//  Created by Kent on 14-3-7.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AKTabViewController.h"
#import "PXListViewDelegate.h"
#import "NS(Attributed)String+Geometrics.h"
#import "EQSTRScrollView.h"
#import "AKWeiboManager.h"
#import "AKTextView.h"
#import "AKUserProfile.h"

typedef NS_ENUM(NSUInteger, AKUserTableViewType) {
    
    AKUserTableViewTypeFollower,
    AKUserTableViewTypeFollowing,
    AKUserTableViewTypeSearch

};

@interface AKUserTableViewController : AKTabViewController< NSTableViewDataSource,NSTableViewDelegate, AKWeiboManagerDelegate>
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet EQSTRScrollView *scrollView;

@property (readonly) NSString *searchQuery;
@property (readonly) AKUserProfile *user;
@property (readonly) AKUserTableViewType tableViewType;


-(void)searchUser:(NSString *)searchQuery;
-(void)followerListOfUser:(AKUserProfile *)user;
-(void)followingListOfUser:(AKUserProfile *)user;


-(IBAction)followButtonClicked:(id)sender;

@end
