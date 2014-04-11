//
//  AKStatusEditorWindowController.h
//  BetterWeibo
//
//  Created by Kent on 14-1-11.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "INAppStoreWindow.h"
#import "AKStatusTextView.h"
#import "AKImageSelector.h"
#import "AKWeiboManager.h"
#import "AKEmotionTableController.h"



@interface AKStatusEditorWindowController : NSWindowController<NSOpenSavePanelDelegate,AKStatusTextViewDelegate, AKImageSelectorDelegate, AKWeiboManagerDelegate, AKEmotionTableControllerDelegate,AKUserManagerListenerProtocol>

@property (readonly) INAppStoreWindow * myWindow;

@property (nonatomic, retain) NSMutableArray *windowControllers;
@property (strong) IBOutlet NSMatrix *imageMatrix;
@property (strong) NSButton *postButton;
//Comment on or Repost the target status.


- (IBAction)postButtonClicked:(id)sender;
- (IBAction)toolBarClicked:(id)sender;

@property (weak) IBOutlet AKImageSelector *imageSelector;
@property (weak) IBOutlet NSPopUpButton *userSelector;
@property (strong) IBOutlet AKStatusTextView *statusTextView;
@property (strong) IBOutlet NSTextField *countField;

+(instancetype)sharedInstance;

@end
