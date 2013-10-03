//
//  AKTabController.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-29.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//


#import "AKTabController.h"


@implementation AKTabController{
    
#pragma mark - Private Variables
    NSMatrix *buttonMatrix;
    CGFloat buttonMatrixTopMargin;
    NSMutableDictionary *tabViewItemAndControllerDictionary;
    
}


#pragma mark - Property Synthesize
@synthesize tabViewControllers = _tabViewControllers;




- (id)initWithFrame:(NSRect)frame
{

    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        self.customBackgroundColor = [NSColor colorWithPatternImage:[NSImage imageNamed:@"tab-control.png"]];
        
        
        
        _tabViewControllers = [[NSMutableArray alloc]initWithCapacity:7];
        tabViewItemAndControllerDictionary = [[NSMutableDictionary alloc]init];
        

        NSSize buttonMatrixSize = NSMakeSize(60, 490);
        NSRect buttonMatrixFrame = NSMakeRect(0,0, buttonMatrixSize.width, buttonMatrixSize.height);
        
        buttonMatrixTopMargin = 10;
        buttonMatrix = [[NSMatrix alloc]initWithFrame:buttonMatrixFrame mode:NSRadioModeMatrix cellClass:[AKTabButton class] numberOfRows:0 numberOfColumns:1];
        buttonMatrix.mode = NSRadioModeMatrix;
        


        buttonMatrix.autorecalculatesCellSize = NO;
        buttonMatrix.autosizesCells = YES;
        buttonMatrix.intercellSpacing = NSMakeSize(0, 0);
        buttonMatrix.cellSize = NSMakeSize(49, 48);
        

        

        
       // [buttonMatrix addRow];
//        
//        buttonMatrix.backgroundColor = [NSColor whiteColor];
//        buttonMatrix.drawsBackground = YES;
        [buttonMatrix setAction:@selector(rowChanged:)];
        [buttonMatrix setTarget:self];
        [self addSubview:buttonMatrix];
        [buttonMatrix setFrameOrigin:NSMakePoint((self.bounds.size.width - buttonMatrixSize.width)/2, self.bounds.size.height - (buttonMatrixSize.height + buttonMatrixTopMargin))];
//        [buttonMatrix setFrameOrigin:NSMakePoint(
//                                            (NSWidth([self bounds]) - NSWidth([buttonMatrix frame])) / 2,
//                                            (NSHeight([self bounds]) - NSHeight([buttonMatrix frame])) / 2
//                                            )];
        [buttonMatrix setAutoresizingMask:NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin];
        

        

        

        

//
//        AKWeiboViewController *weiboController = [[AKWeiboViewController alloc]init];
//        
//        [self addViewController:weiboController];
  
        
    }
    return self;
}

-(void)rowChanged:(id)sender{

    NSLog(@"rowChanged");


}




- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    NSGraphicsContext* theContext = [NSGraphicsContext currentContext];
    [theContext saveGraphicsState];
    [[NSGraphicsContext currentContext] setPatternPhase:NSMakePoint(0,[self frame].size.height)];
    [self.customBackgroundColor set];
    NSRectFill([self bounds]);
    [theContext restoreGraphicsState];
    
//    NSSize buttonMatrixSize = NSMakeSize(48, 490);
//    
//    NSRect buttonMatrixFrame = NSMakeRect((dirtyRect.size.width - buttonMatrixSize.width)/2, (dirtyRect.size.height - (buttonMatrixSize.height + buttonMatrixTopMargin)), buttonMatrixSize.width, buttonMatrixSize.height);
//    [buttonMatrix setFrame:buttonMatrixFrame];

}


#pragma mark - Private Methods
-(void)addViewController:(AKTabViewController *)viewController{

    viewController.delegate = self;
    
    
    [_tabViewControllers addObject:viewController];

    [buttonMatrix addRowWithCells:[[NSArray alloc] initWithObjects:viewController.button, nil]];

    
    NSTabViewItem *newTabViewItem = [[NSTabViewItem alloc]initWithIdentifier:[NSString stringWithFormat:@"tab%ld",self.targetTabView.numberOfTabViewItems+1]];
    //newTabViewItem.view = viewController.view;
    
    [newTabViewItem setView:viewController.view];
    
//  viewController.view.needsDisplay = YES;
    
    //Add tab view item to dictionary for later use.
    [tabViewItemAndControllerDictionary setObject:newTabViewItem forKey: viewController.identifier];
 
    [self.targetTabView addTabViewItem:newTabViewItem];
    
    [newTabViewItem.view setFrame:NSMakeRect(0, 0, self.targetTabView.frame.size.width, self.targetTabView.frame.size.height)];
    
    if(buttonMatrix.numberOfRows == 1){
        [buttonMatrix selectCellAtRow:0 column:0];
        [viewController.button performClick:viewController.button];
    }


    
    //[buttonMatrix sizeToCells];
    

    


}


-(void)tabViewController:(AKTabViewController *)aTabViewController tabButtonClicked:(AKTabButton *)buttonClicked{
    
    NSLog(@"tabViewController = %@ , buttonClicked = %@",aTabViewController, buttonClicked);
    NSTabViewItem *tabViewItem = [tabViewItemAndControllerDictionary objectForKey:aTabViewController.identifier];
    [self.targetTabView selectTabViewItem:tabViewItem ];

}




@end
