//
//  AKImageViewer.m
//  BetterWeibo
//
//  Created by Kent on 13-12-11.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKImageViewer.h"
#import "AKImageHelper.h"

@implementation AKImageViewer{

    NSMutableDictionary *_imagesDictionary;
    NSMutableDictionary *_connectionDictionary;
    NSMutableDictionary *_dataDictionary;
    NSMapTable *_connectionDataMap;
    
    

}
@synthesize image = _image;
@synthesize images = _images;
@synthesize index = _index;
@synthesize viewOrigin = _viewOrigin;


- (id)init
{
    self = [super init];
    if (self) {
        self = [super initWithWindowNibName:@"AKImageViewer" owner:self];
        if (self) {
            [self.window orderOut:nil];
            
            
            //Initialize dictionaries before setting index.
            _imagesDictionary = [NSMutableDictionary new];
            _connectionDictionary = [NSMutableDictionary new];
            _dataDictionary = [NSMutableDictionary new];
            _connectionDataMap = [NSMapTable new];
            
            // Initialization code here.
        }
        return self;

    }
    return self;
}
-(id)initWithImage:(NSImage *)image{


    
    self = [super initWithWindowNibName:@"AKImageViewer" owner:self];
    if (self) {
        
        [self.window orderOut:nil];
//        _imagesDictionary = [NSMutableDictionary new];
//        [_imagesDictionary setObject:image forKey:[NSNumber numberWithInteger:0]];
        
        self.image = image;

        // Initialization code here.
    }
    return self;

}

-(id)initWithArray:(NSArray *)imageArray{
    return [self initWithArray:imageArray startAtIndex:0];
}


-(id)initWithArray:(NSArray *)imageArray startAtIndex:(NSInteger)index{
    
    self = [AKImageViewer init];
    if (self) {
        
        self.images = imageArray;
        self.index = index;

        // Initialization code here.
    }
    return self;
    
}

-(void)awakeFromNib{

    if(!self.imageView.cell){
    
        self.imageView.cell = [NSImageCell new];
    }
    
    [self setupTitleBar];
    
    [self.window makeFirstResponder:self.window.contentView];
    
    [self.window.contentView setWantsLayer:YES];
    ((NSView *)self.window.contentView).layer.backgroundColor = CGColorCreateGenericRGB(0.1, 0.1, 0.1, 1);

}


-(void)setupTitleBar{
    

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
    
    [self setupCloseButton];
    [self setupMinimizeButton];
    [self setupZoomButton];

    
}

