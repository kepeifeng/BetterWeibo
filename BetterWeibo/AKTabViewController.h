//
//  AKTabViewController.h
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-30.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AKTabButton.h"
#import "AKWeiboManager.h"
#import "AKPanelView.h"

//@class AKTabController;


@protocol AKTabViewControllerDelegate;

//===================== AKTabView ======================
/**
 *  A super class of weibo tab views.
 */
@interface AKTabViewController:NSViewController


//@property NSString *tabTitle;
//@property NSView *view;
@property AKTabButton *button;
@property id<AKTabViewControllerDelegate> delegate;
@property NSArray *leftControls;
@property NSArray *rightControls;
@property AKWeiboManager *weiboManager;
@property NSString *userID;
@property (readonly) NSString *identifier;
@property NSString *title;
@property NSImage *backgroundImage;

//@property IBOutlet AKPanelView *view;


-(void)tabDidActived;
-(void)tabButtonDoubleClicked:(id)sender;
-(void)goToViewOfController:(NSViewController *)viewController;

@end

@protocol AKTabViewControllerDelegate

-(void)tabViewController:(AKTabViewController *)aTabViewController tabButtonClicked:(AKTabButton *)buttonClicked;
-(void)tabViewController:(AKTabViewController *)aTabViewController goToNewViewOfController:(NSViewController *)newViewController;
-(void)goBackToPreviousView:(AKTabViewController *)aTabViewController;

@end