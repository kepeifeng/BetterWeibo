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
#import "AKUserManager.h"

#define STATUS_PART_HEIGHT 110
#define TOOLBAR_PART_HEIGHT 47
#define IMAGE_THUMBNAIL_SIZE 125
#define IMAGE_THUMBNAIL_MATRIX_MARGIN_V 25
#define IMAGE_THUMBNAIL_MATRIX_MARGIN_H 25


@interface AKStatusEditorWindowController ()

@end

@implementation AKStatusEditorWindowController{

    NSOpenPanel *_openPanel;
    NSMutableArray *_images;

}

//@synthesize window = _myWindow;

-(id)initWithWindowNibName:(NSString *)windowNibName{

    self = [super initWithWindowNibName:windowNibName];
    if(self){
    
        
    
    }
    return self;

}


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
//    _images = [NSMutableArray array];
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(void)awakeFromNib{

    [self setupTitleBar];
    
    self.imageSelector.numberOfColumns = 3;
    self.imageSelector.numberOfRows = 3;
    self.imageSelector.cellSize = NSMakeSize(130, 130);
    self.imageSelector.delegate = self;
    
    [self adjustPosition];
    
    NSArray *users = [[AKUserManager defaultUserManager] allUserProfiles];
    for (AKUserProfile *user in users) {
        NSMenuItem *menuItem = [[NSMenuItem alloc]init];
        
        menuItem.title = user.screen_name;
        menuItem.image = user.profileImage;
        
        [self.userSelector.menu addItem:menuItem];
    }
    
    
    
    
    
    

}

-(INAppStoreWindow *)myWindow{

    return (INAppStoreWindow *)self.window;
}

-(void)setupTitleBar{
    
    
    self.windowControllers = [NSMutableArray array];
    self.window.backgroundColor = [NSColor whiteColor];
    // The class of the window has been set in INAppStoreWindow in Interface Builder
    INAppStoreWindow *myWindow = (INAppStoreWindow *)self.window;
    myWindow.trafficLightButtonsLeftMargin = 12.0;
    myWindow.fullScreenButtonRightMargin = 7.0;
    myWindow.centerFullScreenButton = YES;
    myWindow.titleBarHeight = 46.0;
    myWindow.verticallyCenterTitle = YES;
    myWindow.titleTextLeftMargin = 0;
    myWindow.titleTextColor = [NSColor colorWithCalibratedWhite:0.88 alpha:1];
    NSShadow *titleTextShadow = [[NSShadow alloc] init];
    
    titleTextShadow.shadowBlurRadius = 0;
    titleTextShadow.shadowColor = [NSColor blackColor];
    titleTextShadow.shadowOffset = NSMakeSize(-1, 1);
    
    myWindow.titleTextShadow = titleTextShadow;
    myWindow.titleBarDrawingBlock = ^(BOOL drawsAsMainWindow, CGRect drawingRect, CGPathRef clippingPath) {
        
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
        
        NSInteger y = windowImage.size.height - self.myWindow.titleBarHeight;
        
        //Drawing Title Bar's Middle Part
        [windowImage drawInRect:drawingRect fromRect:NSMakeRect(82, y, 83, self.myWindow.titleBarHeight) operation:NSCompositeSourceOver fraction:1];
        
        //Drawing Title Bar's Left Part
        [windowImage drawInRect:NSMakeRect(0, 0, 80, self.myWindow.titleBarHeight) fromRect:NSMakeRect(0, y, 80, self.myWindow.titleBarHeight) operation:NSCompositeSourceOver fraction:1];
        
        //Drawing Title Bar's Right Part
        [windowImage drawInRect:NSMakeRect(drawingRect.size.width - 7, 0, 7, self.myWindow.titleBarHeight) fromRect:NSMakeRect(165, y, 7, self.myWindow.titleBarHeight) operation:NSCompositeSourceOver fraction:1];
        
    };
    
    self.myWindow.showsTitle = YES;
    
    NSButton *cancelButton = [[NSButton alloc] initWithFrame:NSMakeRect(7, 7, 75, 32)];
    cancelButton.title = @"取消";
    cancelButton.autoresizingMask = NSViewMaxXMargin;
    [myWindow.titleBarView addSubview:cancelButton];
    
    NSButton *postButton = [[NSButton alloc]initWithFrame:NSMakeRect(myWindow.frame.size.width - 7 - 75, 7, 75, 32)];
    postButton.title = @"发送";
    postButton.autoresizingMask = NSViewMinXMargin;
    [myWindow.titleBarView addSubview:postButton];
    
//    [self setupCloseButton];
//    [self setupMinimizeButton];
//    [self setupZoomButton];
    
    
}