-(INAppStoreWindow *)myWindow{
    
    return (INAppStoreWindow *)self.window;
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


-(void)clipViewBoundsChanged:(NSNotification *)notification{

    if(!self.topBar.isHidden)
    {
        [self.topBar setHidden:YES];
    }
    if(!self.bottomBar.isHidden){
        [self.bottomBar setHidden:YES];
    }
    
    NSLog(@"ImageViewer - clipViewBoundsChanged");
    
}

-(void)show{
    
    [self showWindow:self];
//    [self.window makeKeyAndOrderFront:nil];
}

#pragma mark - Properties

-(NSImage *)image{
    return _image;
}

-(void)setImage:(NSImage *)image{
    _image =image;
    self.imageView.image = image;
    if(_image){
        self.imageView.frame = NSMakeRect(0, 0, image.size.width, image.size.height);
        [self autoResizeWindowToFitImage];
        //Scroll To Top
        if ([self.scrollView hasVerticalScroller]) {
            self.scrollView.verticalScroller.floatValue = 0;
        }
        
        NSPoint newOrigin = NSMakePoint(0, NSMaxY(((NSView*)self.scrollView.documentView).frame) - self.scrollView.bounds.size.height);
        [self.scrollView.contentView scrollToPoint:newOrigin];
        
        
        //[self.scrollView scrollToBeginningOfDocument:self];
        
    }
}


-(NSArray *)images{
    return _images;
}

-(void)setImages:(NSArray *)images{

    _images = images;
    
    _imagesDictionary = [NSMutableDictionary new];
    _connectionDictionary = [NSMutableDictionary new];
    _dataDictionary = [NSMutableDictionary new];
    _connectionDataMap = [NSMapTable new];
    //self.index = 0;

}

-(NSInteger)index{

    return _index;

}


-(void)setIndex:(NSInteger)index{

    
    if(index<0||index>=_images.count){
        NSBeep();
        return;
    }
    
    _index = index;
    NSImage *image;
    
    [self.previousButton setEnabled:(index>0)];
    [self.nextButton setEnabled:(index<_images.count-1)];
    [self.messageView setHidden:YES];
    
    if(index<_images.count){
    
        if(!(image = [_imagesDictionary objectForKey:[NSNumber numberWithInteger:index]])){
            
            NSString *urlString = [(NSDictionary *)[_images objectAtIndex:index] objectForKey:@"thumbnail_pic"];
            //"thumbnail_pic": "http://ww1.sinaimg.cn/thumbnail/d3976c6ejw1ebbzpeeadwj20d107b74e.jpg"
            //"bmiddle_pic": "http://ww1.sinaimg.cn/bmiddle/d3976c6ejw1ebbzpeeadwj20d107b74e.jpg"
            //"original_pic": "http://ww1.sinaimg.cn/large/d3976c6ejw1ebbzpeeadwj20d107b74e.jpg"
            urlString = [urlString stringByReplacingOccurrencesOfString:@"/thumbnail/" withString:(self.viewOrigin)?@"/large/":@"/bmiddle/"];
            
//            self.imageView.image = nil;
//            self.image = nil;
            [self startLoadingImageFromURL:[NSURL URLWithString:urlString] forIndex:index];
            [_progressIndicator startAnimation:self];
            return;
            
            
        }
        
        self.image = image;
//        self.imageView.image = image;
        [_progressIndicator stopAnimation:self];
        
    
    }
    else{
//        self.imageView.image = nil;
        self.image = nil;
    }

}

-(BOOL)viewOrigin{
    return _viewOrigin;
}

-(void)setViewOrigin:(BOOL)viewOrigin{

    _viewOrigin = viewOrigin;
    NSInteger oldIndex = self.index;
    self.images = self.images;
    
    self.index = oldIndex;

}


-(void)autoResizeWindowToFitImage{

//    NSInteger originWindowTitleBarHeight = self.window.frame.size.height - [(NSView *)self.window.contentView frame].size.height;
    NSRect screenVisibleFrame = [[NSScreen mainScreen] visibleFrame];
//    NSSize screenVisibleFrame.size = [[NSScreen mainScreen] visibleFrame].size;
    NSInteger width = self.image.size.width;
    NSInteger height = self.image.size.height + self.bottomBar.frame.size.height + self.myWindow.titleBarHeight-1;
    NSSize newWindowFrameSize = NSZeroSize;
    newWindowFrameSize.width = MIN(width, screenVisibleFrame.size.width);
    newWindowFrameSize.height = MIN(height, screenVisibleFrame.size.height);
    
    newWindowFrameSize.width = MAX(newWindowFrameSize.width, self.window.minSize.width);
    newWindowFrameSize.height = MAX(newWindowFrameSize.height, self.window.minSize.height);
    
//    windowContentSize.height += self.myWindow.titleBarHeight - originWindowTitleBarHeight;
    
    

    NSRect windowFrame = [self.window frame];
    NSPoint origin = windowFrame.origin;
    origin.x = origin.x + (windowFrame.size.width - newWindowFrameSize.width)/2;
    origin.y = origin.y + (windowFrame.size.height - newWindowFrameSize.height)/2;
    
    origin.x = MAX(origin.x, screenVisibleFrame.origin.x);
    origin.y = MAX(origin.y, screenVisibleFrame.origin.y);
    if(origin.x + newWindowFrameSize.width > screenVisibleFrame.size.width){
        origin.x = screenVisibleFrame.size.width - newWindowFrameSize.width;
    }
    
    if(origin.y + newWindowFrameSize.height>screenVisibleFrame.size.height){
        origin.y = screenVisibleFrame.size.height - (newWindowFrameSize.height + self.myWindow.titleBarHeight>screenVisibleFrame.size.height);
    }
    
//    [self.window setContentSize:windowContentSize];
    //[[self.window animator] setContentSize:windowContentSize];
    [self.window setFrame:NSMakeRect(origin.x, origin.y, newWindowFrameSize.width, newWindowFrameSize.height) display:YES animate:YES];
    

}

-(void)startLoadingImageFromURL:(NSURL *)url forIndex:(NSInteger)index{
    
    if([_connectionDictionary objectForKey:[NSNumber numberWithInteger:index]]){
        return;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if(connection){
    
        NSMutableData *data = [NSMutableData new];
        [_connectionDataMap setObject:data forKey:connection];
        [_connectionDictionary setObject:connection forKey:[NSNumber numberWithInteger:index]];
        
    }
    


}

//传送完成
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSNumber *index;
    for (NSNumber *number in _connectionDictionary.allKeys) {
        if([_connectionDictionary objectForKey:number] == connection){
            index = number;
            break;
        }
    }
    
    NSMutableData *_data = [_connectionDataMap objectForKey:connection];
    
    NSImage *image = [AKImageHelper getImageFromData:_data];
    if(!image){
        image = [NSImage imageNamed:@"image-broken"];
    }
    [_imagesDictionary setObject:image forKey:index];
    
    if([index integerValue] == self.index){
        
        [_progressIndicator stopAnimation:self];
//        self.imageView.image = image;
        self.image = image;
    
    }
    
    [_connectionDataMap removeObjectForKey:connection];
    [_connectionDictionary removeObjectForKey:index];


}



//
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{

    NSMutableData *_data = [_connectionDataMap objectForKey:connection];
    [_data appendData:data];

}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

    [self.messageField setStringValue:@"网络错误，图片无法加载。"];
    [self.messageView setHidden:NO];
    
    
    
    
}

