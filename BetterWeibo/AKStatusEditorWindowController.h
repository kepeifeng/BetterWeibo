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

@interface AKStatusEditorWindowController : NSWindowController<NSOpenSavePanelDelegate,AKStatusTextViewDelegate>
@property (assign) IBOutlet INAppStoreWindow *window;

@property (nonatomic, retain) NSMutableArray *windowControllers;
@property (strong) IBOutlet NSMatrix *imageMatrix;
@property (strong) IBOutlet NSButton *postButton;

- (IBAction)postButtonClicked:(id)sender;
- (IBAction)toolBarClicked:(id)sender;
- (IBAction)imageMatrixClicked:(id)sender;


@end
