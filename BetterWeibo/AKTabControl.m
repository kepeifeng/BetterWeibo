//
//  AKTabController.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-29.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//


#import "AKTabControl.h"
#import "AKWeiboViewController.h"
#import "AKMentionViewController.h"
#import "AKMessageViewController.h"
#import "AKBlockViewController.h"



@implementation AKTabControl{
    
#pragma mark - Private Variables
    NSMatrix * _buttonMatrix;
    CGFloat buttonMatrixTopMargin;
    NSMutableDictionary *tabViewItemAndControllerDictionary;
    
    NSMutableDictionary *userButtonDictionary;
    NSMutableDictionary *userControlMatrixDictionary;
    NSMutableDictionary *userTabViewDictionary;
    
    NSPoint lastControlMatrixOrigin;
    
    //用于表示当前用户的序号
    NSInteger currentIndex;
    
    
    
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
        userButtonDictionary = [[NSMutableDictionary alloc]init];
        userControlMatrixDictionary = [[NSMutableDictionary alloc]init];
        userTabViewDictionary = [[NSMutableDictionary alloc]init];
        userIDList = [[NSMutableArray alloc]init];
        
        

        

        

        

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

#pragma mark - Public Methods

-(BOOL)isUserExist:(NSString *)userID{

    for (AKUserProfile *userProfile in userIDList) {
        if([userProfile.userID isEqualToString:userID]){
        
            return YES;
        
        }
    }
    
    return NO;
}


/**
 *  Setup a group of control for the user.
 *
 *  @param userProfile User profile.
 */
-(void)addControlGroup:(AKUserProfile *)userProfile{
    
    if([self isUserExist:userProfile.userID]){
        return;
    }

    NSUInteger index = [userButtonDictionary count];
    
    [userIDList addObject:userProfile];
    
    //Add user image
    NSButton *userButton = [[NSButton alloc]initWithFrame:NSMakeRect(0, 0, 48, 48)];
    userButton.tag = index;
    [userButton setTarget:self];
    [userButton setAction:@selector(userButtonClicked:)];
    
    
    [userButtonDictionary setObject:userButton forKey: userProfile.userID];
    NSSize buttonMatrixSize = NSMakeSize(48, 0);
    NSRect buttonMatrixFrame = NSMakeRect(0,60, buttonMatrixSize.width, buttonMatrixSize.height);
    
    [self addSubview:userButton];


    
    if(index>0){
    
        [userButton setFrameOrigin:NSMakePoint((self.bounds.size.width - userButton.frame.size.width)/2, lastControlMatrixOrigin.y- userButton.frame.size.height - 10)];
        
    
    }
    else{
    
        [userButton setFrameOrigin:NSMakePoint((self.bounds.size.width - userButton.frame.size.width)/2, self.bounds.size.height - (userButton.frame.size.height + 10))];
        
    }
    
    [userButton setAutoresizingMask:NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin];
    
    //Add control matrix
    
    NSMatrix *buttonMatrix;
    
    buttonMatrixTopMargin = 10;
    buttonMatrix = [[NSMatrix alloc]initWithFrame:buttonMatrixFrame mode:NSRadioModeMatrix cellClass:[AKTabButton class] numberOfRows:0 numberOfColumns:1];
    buttonMatrix.mode = NSRadioModeMatrix;
    
    buttonMatrix.autorecalculatesCellSize = NO;
    buttonMatrix.autosizesCells = NO;
    buttonMatrix.intercellSpacing = NSMakeSize(0, 0);
    buttonMatrix.cellSize = NSMakeSize(49, 48);

    [buttonMatrix setAction:@selector(rowChanged:)];
    [buttonMatrix setTarget:self];
    [self addSubview:buttonMatrix];

    //[buttonMatrix setFrameOrigin:NSMakePoint(
    //(NSWidth([self bounds]) - NSWidth([buttonMatrix frame])) / 2,
    //(NSHeight([self bounds]) - NSHeight([buttonMatrix frame])) / 2
    //)];
    
    if(index>0){
        
        //[buttonMatrix setFrameSize:NSMakeSize(buttonMatrix.frame.size.width, 0)];
        
        [buttonMatrix setFrameOrigin:NSMakePoint((self.bounds.size.width - buttonMatrixSize.width)/2, userButton.frame.origin.y -10 )];
        //[buttonMatrix setHidden:YES];
        //[buttonMatrix setAlphaValue:0];
    }
    else{
    
        [buttonMatrix setFrameOrigin:NSMakePoint((self.bounds.size.width - buttonMatrixSize.width)/2, self.bounds.size.height - (buttonMatrixSize.height + userButton.frame.size.height + 10 + buttonMatrixTopMargin))];
        
    }
    
    
    [buttonMatrix setAutoresizingMask:NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin];
    
    
    
    [userControlMatrixDictionary setObject:buttonMatrix forKey:userProfile.userID];
    

    
    //Add New Tab with new tabview inside in targetTabView for User
    
    NSTabViewItem *newTabViewItem = [[NSTabViewItem alloc]initWithIdentifier:[NSString stringWithFormat:@"%@",userProfile.userID]];
    [self.targetTabView addTabViewItem:newTabViewItem];
    
    NSTabView *userTabView = [[NSTabView alloc]init];
    
    [userTabViewDictionary setObject:userTabView forKey:userProfile.userID];
    
    [userTabView setTabViewType:NSNoTabsNoBorder];
    [newTabViewItem setView:userTabView];
    
    
    //Add subviews to Control Matrix and Tab View
    AKWeiboViewController *weiboViewController = [[AKWeiboViewController alloc]init];
    [self addViewController:weiboViewController forUser:userProfile.userID];
    
    
    AKMentionViewController *mentionViewController = [[AKMentionViewController alloc]init];
    [self addViewController:mentionViewController forUser:userProfile.userID];
    
    AKMessageViewController *messageViewController = [[AKMessageViewController alloc]init];
    [self addViewController:messageViewController forUser:userProfile.userID];
    
    
    AKBlockViewController *blockViewController = [[AKBlockViewController alloc]init];
    [self addViewController:blockViewController forUser:userProfile.userID];
    
    if(index>0){
        
        [buttonMatrix setFrameSize:NSMakeSize(buttonMatrix.frame.size.width, 0)];
        [buttonMatrix setFrameOrigin:NSMakePoint((self.bounds.size.width - buttonMatrixSize.width)/2, userButton.frame.origin.y -10 )];
    
    }
    
    lastControlMatrixOrigin = buttonMatrix.frame.origin;
    
    
}

-(void)switchToGroupAtIndex:(NSInteger)index{
    
    if(currentIndex == index){
    
        return;
        
    }
    
    AKUserProfile *currentUser = [userIDList objectAtIndex:currentIndex];
    NSString *currentUserID = currentUser.userID;
    AKUserProfile *targetUser = [userIDList objectAtIndex:index];
    NSString *targetUserID = targetUser.userID;
    
    NSInteger y = self.bounds.size.height;
    for(NSInteger i=0; i<userIDList.count; i++){
    
        AKUserProfile *userProfile = [userIDList objectAtIndex:i];
        NSButton * userButton = [userButtonDictionary objectForKey:userProfile.userID];
        NSMatrix *userControlMatrix = [userControlMatrixDictionary objectForKey:userProfile.userID];
        
        if([userProfile.userID isEqualToString: currentUserID]){
            
            [userControlMatrix setFrameSize:NSMakeSize(userControlMatrix.frame.size.width, 0)];
        }
        else if ([userProfile.userID isEqualToString: targetUserID]){
        
            [userControlMatrix setFrameSize:NSMakeSize(userControlMatrix.frame.size.width, userControlMatrix.cellSize.height * userControlMatrix.cells.count)];
        
        }
        
        y = y - 10 - userButton.frame.size.height;
        [userButton setFrameOrigin:NSMakePoint(userButton.frame.origin.x, y)];
        
        y = y - 10 - userControlMatrix.frame.size.height;
        [userControlMatrix setFrameOrigin:NSMakePoint(userControlMatrix.frame.origin.x, y)];
    
    }
    
    [self.targetTabView selectTabViewItemWithIdentifier:targetUserID];
    
    currentIndex = index;
    


}

-(void)setLightIndicatorState:(BOOL)state forButton:(AKTabButtonType)buttonType userID:(NSString *)userID{


}


#pragma mark - Private Methods

-(void)userButtonClicked:(id)sender{

    NSButton *buttonClicked = (NSButton *)sender;
    [self switchToGroupAtIndex:buttonClicked.tag];

}

-(void)addViewController:(AKTabViewController *)viewController forUser:(NSString *)userID{

    NSMatrix * buttonMatrix = [userControlMatrixDictionary objectForKey:userID];
    NSTabView *userTabView = [userTabViewDictionary objectForKey:userID];
    
    viewController.delegate = self;
    
    
    [_tabViewControllers addObject:viewController];

    [buttonMatrix addRowWithCells:[[NSArray alloc] initWithObjects:viewController.button, nil]];
    
    [buttonMatrix setFrameSize:NSMakeSize(buttonMatrix.frame.size.width, buttonMatrix.frame.size.height + 48)];
    [buttonMatrix setFrameOrigin:NSMakePoint(buttonMatrix.frame.origin.x, buttonMatrix.frame.origin.y - 48)];
//    [buttonMatrix intrinsicContentSize];

    
    NSTabViewItem *newTabViewItem = [[NSTabViewItem alloc]initWithIdentifier:[NSString stringWithFormat:@"tab%ld",self.targetTabView.numberOfTabViewItems+1]];
    //newTabViewItem.view = viewController.view;
    
    [newTabViewItem setView:viewController.view];
    
//  viewController.view.needsDisplay = YES;
    
    //Add tab view item to dictionary for later use.
    [tabViewItemAndControllerDictionary setObject:newTabViewItem forKey: viewController.identifier];
 
    [userTabView addTabViewItem:newTabViewItem];
    
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
    [tabViewItem.tabView selectTabViewItem:tabViewItem ];
    //tabViewItem.tabView
}


-(void)tabViewController:(AKTabViewController *)aTabViewController goToNewView:(NSView *)newView{

}

-(void)goBackToPreviousView:(AKTabViewController *)aTabViewController{


}



@end
