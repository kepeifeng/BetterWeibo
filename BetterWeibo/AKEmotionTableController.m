//
//  AKEmotionTableController.m
//  BetterWeibo
//
//  Created by Kent on 14-1-11.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKEmotionTableController.h"
#import "AKEmotion.h"

@interface AKEmotionTableController ()
@property (strong) NSMutableArray *data;
@property (assign) id initialSelectedObject;
@end

@implementation AKEmotionTableController{

    NSInteger currentSection;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.

        
        self.numberOfColumn = 10;
        self.numberOfRow = 4;
        self.cellSize = NSMakeSize(32, 32);
        [self loadTestData];
        
    }
    return self;
}

-(void)loadTestData{

    NSMutableArray *array = [NSMutableArray array];
    for(NSInteger i=0;i<100;i++){
    
        AKEmotion *emo = [AKEmotion new];
        emo.code = [NSString stringWithFormat:@"emo-%ld", i];
        emo.image = [NSImage imageNamed:@"avatar_default"];
   
        [array addObject:emo];
    }
    
    self.data = [NSMutableArray array];
    
    NSInteger numberOfCells = self.numberOfRow * self.numberOfColumn;
    for(NSInteger i=0; i<=array.count/(self.numberOfRow * self.numberOfColumn); i++) {
        
        NSArray *tmpArray = [array objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(i*numberOfCells, (i<(NSInteger)(array.count/numberOfCells))?(numberOfCells):(array.count%numberOfCells))]];
        
        [self.data addObject:tmpArray];
        
    }
    
    


}

-(void)awakeFromNib{

    NSSize boxMargin = NSMakeSize(0, 0);
    NSSize boxPadding = NSMakeSize(5, 5);
    //Matrix Size
    NSSize viewSize = NSMakeSize((self.cellSize.width+1)*self.numberOfColumn-1,
                                 (self.cellSize.height+1)*self.numberOfRow-1);

    
    NSView *pageView = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, viewSize.width, viewSize.height)];
    
    NSBox *box = [[NSBox alloc] initWithFrame:NSMakeRect(boxMargin.width, boxMargin.height, viewSize.width+boxPadding.width*2 + 4,viewSize.height+boxPadding.height * 2 + 4)];
    box.titlePosition = NSNoTitle;
    box.contentViewMargins = boxPadding;
    
    
    [box addSubview:pageView];

    [self.view addSubview:box];
    
    viewSize = box.frame.size;
    
    viewSize = NSMakeSize(viewSize.width, viewSize.height);
    [self.view setFrameSize:viewSize];
    
    self.emotionViewContainer = box;
    self.pageController.view = pageView;
    

    

    self.pageController.arrangedObjects  = self.data;
    [self _adjustViewSize];

}


-(void)_adjustViewSize{

    NSSize boxMargin = NSMakeSize(5, 5);
    //Matrix Size
    //NSSize viewSize = NSMakeSize((self.cellSize.width+1)*self.numberOfColumn-1,
                                 //  (self.cellSize.height+1)*self.numberOfRow-1);
    
    //[self.pageController.view setFrameSize:viewSize];

    //Box Size
//viewSize = NSMakeSize(viewSize.width + self.emotionViewContainer.contentViewMargins.width*2, viewSize.height+self.emotionViewContainer.contentViewMargins.height*2);

    //[self.emotionViewContainer setFrameSize:viewSize];
    
    
    //viewSize = NSMakeSize(viewSize.width+boxMargin.width*2, viewSize.height + boxMargin.height*2);
    
    //[_popover setContentSize:viewSize];
    //[self.view setFrameSize:viewSize];
    
    
    
    //[self.emotionViewContainer setFrameOrigin:NSMakePoint(boxMargin.width, boxMargin.height)];


}

- (void)_makePopoverIfNeeded {
    if (_popover == nil) {
        // Create and setup our window
        _popover = [[NSPopover alloc] init];
        // The popover retains us and we retain the popover. We drop the popover whenever it is closed to avoid a cycle.
        _popover.contentViewController = self;
        _popover.behavior = NSPopoverBehaviorSemitransient;
        _popover.delegate = self;
    }
}

-(void)popoverWillShow:(NSNotification *)notification{

    //[self _adjustViewSize];

}

