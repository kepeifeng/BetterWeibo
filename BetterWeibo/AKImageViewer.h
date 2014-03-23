//
//  AKImageViewer.h
//  BetterWeibo
//
//  Created by Kent on 13-12-11.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AKView.h"
#import "INAppStoreWindow.h"
#import "AKImageViewerWindow.h"
@interface AKImageViewer : NSWindowController<NSURLConnectionDelegate, NSURLConnectionDataDelegate,AKImageViewerWindowDelegate>{


    IBOutlet NSProgressIndicator *_progressIndicator;

}


-(id)initWithImage:(NSImage *)image;
-(id)initWithArray:(NSArray *)imageArray;
-(id)initWithArray:(NSArray *)imageArray startAtIndex:(NSInteger)index;

-(void)show;
@property NSImage *image;
@property NSArray *images;
@property BOOL viewOrigin;
@property NSInteger index;

@property (readonly) INAppStoreWindow * myWindow;

//@property (strong) IBOutlet NSPanel *window;
@property (weak) IBOutlet NSImageView *imageView;

@property (strong) IBOutlet NSButtonCell *previousButton;
@property (strong) IBOutlet NSButtonCell *nextButton;
@property (strong) IBOutlet NSTextField *messageField;
@property (strong) IBOutlet NSButton *retryButton;
@property (strong) IBOutlet NSScrollView *scrollView;
@property (strong) IBOutlet AKView *topBar;
@property (strong) IBOutlet AKView *bottomBar;

- (IBAction)retryButtonClicked:(id)sender;
@property (strong) IBOutlet NSView *messageView;


- (IBAction)previousButtonClicked:(id)sender;
- (IBAction)nextButtonClicked:(id)sender;
- (IBAction)sizeSwitchButtonClicked:(id)sender;
- (IBAction)saveButtonClicked:(id)sender;

+(instancetype)sharedInstance;

@end
