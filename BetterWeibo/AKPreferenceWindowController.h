//
//  AKPreferenceWindowController.h
//  BetterWeibo
//
//  Created by Kent on 14-3-24.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DASelectableToolbarController.h"
#import "AKUserManager.h"
//#import "INAppStoreWindow.h"
//#import "INWindowButton.h"

@class MASShortcutView;

extern NSString *const AKPreferenceKeyShortcutNewStatus;

@interface AKPreferenceWindowController : NSWindowController<NSTableViewDataSource, NSTableViewDelegate,AKUserManagerListenerProtocol>
//@property (assign) IBOutlet INAppStoreWindow *window;
@property (nonatomic, retain) NSMutableArray *windowControllers;

@property (weak) IBOutlet DASelectableToolbarController *tabView;
@property (weak) IBOutlet NSTableView *userTableView;
- (IBAction)userModifyControlClicked:(id)sender;
@property (nonatomic,weak) IBOutlet MASShortcutView *statusShortcutView;

@end