-(void)displayEmotionDialogForView:(NSView *)view relativeToRect:(NSRect)rect{
    
    [self _makePopoverIfNeeded];
    [_popover showRelativeToRect:rect ofView:view preferredEdge:NSMinYEdge];
    
    
    
}

-(void)displayEmotionDialogForView:(NSView *)view{

    [self _makePopoverIfNeeded];
    [_popover showRelativeToRect:view.bounds ofView:view preferredEdge:NSMinYEdge];
    

}

+(AKEmotionTableController *)sharedInstance{

    static AKEmotionTableController * gSharedEmotionTableInstance = nil;
    if (gSharedEmotionTableInstance == nil) {
        gSharedEmotionTableInstance = [[[self class] alloc] initWithNibName:@"AKEmotionTableController" bundle:[NSBundle bundleForClass:[self class]]];
    }
    
    return gSharedEmotionTableInstance;

}

@end


@implementation AKEmotionTableController (NSPageControllerDelegate)
- (NSString *)pageController:(NSPageController *)pageController identifierForObject:(id)object {
    return @"picture";
}

- (NSViewController *)pageController:(NSPageController *)pageController viewControllerForIdentifier:(NSString *)identifier {
    
    NSViewController *viewController = [NSViewController new];
    NSButtonCell *buttonCell = [[NSButtonCell alloc]init];
    buttonCell.bezelStyle = NSRoundedBezelStyle;
    [buttonCell setBordered:NO];
    buttonCell.imagePosition = NSImageOnly;
    buttonCell.imageScaling = NSImageScaleProportionallyUpOrDown;
    
    NSMatrix *matrix = [[NSMatrix alloc]initWithFrame:NSMakeRect(0,
                                                                 0,
                                                                 (self.cellSize.width+1)*self.numberOfColumn-1,
                                                                 (self.cellSize.height+1)*self.numberOfRow-1) mode:NSListModeMatrix prototype:buttonCell numberOfRows:self.numberOfRow numberOfColumns:self.numberOfColumn];
    matrix.cellSize = self.cellSize;
    matrix.intercellSpacing = NSMakeSize(1, 1);
    matrix.cellBackgroundColor = [NSColor whiteColor];
    matrix.backgroundColor = [NSColor lightGrayColor];
    matrix.drawsBackground = YES;
    matrix.drawsCellBackground = YES;
    viewController.view = matrix;
    
    
    
    return viewController;
}

-(void)pageController:(NSPageController *)pageController prepareViewController:(NSViewController *)viewController withObject:(id)object {
    // viewControllers may be reused... make sure to reset important stuff like the current magnification factor.
    
    // Normally, we want to reset the magnification value to 1 as the user swipes to other images. However if the user cancels the swipe, we want to leave the original magnificaiton and scroll position alone.
    
    BOOL isRepreparingOriginalView = (self.initialSelectedObject && self.initialSelectedObject == object) ? YES : NO;
    if (!isRepreparingOriginalView) {
        
        //[(NSScrollView*)viewController.view setMagnification:1.0];
    }
    
    NSMatrix *matrix = (NSMatrix *)viewController.view;
    NSArray *array = object;
    
    NSInteger index = 0;
    for(NSInteger i=0;i<[matrix numberOfRows];i++){
        
        for (NSInteger j=0; j<matrix.numberOfColumns; j++) {
            NSButtonCell *cell = [matrix cellAtRow:i column:j];
            
            if (index<array.count) {
            
                AKEmotion *emotion = (AKEmotion *)[array objectAtIndex:index];
                //cell.title = emotion.code;
                cell.image = emotion.image;
            }
            else{
                
                //cell.title = @"";
                cell.image = nil;
            }
            index++;
            
        }
        
    }

    // Since we implement this delegate method, we are reponsible for setting the representedObject.
    viewController.representedObject = object;
}


- (void)pageControllerWillStartLiveTransition:(NSPageController *)pageController {
    // Remember the initial selected object so we can determine when a cancel occurred.
    self.initialSelectedObject = [pageController.arrangedObjects objectAtIndex:pageController.selectedIndex];
}

- (void)pageControllerDidEndLiveTransition:(NSPageController *)pageController {
    [pageController completeTransition];
}

@end
