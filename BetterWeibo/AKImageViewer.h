//
//  AKImageViewer.h
//  BetterWeibo
//
//  Created by Kent on 13-12-11.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AKImageViewer : NSWindowController<NSURLConnectionDelegate, NSURLConnectionDataDelegate>{


    IBOutlet NSProgressIndicator *_progressIndicator;

}


-(id)initWithImage:(NSImage *)image;
-(id)initWithArray:(NSArray *)imageArray;
-(id)initWithArray:(NSArray *)imageArray startAtIndex:(NSInteger)index;

-(void)show;
@property NSImage *image;
@property NSArray *images;

@property NSInteger index;

//@property (strong) IBOutlet NSPanel *window;
@property (weak) IBOutlet NSImageView *imageView;

@property (strong) IBOutlet NSButtonCell *previousButton;
@property (strong) IBOutlet NSButtonCell *nextButton;
@property (strong) IBOutlet NSTextField *messageField;
@property (strong) IBOutlet NSButton *retryButton;

- (IBAction)retryButtonClicked:(id)sender;
@property (strong) IBOutlet NSView *messageView;


- (IBAction)previousButtonClicked:(id)sender;
- (IBAction)nextButtonClicked:(id)sender;
- (IBAction)sizeSwitchButtonClicked:(id)sender;
- (IBAction)saveButtonClicked:(id)sender;


@end
