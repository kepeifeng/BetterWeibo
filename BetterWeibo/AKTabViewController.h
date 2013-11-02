//
//  AKTabViewController.h
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-30.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AKTabButton.h"

//@class AKTabController;


@protocol AKTabViewControllerDelegate;

//===================== AKTabView ======================
@interface AKTabViewController:NSViewController<NSUserInterfaceItemIdentification>

//@property NSString *tabTitle;
//@property NSView *view;
@property AKTabButton *button;
@property id<AKTabViewControllerDelegate> delegate;
@property NSArray *leftControls;
@property NSArray *rightControls;




-(void)tabButtonClicked:(id)sender;




@end

@protocol AKTabViewControllerDelegate

-(void)tabViewController:(AKTabViewController *)aTabViewController tabButtonClicked:(AKTabButton *)buttonClicked;
-(void)tabViewController:(AKTabViewController *)aTabViewController goToNewView:(NSView *)newView;
-(void)goBackToPreviousView:(AKTabViewController *)aTabViewController;

@end