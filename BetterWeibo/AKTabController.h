//
//  AKTabController.h
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-29.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AKTabButton.h"
#import "AKWeiboViewController.h"
#import "AKTabViewController.h"
#import "AKTabButton.h"

//@class AKTabViewController;

//===================== AKTabController =====================

@interface AKTabController : NSView <AKTabViewControllerDelegate>

@property NSColor *customBackgroundColor;
@property NSMutableArray *tabViewControllers;
@property IBOutlet NSTabView *targetTabView;

-(void)addViewController:(AKTabViewController *)viewController;

@end
