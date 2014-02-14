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

        [self loadTestData];
        self.numberOfColumn = 10;
        self.numberOfRow = 4;
        self.cellSize = NSMakeSize(32, 32);
        
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
        
        NSArray *tmpArray = [array objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(i*numberOfCells, (i<(NSInteger)(array.count/numberOfCells))?(self.numberOfRow * self.numberOfColumn):(array.count%i))]];
        
        [self.data addObject:tmpArray];
        
    }
    
    self.pageController.arrangedObjects  = self.data;


}

-(void)_adjustViewSize{

    //Matrix Size
    NSSize viewSize = NSMakeSize((self.cellSize.width+1)*self.numberOfColumn-1,
                                   (self.cellSize.height+1)*self.numberOfRow-1);
    
    //Box Size
    viewSize = NSMakeSize(viewSize.width + self.emotionViewContainer.contentViewMargins.width*2, viewSize.height+self.emotionViewContainer.contentViewMargins.height*2);

    [self.emotionViewContainer setFrameSize:viewSize];
    
    viewSize = NSMakeSize(viewSize.width+5*2, viewSize.height + 5*2);
    [self.view setFrameSize:viewSize];


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
                cell.title = (NSString *)[array objectAtIndex:index];
            }
            else{
                
                cell.title = @"";
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
