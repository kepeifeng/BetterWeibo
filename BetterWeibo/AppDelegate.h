//
//  AppDelegate.h
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-28.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "INAppStoreWindow.h"
#import "AKWindowController.h"
#import "INWindowButton.h"
#import "AKTabController.h"
#import "AKWeibo.h"
#import "AKWeiboFactory.h"
#import "AKWeiboManager.h"

@protocol AKWeiboManagerDelegate;

@interface AppDelegate : NSObject <NSApplicationDelegate, AKWeiboManagerDelegate>{
    
#pragma mark - Private Variables


}

@property (assign) IBOutlet INAppStoreWindow *window;

@property (nonatomic, retain) NSMutableArray *windowControllers;

@property (weak) IBOutlet AKTabController *tabController;

@property (weak) IBOutlet NSView *loginView;

@property (weak) IBOutlet NSButton *loginButton;

- (IBAction)loginButtonClicked:(id)sender;


@end
