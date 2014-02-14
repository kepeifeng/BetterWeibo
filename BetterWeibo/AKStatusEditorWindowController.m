//
//  AKStatusEditorWindowController.m
//  BetterWeibo
//
//  Created by Kent on 14-1-11.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKStatusEditorWindowController.h"
#import "AKEmotionTableController.h"
#import "AKNameSenceViewController.h"

@interface AKStatusEditorWindowController ()

@end

@implementation AKStatusEditorWindowController{

    NSOpenPanel *_openPanel;
    NSMutableArray *_images;

}

@synthesize window = _myWindow;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    [self setupTitleBar];
    _images = [NSMutableArray array];
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}


-(void)setupTitleBar{
    
    
    self.windowControllers = [NSMutableArray array];
    self.window.backgroundColor = [NSColor blackColor];
    // The class of the window has been set in INAppStoreWindow in Interface Builder
    self.window.trafficLightButtonsLeftMargin = 12.0;
    self.window.fullScreenButtonRightMargin = 7.0;
    self.window.centerFullScreenButton = YES;
    self.window.titleBarHeight = 32.0;
    self.window.verticallyCenterTitle = YES;
    self.window.titleTextLeftMargin = 23.0;
    self.window.titleTextColor = [NSColor colorWithCalibratedWhite:0.88 alpha:1];
    self.window.titleBarDrawingBlock = ^(BOOL drawsAsMainWindow, CGRect drawingRect, CGPathRef clippingPath) {
        
        NSImage *windowImage ;
        
        
        CGContextRef ctx = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
        CGContextAddPath(ctx, clippingPath);
        CGContextClip(ctx);
        
        //        NSGradient *gradient = nil;
        if (drawsAsMainWindow) {
            windowImage = [NSImage imageNamed:@"window_normal.png"];
            //gradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedRed:0 green:0.319 blue:1 alpha:1]
            //                                       endingColor:[NSColor colorWithCalibratedRed:0 green:0.627 blue:1 alpha:1]];
            //[[NSColor darkGrayColor] setFill];
        } else {
            
            windowImage = [NSImage imageNamed:@"window_outoffocus.png"];
            // set the default non-main window gradient colors
            //
        }
        
        
        //Drawing Title Bar's Middle Part
        [windowImage drawInRect:drawingRect fromRect:NSMakeRect(82, 42, 82, 46) operation:NSCompositeSourceOver fraction:1];
        
        //Drawing Title Bar's Left Part
        [windowImage drawInRect:NSMakeRect(0, 0, 82, 46) fromRect:NSMakeRect(0, 42, 82, 46) operation:NSCompositeSourceOver fraction:1];
        
        //Drawing Title Bar's Right Part
        [windowImage drawInRect:NSMakeRect(drawingRect.size.width - 7, 0, 7, 46) fromRect:NSMakeRect(165, 42, 7, 46) operation:NSCompositeSourceOver fraction:1];
        
    };
    
    self.window.showsTitle = YES;
    [self setupCloseButton];
    [self setupMinimizeButton];
    [self setupZoomButton];
    
    
}


- (void)setupCloseButton {
    INWindowButton *closeButton = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
    closeButton.activeImage = [NSImage imageNamed:@"close-active-color.tiff"];
    closeButton.activeNotKeyWindowImage = [NSImage imageNamed:@"close-activenokey-color.tiff"];
    closeButton.inactiveImage = [NSImage imageNamed:@"close-inactive-disabled-color.tiff"];
    closeButton.pressedImage = [NSImage imageNamed:@"close-pd-color.tiff"];
    closeButton.rolloverImage = [NSImage imageNamed:@"close-rollover-color.tiff"];
    
    self.window.closeButton = closeButton;
    //
    //    closeButton.target = self;
    //    closeButton.action = @selector(closeButtonClicked:);
}


-(void)closeButtonClicked:(id)sender{
    
    //    NSLog(@"close button clicked");
    [self.window orderOut:sender];
    
}

- (void)setupMinimizeButton {
    INWindowButton *button = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
    button.activeImage = [NSImage imageNamed:@"minimize-active-color.tiff"];
    button.activeNotKeyWindowImage = [NSImage imageNamed:@"minimize-activenokey-color.tiff"];
    button.inactiveImage = [NSImage imageNamed:@"minimize-inactive-disabled-color.tiff"];
    button.pressedImage = [NSImage imageNamed:@"minimize-pd-color.tiff"];
    button.rolloverImage = [NSImage imageNamed:@"minimize-rollover-color.tiff"];
    self.window.minimizeButton = button;
}

- (void)setupZoomButton {
    INWindowButton *button = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
    button.activeImage = [NSImage imageNamed:@"zoom-active-color.tiff"];
    button.activeNotKeyWindowImage = [NSImage imageNamed:@"zoom-activenokey-color.tiff"];
    button.inactiveImage = [NSImage imageNamed:@"zoom-inactive-disabled-color.tiff"];
    button.pressedImage = [NSImage imageNamed:@"zoom-pd-color.tiff"];
    button.rolloverImage = [NSImage imageNamed:@"zoom-rollover-color.tiff"];
    self.window.zoomButton = button;
}



- (IBAction)postButtonClicked:(id)sender {
}



- (IBAction)toolBarClicked:(id)sender {
    
    NSMatrix *toolbar = sender;
    NSInteger selectedIndex = [(NSButtonCell *)(toolbar.selectedCell) tag];

    //Insert Emotion
    if( selectedIndex == 0){
    
        [[AKEmotionTableController sharedInstance] displayEmotionDialogForView:toolbar.selectedCell];
        
    
    }
    //Insert Images
    else if (selectedIndex == 1){
    
        if(!_openPanel){
            _openPanel = [NSOpenPanel openPanel];
        }
        
        _openPanel.delegate = self;
        _openPanel.canChooseDirectories = NO;
        _openPanel.canChooseFiles = YES;
        _openPanel.allowsMultipleSelection = YES;
        _openPanel.allowedFileTypes = [NSArray arrayWithObjects:@"jpg",@"jpeg",@"png",@"gif", nil];
        _openPanel.allowsOtherFileTypes = NO;
        [_openPanel runModal];
    
    }
    //Insert Topic
    else if (selectedIndex == 2){
    
        
    }
    
}

- (IBAction)imageMatrixClicked:(id)sender {
}

#pragma mark - Name Sence View Controller
-(void)atKeyPressed:(id)textView position:(NSRect)atPosition{
    
    
    [[AKNameSenceViewController sharedInstance] displayNameSenceForView:textView relativeToRect:atPosition];
    //    [self _makePopoverIfNeeded];
    
    
}

@end

#pragma mark - Open Save Panel Delegate

@implementation AKStatusEditorWindowController (NSOpenSavePanelDelegate)

-(BOOL)panel:(id)sender validateURL:(NSURL *)url error:(NSError **)outError{
    
    NSOpenPanel *openPanel = sender;
    if(openPanel.URLs.count >= 9-_images.count)
    {
        *outError = [[NSError alloc]initWithDomain:@"魂淡！图片文件数量最多不能超过九个！" code:0 userInfo:nil];
        
        return NO;
    }
    
    [_images addObject:[[NSImage alloc] initWithContentsOfURL:url]];
    return YES;
    
}

@end

