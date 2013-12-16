//
//  AKTabController.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-29.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//


#import "AKTabControl.h"
#import "AKWeiboViewController.h"

#import "AKMessageViewController.h"
#import "AKBlockViewController.h"

#import "AKSearchViewController.h"
#import "AKProfileViewController.h"
#import "AKPanelView.h"
#import "AKTabViewItem.h"
#import "AKUserButton.h"
#import "AKUserManager.h"


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
    
    
    
    NSMutableDictionary *weiboViewGroup;
    NSView *activedView;
    
    NSMutableArray *userIDList;
    AKUserManager *userManager;
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
        
        weiboViewGroup = [[NSMutableDictionary alloc]init];

        userManager = [AKUserManager defaultUserManager];

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
        if([userProfile.IDString isEqualToString:userID]){
        
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
-(void)addControlGroup:(NSString *)userID{
    
    if([self isUserExist:userID]){
        return;
    }

    NSUInteger index = [userButtonDictionary count];
    
    AKWeiboViewGroupItem *viewGroupItem = [[AKWeiboViewGroupItem alloc]init];
    [weiboViewGroup setObject:viewGroupItem forKey:userID];
    
    [userIDList addObject:userID];
    viewGroupItem.userID = userID;
    
    //Add user image
    AKUserButton *userButton = [[AKUserButton alloc]initWithFrame:NSMakeRect(0, 0, 48, 49)];
    //userButton.avatarURL = userProfile.profile_image_url;
    userButton.tag = index;
    userButton.userID = userID;
    [userButton setTarget:self];
    [userButton setAction:@selector(userButtonClicked:)];
    
    
    [userButtonDictionary setObject:userButton forKey:userID];
    
    viewGroupItem.userButton = userButton;
    
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
    
    
    
    [userControlMatrixDictionary setObject:buttonMatrix forKey:userID];
    
    viewGroupItem.userControlMatrix = buttonMatrix;
    

    
    //Add New Tab with new tabview inside in targetTabView for User
    
    NSTabViewItem *newTabViewItem = [[NSTabViewItem alloc]initWithIdentifier:[NSString stringWithFormat:@"%@",userID]];
    [self.targetTabView addTabViewItem:newTabViewItem];
    
    NSTabView *userTabView = [[NSTabView alloc]init];
    
    [userTabViewDictionary setObject:userTabView forKey:userID];
    viewGroupItem.tabView = userTabView;
    
    [userTabView setTabViewType:NSNoTabsNoBorder];
    [newTabViewItem setView:userTabView];
    
    
    //Add subviews to Control Matrix and Tab View
    
    //微博
    AKWeiboViewController *weiboViewController = [[AKWeiboViewController alloc]init];
    weiboViewController.delegate = self;
    viewGroupItem.weiboViewController = weiboViewController;
    weiboViewController.timelineType = AKFriendsTimeline;
    
    [self addViewController:weiboViewController forUser:userID];


    
    //提及
//    AKMentionViewController *mentionViewController = [[AKMentionViewController alloc]init];
//    [self addViewController:mentionViewController forUser:userID];
//    viewGroupItem.mentionViewController = mentionViewController;
    AKWeiboViewController *mentionViewController = [[AKWeiboViewController alloc]init];
    mentionViewController.delegate = self;
    viewGroupItem.mentionViewController = mentionViewController;
    mentionViewController.timelineType = AKMentionTimeline;

    
    [self addViewController:mentionViewController forUser:userID];

    
    //私信
    AKMessageViewController *messageViewController = [[AKMessageViewController alloc]init];
    [self addViewController:messageViewController forUser:userID];
    
    //收藏
//    AKTabViewController *favoriteViewController = [[AKFavoriteViewController alloc]init];
//    [self addViewController:favoriteViewController forUser:userID];
    AKWeiboViewController *favoriteViewController = [[AKWeiboViewController alloc]init];
    favoriteViewController.delegate = self;
    viewGroupItem.favoriteViewController = favoriteViewController;
    favoriteViewController.timelineType = AKFavoriteTimeline;
    
    [self addViewController:favoriteViewController forUser:userID];

    
    
    //我
    AKTabViewController *profileViewController = [[AKProfileViewController alloc]init];
    [self addViewController:profileViewController forUser:userID];
    
    //搜索
    AKTabViewController *searchViewController = [[AKSearchViewController alloc]init];
    [self addViewController: searchViewController forUser:userID];
    
    //黑名单
    AKBlockViewController *blockViewController = [[AKBlockViewController alloc]init];
    [self addViewController:blockViewController forUser:userID];
    
    if(index>0){
        
        [buttonMatrix setFrameSize:NSMakeSize(buttonMatrix.frame.size.width, 0)];
        [buttonMatrix setFrameOrigin:NSMakePoint((self.bounds.size.width - buttonMatrixSize.width)/2, userButton.frame.origin.y -10 )];
    
    }
    
    lastControlMatrixOrigin = buttonMatrix.frame.origin;
    
    
}

//-(AKUserProfile *)currentUser{
//
//    return [userIDList objectAtIndex:currentIndex];
//}


-(void)switchToGroupOfUser:(NSString *)userID{
    
    if([userManager.currentUserID isEqualToString:userID]){
        return;
    }
    
    
    //AKUserProfile *currentUser = [userIDList objectAtIndex:currentIndex];
    NSString *currentUserID = userManager.currentUserID;
    //AKUserProfile *targetUser = [userIDList objectAtIndex:index];
    NSString *targetUserID = userID;
    
    NSInteger y = self.bounds.size.height;
    
    for(AKWeiboViewGroupItem *viewGroup in weiboViewGroup){
        
        //AKUserProfile *userProfile = [userIDList objectAtIndex:i];
        NSButton * userButton = viewGroup.userButton; // [userButtonDictionary objectForKey:userProfile.IDString];
        NSMatrix *userControlMatrix = viewGroup.userControlMatrix; //[userControlMatrixDictionary objectForKey:userProfile.IDString];
        
        if([viewGroup.userID isEqualToString: currentUserID]){
            
            [userControlMatrix setFrameSize:NSMakeSize(userControlMatrix.frame.size.width, 0)];
        }
        else if ([viewGroup.userID isEqualToString: targetUserID]){
            
            [userControlMatrix setFrameSize:NSMakeSize(userControlMatrix.frame.size.width, userControlMatrix.cellSize.height * userControlMatrix.cells.count)];
            
        }
        
        y = y - 10 - userButton.frame.size.height;
        [userButton setFrameOrigin:NSMakePoint(userButton.frame.origin.x, y)];
        
        y = y - 10 - userControlMatrix.frame.size.height;
        [userControlMatrix setFrameOrigin:NSMakePoint(userControlMatrix.frame.origin.x, y)];
    
    }
    [self.targetTabView selectTabViewItemWithIdentifier:targetUserID];
    
    userManager.currentUserID = userID;
    //currentIndex = index;
    
    
    
}


-(void)switchToGroupAtIndex:(NSInteger)index{
    
    if(currentIndex == index){
    
        return;
        
    }
    
    AKUserProfile *currentUser = [userIDList objectAtIndex:currentIndex];
    NSString *currentUserID = currentUser.IDString;
    AKUserProfile *targetUser = [userIDList objectAtIndex:index];
    NSString *targetUserID = targetUser.IDString;
    
    NSInteger y = self.bounds.size.height;
    for(NSInteger i=0; i<userIDList.count; i++){
    
        AKUserProfile *userProfile = [userIDList objectAtIndex:i];
        NSButton * userButton = [userButtonDictionary objectForKey:userProfile.IDString];
        NSMatrix *userControlMatrix = [userControlMatrixDictionary objectForKey:userProfile.IDString];
        
        if([userProfile.IDString isEqualToString: currentUserID]){
            
            [userControlMatrix setFrameSize:NSMakeSize(userControlMatrix.frame.size.width, 0)];
        }
        else if ([userProfile.IDString isEqualToString: targetUserID]){
        
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

    AKUserButton *buttonClicked = (AKUserButton *)sender;
    //[self switchToGroupAtIndex:buttonClicked.tag];
    [self switchToGroupOfUser:buttonClicked.userID];

}

-(void)addViewController:(AKTabViewController *)viewController forUser:(NSString *)userID{

    NSMatrix * buttonMatrix = [userControlMatrixDictionary objectForKey:userID];
    NSTabView *userTabView = [userTabViewDictionary objectForKey:userID];
    
    //viewController.delegate = self;
    
    
    [_tabViewControllers addObject:viewController];

    [buttonMatrix addRowWithCells:[[NSArray alloc] initWithObjects:viewController.button, nil]];
    viewController.button.target = self;
    viewController.button.action = @selector(tabButtonClicked:);
    viewController.button.tag = viewController.identifier;
    
    [buttonMatrix setFrameSize:NSMakeSize(buttonMatrix.frame.size.width, buttonMatrix.frame.size.height + 48)];
    [buttonMatrix setFrameOrigin:NSMakePoint(buttonMatrix.frame.origin.x, buttonMatrix.frame.origin.y - 48)];
//    [buttonMatrix intrinsicContentSize];

    
    AKTabViewItem *newTabViewItem = [[AKTabViewItem alloc]initWithIdentifier:[NSString stringWithFormat:@"tab%ld",self.targetTabView.numberOfTabViewItems+1]];
    
    newTabViewItem.tabViewController = viewController;
    //newTabViewItem.view = viewController.view;
    
    [newTabViewItem setView:viewController.view];
    
//  viewController.view.needsDisplay = YES;
    
    //Add tab view item to dictionary for later use.
    [tabViewItemAndControllerDictionary setObject:newTabViewItem forKey: viewController.identifier];
 
    [userTabView addTabViewItem:newTabViewItem];
    
    [newTabViewItem.view setFrame:NSMakeRect(0, 0, self.targetTabView.frame.size.width, self.targetTabView.frame.size.height)];
    
    if(!activedView && buttonMatrix.numberOfRows == 1){
        [buttonMatrix selectCellAtRow:0 column:0];
        [viewController.button performClick:viewController.button];
    }


    
    //[buttonMatrix sizeToCells];
    

    


}

-(void)tabButtonClicked:(id)sender
{
    
    //NSLog(@"tabViewController = %@ , buttonClicked = %@",aTabViewController, buttonClicked);
    
    
    
    NSString *tabViewControllerID = [(AKTabButton *)[(NSMatrix *)sender selectedCell] tag];
    AKTabViewItem *tabViewItem = (AKTabViewItem *)[tabViewItemAndControllerDictionary objectForKey:tabViewControllerID];
    [tabViewItem.tabView selectTabViewItem:tabViewItem ];
    


    if([tabViewItem.tabViewController isKindOfClass:[AKWeiboViewController class]]){
        
        [(AKWeiboViewController *)tabViewItem.tabViewController tabDidActived];
    
    }

    activedView = tabViewItem.view;
    if(self.delegate){
        [self.delegate viewDidSelected:tabViewItem.tabViewController];
    }
    
//    [(AKTabViewController *)tabViewItem.view tabDidActived];
    //tabViewItem.tabView
    
}

-(void)tabViewController:(AKTabViewController *)aTabViewController tabButtonClicked:(AKTabButton *)buttonClicked{
    
    NSLog(@"tabViewController = %@ , buttonClicked = %@",aTabViewController, buttonClicked);
    NSTabViewItem *tabViewItem = [tabViewItemAndControllerDictionary objectForKey:aTabViewController.identifier];
    [tabViewItem.tabView selectTabViewItem:tabViewItem ];
    //tabViewItem.tabView
}


-(void)tabViewController:(AKTabViewController *)aTabViewController goToNewViewOfController:(NSViewController *)newViewController{
    if(self.delegate){
        [self.delegate viewDidSelected:newViewController];
    }
    

}

-(void)goBackToPreviousView:(AKTabViewController *)aTabViewController{


}

-(void)updateUser:(AKUserProfile *)userProfile{

    [self setAvatarForUser:userProfile.IDString URL:userProfile.profile_image_url];

}



-(void)setAvatarForUser:(NSString *)userID URL:(NSString *)url{
    
    AKWeiboViewGroupItem *viewGroup = [weiboViewGroup objectForKey:userID];
    if(!viewGroup)
    {
        return;
    }

    AKUserButton *userButton = viewGroup.userButton;
    userButton.avatarURL =url;
    

}


-(void)addStatuses:(NSArray *)statuses timelineType:(AKWeiboTimelineType)timelineType forUser:(NSString *)userID;{

//    AKUserProfile *user = [self currentUser];
    AKWeiboViewGroupItem *viewGroup = [weiboViewGroup objectForKey:userID];
    AKWeiboViewController *targetWeiboViewController;
    
    switch (timelineType) {
        case AKFriendsTimeline:
            targetWeiboViewController = viewGroup.weiboViewController;
            break;
            
        case AKMentionTimeline:
            targetWeiboViewController = viewGroup.mentionViewController;
            break;
            
        case AKFavoriteTimeline:
            targetWeiboViewController = viewGroup.favoriteViewController;
            break;
            
            
        default:
            return;
            break;
    }
    
    [targetWeiboViewController addStatuses:statuses];
    
}

//-(void)addStatuses:(NSArray *)statuses{
//
//    //AKUserProfile *user = [self currentUser];
//    AKWeiboViewGroupItem *viewGroup = [weiboViewGroup objectForKey:user.IDString];
//    [viewGroup.weiboViewController addStatuses:statuses];
//}

#pragma mark - AKWeiboViewControllerDelegate
-(void)WeiboViewRequestForStatuses:(AKWeiboViewController *)weiboViewController sinceWeiboID:(NSString *)sinceWeiboID maxWeiboID:(NSString *)maxWeiboID{
    
    //NSString *userID = weiboViewController.userID;
    if(self.delegate){
        [self.delegate WeiboViewRequestForStatuses:weiboViewController forUser:weiboViewController.userID sinceWeiboID:sinceWeiboID maxWeiboID:maxWeiboID count:30 page:1 baseApp:NO feature:0 trimUser:0];
    
    }

}

-(void)WeiboViewRequestForGroupStatuses:(AKWeiboViewController *)weiboViewController listID:(NSString *)listID sinceWeiboID:(NSString *)sinceWeiboID maxWeiboID:(NSString *)maxWeiboID{

}


@end