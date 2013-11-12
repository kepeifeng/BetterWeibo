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
#import "AKTabView.h"
#import "AKWeibo.h"
#import "AKWeiboFactory.h"
#import "AKWeiboManager.h"

@protocol AKWeiboManagerDelegate;

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    
#pragma mark - Private Variables
    
    IBOutlet AKTabView * tabView;

}

@property (assign) IBOutlet INAppStoreWindow *window;

@property (nonatomic, retain) NSMutableArray *windowControllers;


@property (weak) IBOutlet NSView *loginView;

@property (weak) IBOutlet NSButton *loginButton;

- (IBAction)loginButtonClicked:(id)sender;
- (IBAction)addAccountClicked:(id)sender;


@end
