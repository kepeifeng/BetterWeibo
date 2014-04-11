//
//  AKStatusEditorWindowController.m
//  BetterWeibo
//
//  Created by Kent on 14-1-11.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKStatusEditorWindowController.h"
#import "AKNameSenceViewController.h"
#import "AKButton.h"
#import "AKWeiboManager.h"

#define STATUS_PART_HEIGHT 110
#define TOOLBAR_PART_HEIGHT 47
#define IMAGE_THUMBNAIL_SIZE 125
#define IMAGE_THUMBNAIL_MATRIX_MARGIN_V 25
#define IMAGE_THUMBNAIL_MATRIX_MARGIN_H 25


@interface AKStatusEditorWindowController ()

@property (readonly) BOOL isFreezing;

@end

@implementation AKStatusEditorWindowController{

    NSOpenPanel *_openPanel;
    NSMutableArray *_images;
    NSProgressIndicator *_progressIndicator;
    AKEmotionTableController *_emotionController;

}

//@synthesize window = _myWindow;
@synthesize isFreezing = _freezingFlag;


-(id)initWithWindowNibName:(NSString *)windowNibName{
    
    

    self = [super initWithWindowNibName:windowNibName];
    if(self){
    
        [[AKUserManager defaultUserManager] addListener:self];
    
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

-(void)showWindow:(id)sender{

    [super showWindow:sender];
    [self setRandomTestStatus];

}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
//    [self setupTitleBar];
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
    
    [self refreshUserList];
    
    [self setRandomTestStatus];
    
    NSShadow *textShadow = [[NSShadow alloc] init];
    textShadow.shadowBlurRadius = 0;
    textShadow.shadowColor = [NSColor whiteColor];
    textShadow.shadowOffset = NSMakeSize(1, -1);
    self.countField.shadow = textShadow;
}

/**
 *  刷新用户列表中的内容
 */
-(void)refreshUserList{
    
    [self.userSelector.menu removeAllItems];
    
    NSArray *users = [[AKUserManager defaultUserManager] allUserProfiles];
    
    NSInteger index = 0;
    for (AKUserProfile *user in users) {
        NSMenuItem *menuItem = [[NSMenuItem alloc]init];
        
        menuItem.title = user.screen_name;
        NSImage *smallAvatarImage = [user.profileImage copy];
        [smallAvatarImage setSize:NSMakeSize(32, 32)];
        menuItem.image = smallAvatarImage;
        //NSLog(@"UserProfileImageSize:(%f,%f)",user.profileImage.size.width,user.profileImage.size.height);
        menuItem.tag = index;
        
        [self.userSelector.menu addItem:menuItem];
        
        //选中当前用户
        if([[AKUserManager defaultUserManager] currentUserProfile] == user){
            
            [self.userSelector selectItem:menuItem];
            
        }
        index++;
    }
}

-(BOOL)isFreezing{
    return _freezingFlag;
}

-(void)setRandomTestStatus{
    
    static NSArray * quotes;
    if (!quotes) {
        quotes = [NSArray arrayWithObjects:
                  @"Regular naps prevent old age, especially if you take them while driving.",
                  @"I believe we should all pay our tax with a smile. I tried - but they wanted cash.",
                  @"Don't feel bad. A lot of people have no talent.",
                  @"Don't marry the person you want to live with, marry the one you cannot live without, but whatever you do, you'll regret it later.",
                  @"Bad officials are elected by good citizens who do not vote.",
                  @"Laziness is nothing more than the habit of resting before you get tired.",
                  @"Ladies first. Pretty ladies sooner.",
                  @"A successful marriage requires falling in love many times, always with the same person.",
                  @"You are getting old when you enjoy remembering things more than doing them.",
                  @"It's funny when people discuss Love Marriage vs Arranged. It's like asking someone, if suicide is better or being murdered.",
                  @"Have you ever noticed that anybody driving slower than you is an idiot, and anyone going faster than you is a maniac?",
                  @"Everybody wants to go to heaven; but nobody wants to die.",
                  @"Sometimes when I close my eyes, I can't see.",
                  @"The difference between stupidity and genius is that genius has its limits.",
                  @"Autumn is a season followed immediately by looking forward to spring.",
                  @"Who says nothing is impossible? I've been doing nothing for years.",
                  @"Always forgive your enemies - Nothing annoys them so much.",
                  @"If Barbie is so popular, why do you have to buy her friends?",
                  @"When everything's coming your way, you're in the wrong lane.",
                  @"I used to have an open mind but my brains kept falling out.",
                  @"I couldn't repair your brakes, so I made your horn louder.",
                  @"For Sale: Parachute. Only used once, never opened, small stain.",
                  @"Do you have trouble making up your mind? Well, yes or no?",
                  @"If everything seems to be going well, you have obviously overlooked something.",
                  @"Many people quit looking for work when they find a job.",
                  @"When I'm not in my right mind, my left mind gets pretty crowded.",
                  @"Everyone has a photographic memory.  Some just don't have film.",
                  @"You know the speed of light, so what's the speed of dark?",
                  @"Join The Army, Visit exotic places, meet strange people, then kill them.",
                  @"I poured Spot remover on my dog. Now he's gone.",
                  @"Evening news is where they begin with 'Good evening', and then proceed to tell you why it isn't.",
                  @"Before borrowing money from a friend, decide which you need more.(Friend or Money !)",
                  @"Death is hereditary.",
                  @"There are three sides to any argument: your side, my side and the right side.",
                  @"An consultant is someone who takes a subject you understand and makes it sound confusing.",
                  @"Never argue with a fool. People might not know the difference.",
                  @"When you're right, no one remembers. When you're wrong, no one forgets.",
                  @"Cheer up, the worst is yet to come.",
                  @"Always remember that you are absolutely unique. Just like everyone else.",
                  @"Everyone makes mistakes. The trick is to make mistakes when nobody is looking.",
                  @"They say hard work never hurts anybody, but why take the chance.",
                  @"Always borrow money from a pessimist.  He won't expect it back.",
                  @"I like work.  It fascinates me.  I  sit and look at it for hours.",
                  @"If you can't see the bright side of life, polish the dull side.",
                  @"Where there's a will, there are five hundred relatives.",
                  @"Everybody wants to go to heaven, but nobody wants to die.",
                  @"HARD WORK WILL PAY OFF LATER. LAZINESS PAYS OFF NOW!",
                  @"Upon the Advice of My Attorney, My Shirt Bears No Message at This Time",
                  @"Two rights do not make a wrong. They make an airplane. .........Wright brothers.",
                  @"Wrinkled Was Not One of the Things I Wanted to Be When I Grew Up",
                  @"Rehabilitation Is for Quitters",
                  @"FAILURE IS NOT AN OPTION. It comes bundled with the software.",
                  @"A journey of a thousand miles begins with a cash advance",
                  @"STUPIDITY IS NOT A HANDICAP. Park elsewhere!",
                  @"Where there's a will I want to be in it",
                  @"How long is this Beta guy going to keep testing our stuff?",
                  @"FOR SALE -- Iraqi rifle. Never fired. Dropped once.",
                  @"If the shoe fits, buy it.----Imelda Marcos",
                  @"HECK IS WHERE PEOPLE GO WHO DON'T BELIEVE IN GOSH",
                  @"A PICTURE IS WORTH A THOUSAND WORDS--But it uses up a thousand times the memory.",
                  @"Time flies like an arrow. Fruit flies like a banana.",
                  @"The trouble with life is there's no background music.",
                  @"Automobile -A mechanical device that runs up hills and down people.",
                  @"Quoting one is plagiarism. Quoting many is research.", nil];
    
    }
    
    NSInteger randomIndex = arc4random()%(quotes.count);
    NSString *quote = (NSString *)[quotes objectAtIndex:randomIndex];
    self.statusTextView.string = quote;
    [self textDidChange:nil];

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
    
    AKButton *cancelButton = [[AKButton alloc] initWithFrame:NSMakeRect(7, 7, 75, 32)];
    cancelButton.title = @"取消";
    cancelButton.autoresizingMask = NSViewMaxXMargin;
    cancelButton.target = self;
    cancelButton.action = @selector(cancelButtonClicked:);
    [myWindow.titleBarView addSubview:cancelButton];
    
    AKButton *postButton = [[AKButton alloc]initWithFrame:NSMakeRect(myWindow.frame.size.width - 7 - 75, 7, 75, 32)];
    postButton.title = @"发送";
    postButton.target = self;
    postButton.action = @selector(postButtonClicked:);
    postButton.autoresizingMask = NSViewMinXMargin;
    postButton.buttonStyle = AKButtonStyleBlueButton;
    [myWindow.titleBarView addSubview:postButton];
    
    //NSSize indicatorSize = NSMakeSize(32, 32);
    _progressIndicator = [[NSProgressIndicator alloc] initWithFrame:NSMakeRect(0,0,16,16)];
    _progressIndicator.style = NSProgressIndicatorSpinningStyle;
    _progressIndicator.controlSize = NSSmallControlSize;
    [_progressIndicator setDisplayedWhenStopped:NO];
    [_progressIndicator sizeToFit];
    [_progressIndicator stopAnimation:nil];
    NSSize indicatorSize = _progressIndicator.frame.size;
    [_progressIndicator setFrameOrigin:NSMakePoint(postButton.frame.origin.x + (postButton.frame.size.width - indicatorSize.width)/2,
                                                   postButton.frame.origin.y+(postButton.frame.size.height - indicatorSize.height)/2)];
    _progressIndicator.autoresizingMask = NSViewMinXMargin | NSViewMinYMargin | NSViewMaxYMargin;
    
    [myWindow.titleBarView addSubview:_progressIndicator];

    self.postButton = postButton;
    
//    [self setupCloseButton];
//    [self setupMinimizeButton];
//    [self setupZoomButton];
    
    
}

-(void)cancelButtonClicked:(id)sender{

    [self.window orderOut:self];
}

-(void)postButtonClicked:(id)sender{

    if(self.isFreezing){
        return;
    }

    NSInteger count = 140 - self.statusTextView.string.length;
    if(self.statusTextView.string.length<=0 || count<0){
        NSBeep();
        return;
    }
    
    AKUserProfile *selectedUser = [[AKUserManager defaultUserManager] userAtIndex:self.userSelector.selectedItem.tag];
    
    [[AKWeiboManager currentManager] postStatus:self.statusTextView.string withImages:self.imageSelector.allFileURLs forUser:selectedUser callbackTarget:self];
    //[[AKWeiboManager currentManager] postStatus:self.statusTextView.string forUser:selectedUser callbackTarget:self];
    

    [self setFreezing:YES];
    
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

- (IBAction)toolBarClicked:(id)sender {
    
    NSMatrix *toolbar = sender;
    NSInteger selectedIndex = [(NSButtonCell *)(toolbar.selectedCell) tag];

    //Insert Emotion
    if( selectedIndex == 0){
    
        NSButtonCell *buttonCell = (NSButtonCell *)toolbar.selectedCell;
        
        if(!_emotionController){
        
            _emotionController = [[AKEmotionTableController alloc] init];
            _emotionController.delegate = self;
        }
        
        if(_emotionController.isShown){
            [_emotionController closeEmotionDialog];
        }
        else{
        
            [_emotionController displayEmotionDialogForView:toolbar relativeToRect:NSMakeRect(0, 0, buttonCell.cellSize.width, buttonCell.cellSize.height)];
        }
        
        
    
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

#pragma mark - Property


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

+(instancetype )sharedInstance{
    
    static AKStatusEditorWindowController * gSharedInstance = nil;
    if (gSharedInstance == nil) {
        gSharedInstance = [[[self class] alloc] initWithWindowNibName:@"AKStatusEditorWindowController"];
        //        gSharedInstance = [[[self class] alloc] initWithNibName:@"AKStatusEditorWindowController" bundle:[NSBundle bundleForClass:[self class]]];
    }
    
    return gSharedInstance;
    
}

#pragma mark - Status TextView Delegate
-(void)atKeyPressed:(id)textView position:(NSRect)atPosition{
    [[AKNameSenceViewController sharedInstance] displayNameSenceForView:textView relativeToRect:atPosition];
}

-(BOOL)textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector{
    if(commandSelector == @selector(insertNewline:)){
        if(!self.isFreezing){
            
            [self postButtonClicked:nil];
        }
        return YES;
    }
    return NO;
}

-(void)textDidChange:(NSNotification *)notification{
    
    NSInteger countdown = 140 - self.statusTextView.string.length;
    self.countField.stringValue = [NSString stringWithFormat:@"%ld",countdown];
    if(countdown<0){
        self.countField.textColor = [NSColor redColor];
    }
    else{
        self.countField.textColor = [NSColor grayColor];
    }
    
}


/**
 *  设置是否要进入冻结状态
 *
 *  @param flag YES 则进入冻结状态
 */
-(void)setFreezing:(BOOL)flag{

    _freezingFlag = flag;
    if(flag){
    
        [_progressIndicator startAnimation:nil];
    }
    else{
        [_progressIndicator stopAnimation:nil];
    }
    
    //TODO:post button didn't disabled atfer this:
    [self.postButton setEnabled:!flag];
    [self.statusTextView setEditable:!flag];
    [self.imageSelector setEnabled:!flag];
    [self.userSelector setEnabled:!flag];
    

}


-(void)reset{

    [self setFreezing:NO];
    self.statusTextView.string = @"";
    [self.imageSelector removeAllImages];
}

#pragma mark - Emotion Table Controller Delegate
-(void)emotionTable:(AKEmotionTableController *)emotionTable emotionSelected:(AKEmotion *)emotion{

    self.statusTextView.string = [self.statusTextView.string stringByAppendingString:emotion.code];
    [_emotionController closeEmotionDialog];
}

#pragma mark - Weibo Manager Callback Methods

-(void)OnDelegateComplete:(AKWeiboManager*)weiboManager methodOption:(AKMethodAction)methodOption  httpHeader:(NSString *)httpHeader result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask{

    if(methodOption == AKWBOPT_POST_STATUSES_UPDATE || methodOption == AKWBOPT_POST_STATUSES_UPLOAD){
        
        [self.window orderOut:self];
        NSSound *sound = [NSSound soundNamed:@"sent"];
        [sound play];
        [self reset];
    
    }

}

-(void)OnDelegateErrored:(AKWeiboManager *)weiboManager methodOption:(AKMethodAction)methodOption error:(AKError *)error result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask{

    if(methodOption == AKWBOPT_POST_STATUSES_UPDATE || methodOption == AKWBOPT_POST_STATUSES_UPLOAD){
        
        NSBeep();
        //解除冻结
        [self setFreezing:NO];
        
    }
    
}


-(void)OnDelegateWillRelease:(AKWeiboManager *)weiboManager methodOption:(AKMethodAction)methodOption pTask:(AKUserTaskInfo *)pTask{


}

#pragma mark - User Manager Listener
-(void)userProfileDidInserted:(AKUserProfile *)userProfile atIndex:(NSInteger)index{
    [self refreshUserList];
}

-(void)userProfileDidRemoved:(AKUserProfile *)userProfile atIndex:(NSInteger)index{
    [self refreshUserList];
}

-(void)userProfileDidUpdated:(AKUserProfile *)userProfile atIndex:(NSInteger)index{
    [self refreshUserList];
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
    
    [self.imageSelector addImageItemFromFileURL:url];

    return YES;
    
}

@end