- (void)setupCloseButton {
    INWindowButton *closeButton = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
    closeButton.activeImage = [NSImage imageNamed:@"close-active-color.tiff"];
    closeButton.activeNotKeyWindowImage = [NSImage imageNamed:@"close-activenokey-color.tiff"];
    closeButton.inactiveImage = [NSImage imageNamed:@"close-inactive-disabled-color.tiff"];
    closeButton.pressedImage = [NSImage imageNamed:@"close-pd-color.tiff"];
    closeButton.rolloverImage = [NSImage imageNamed:@"close-rollover-color.tiff"];
    
    self.myWindow.closeButton = closeButton;
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
    
    self.myWindow.minimizeButton = button;
}

- (void)setupZoomButton {
    INWindowButton *button = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
    button.activeImage = [NSImage imageNamed:@"zoom-active-color.tiff"];
    button.activeNotKeyWindowImage = [NSImage imageNamed:@"zoom-activenokey-color.tiff"];
    button.inactiveImage = [NSImage imageNamed:@"zoom-inactive-disabled-color.tiff"];
    button.pressedImage = [NSImage imageNamed:@"zoom-pd-color.tiff"];
    button.rolloverImage = [NSImage imageNamed:@"zoom-rollover-color.tiff"];
    self.myWindow.zoomButton = button;
}



- (IBAction)postButtonClicked:(id)sender {
}



- (IBAction)toolBarClicked:(id)sender {
    
    NSMatrix *toolbar = sender;
    NSInteger selectedIndex = [(NSButtonCell *)(toolbar.selectedCell) tag];

    //Insert Emotion
    if( selectedIndex == 0){
    
        NSButtonCell *buttonCell = (NSButtonCell *)toolbar.selectedCell;
        
        [[AKEmotionTableController sharedInstance] displayEmotionDialogForView:toolbar relativeToRect:NSMakeRect(0, 0, buttonCell.cellSize.width, buttonCell.cellSize.height)];
        
    
    }
    //Insert Images
    else if (selectedIndex == 1){
    
        [self _activeOpenPanel];
        [self adjustPosition];
        return;
    
    }
    //Insert Topic
    else if (selectedIndex == 2){
    
        
    }
    
}

-(void)_activeOpenPanel{
    
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

#pragma mark - Image Selector

-(void)imageSelector:(AKImageSelector *)imageSelector numberOfImagesChanged:(NSInteger)numberOfImage{
    
    [self adjustPosition];

}

-(void)imageSelector:(AKImageSelector *)imageSelector addButtonClicked:(NSButton *)addButton{

    [self _activeOpenPanel];
    
}

-(void)imageSelector:(AKImageSelector *)imageSelector imageItemClicked:(AKImageItem *)imageItem{


}



-(void)adjustPosition{

    NSSize normalContentSize = NSMakeSize(394, 106 + 47 + self.myWindow.titleBarHeight - 22);
    
    NSSize contentSize = normalContentSize;
    NSInteger imageSelectorHeight = 0;
    
    
    if(self.imageSelector.count > 0){
        
        imageSelectorHeight = ((self.imageSelector.count / self.imageSelector.numberOfColumns)+1) * self.imageSelector.cellSize.height;
        [self.imageSelector setHidden:NO];
    }
    else{
        
        [self.imageSelector setHidden:YES];
    }
    
        contentSize.height += imageSelectorHeight;
        [self.window setContentSize:contentSize];

        [self.imageSelector setFrame:NSMakeRect(0, 0, contentSize.width, imageSelectorHeight)];
    


    
}


#pragma mark - Name Sence View Controller
-(void)atKeyPressed:(id)textView position:(NSRect)atPosition{
    
    
    [[AKNameSenceViewController sharedInstance] displayNameSenceForView:textView relativeToRect:atPosition];
    //    [self _makePopoverIfNeeded];
    
    
}

+(instancetype )sharedInstance{
    
    static AKStatusEditorWindowController * gSharedInstance = nil;
    if (gSharedInstance == nil) {
        gSharedInstance = [[[self class] alloc] initWithWindowNibName:@"AKStatusEditorWindowController"];
//        gSharedInstance = [[[self class] alloc] initWithNibName:@"AKStatusEditorWindowController" bundle:[NSBundle bundleForClass:[self class]]];
    }
    
    return gSharedInstance;
    
    
    
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
    
    [self.imageSelector addImage:[[NSImage alloc] initWithContentsOfURL:url]];
    //[_images addObject:[[NSImage alloc] initWithContentsOfURL:url]];
    return YES;
    
}

@end