// 無論如何回傳 YES
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace{
    return YES;
}

// 不管那一種 challenge 都相信
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    NSLog(@"received authen challenge");
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}




- (IBAction)retryButtonClicked:(id)sender {
    
    self.index = self.index;
}

- (IBAction)previousButtonClicked:(id)sender {

    self.index--;

}

- (IBAction)nextButtonClicked:(id)sender {
    
    self.index++;
}

- (IBAction)sizeSwitchButtonClicked:(id)sender {
    
    self.viewOrigin =!self.viewOrigin;
    [(NSButtonCell *)[(NSMatrix *)sender selectedCell] setState:self.viewOrigin];
}

- (IBAction)saveButtonClicked:(id)sender {
}

+(instancetype)sharedInstance{
    
    static AKImageViewer *_instance;
    if(!_instance){
        _instance = [AKImageViewer new];
        
    }
    
    return _instance;
    
}

#pragma mark - Image Viewer Window Delegate

-(void)windowReceivedKeyDown:(AKImageViewerWindow *)window keyDown:(NSEvent *)keyDown{
    
    switch( [keyDown keyCode] ) {
    	case 126:	// up arrow
        case 123:	// left arrow
            [self previousButtonClicked:nil];
            break;
    	case 125:	// down arrow
    	case 124:	// right arrow
            [self nextButtonClicked:nil];
//    		NSLog(@"Arrow key pressed!");
    		break;
    	default:
    		NSLog(@"Key pressed: %@", keyDown);
    		break;
    }

    
    //NSLog(@"Key Code = %hu",[keyDown keyCode]);
    

}
@end
