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

#import "AKStatusEditorWindowController.h"
#import "AKRemind.h"
#import "AKMenuItemRemindView.h"
#import "AKMenuItemUserView.h"

#define STATUS_MENU_WIDTH 180

@interface AKTabControl()

@property (readonly) NSMenu *statusBarMenu;

@end

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
    
    //A List of User ID string
    NSMutableArray *userIDList;
    AKUserManager *userManager;
    
    NSStatusItem *statusBarItem;
    
    NSMutableArray *_observedObjects;
    
    NSMenuItem *_lastHighlightedItem;
    
    //储存检查更新的timer
    NSMutableDictionary *_timerDictionary;
}


#pragma mark - Property Synthesize
@synthesize tabViewControllers = _tabViewControllers;
@synthesize targetTabView = _targetTabView;
-(void)dealloc{
    for (AKUserProfile *user in _observedObjects) {
        [user removeObserver:self forKeyPath:AKUserProfilePropertyNamedScreenName];
        [user removeObserver:self forKeyPath:AKUserProfilePropertyNamedProfileImage];
    }
    [userManager removeListener:self];
}

#pragma mark - Initialization



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

        _timerDictionary = [NSMutableDictionary new];
        
        [userManager addListener:self];

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

#pragma mark - Properties

-(NSTabView *)targetTabView{
    return _targetTabView;
}

-(void)setTargetTabView:(NSTabView *)targetTabView{
    _targetTabView = targetTabView;
//    if(_targetTabView){
//        [_targetTabView setDrawsBackground:YES];
//        NSColor *tabBackgroundPattern = [NSColor colorWithPatternImage:[NSImage imageNamed:@"app_content_background"]];
////        [_targetTabView set]
//        
//                                         
//    }
    
    
}



#pragma mark - Public Methods

-(BOOL)isUserExist:(NSString *)userID{

    for (NSString *userIDItem in userIDList) {
        if([userIDItem isEqualToString:userID]){
        
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
    
//    if([self isUserExist:userID]){
//        return;
//    }

    NSUInteger index = [userButtonDictionary count];
    
    AKWeiboViewGroupItem *viewGroupItem = [[AKWeiboViewGroupItem alloc]init];
    [weiboViewGroup setObject:viewGroupItem forKey:userID];
    
    [userIDList addObject:userID];
    viewGroupItem.userID = userID;
    
    AKUserProfile *userProfile = [[AKUserManager defaultUserManager]getUserProfileByUserID:userID];
    
    //Add user image
    AKUserButton *userButton = [[AKUserButton alloc]initWithFrame:NSMakeRect(0, 0, 48, 49)];
    //userButton.avatarURL = userProfile.profile_image_url;
    userButton.tag = index;
    userButton.borderType = AKUserButtonBorderTypeGlassOutline;
    userButton.userProfile = userProfile;
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
    buttonMatrix.allowsEmptySelection = NO;
    
    buttonMatrix.autorecalculatesCellSize = NO;
    buttonMatrix.autosizesCells = NO;
    buttonMatrix.intercellSpacing = NSMakeSize(0, 0);
    buttonMatrix.cellSize = NSMakeSize(49, 48);

    [buttonMatrix setAction:@selector(rowChanged:)];
    [buttonMatrix setTarget:self];
    [self addSubview:buttonMatrix];


    if(index>0){
        [buttonMatrix setFrameOrigin:NSMakePoint((self.bounds.size.width - buttonMatrixSize.width)/2, userButton.frame.origin.y -10 )];
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
    viewGroupItem.userTabViewItem = newTabViewItem;
    
    NSTabView *userTabView = [[NSTabView alloc]init];
    
    [userTabView setDelegate:self];
    [userTabViewDictionary setObject:userTabView forKey:userID];
    viewGroupItem.tabView = userTabView;
    
    [userTabView setTabViewType:NSNoTabsNoBorder];
    [newTabViewItem setView:userTabView];
    
    
    //Add subviews to Control Matrix and Tab View
    
    //微博
    AKWeiboViewController *weiboViewController = [[AKWeiboViewController alloc]init];
//    weiboViewController.delegate = self;
    viewGroupItem.weiboViewController = weiboViewController;
    weiboViewController.timelineType = AKFriendsTimeline;
    
    [self addViewController:weiboViewController forUser:userID];


    
    //提及
    AKWeiboViewController *mentionViewController = [[AKWeiboViewController alloc]init];
    mentionViewController.delegate = self;
    viewGroupItem.mentionViewController = mentionViewController;
    mentionViewController.timelineType = AKMentionTimeline;

    
    [self addViewController:mentionViewController forUser:userID];

    
    //私信
    /*
    AKMessageViewController *messageViewController = [[AKMessageViewController alloc]init];
    [self addViewController:messageViewController forUser:userID];
    */
    
    //收藏
    AKWeiboViewController *favoriteViewController = [[AKWeiboViewController alloc]init];
    favoriteViewController.delegate = self;
    viewGroupItem.favoriteViewController = favoriteViewController;
    favoriteViewController.timelineType = AKFavoriteTimeline;
    
    [self addViewController:favoriteViewController forUser:userID];

    
    //我
    AKProfileViewController *profileViewController = [[AKProfileViewController alloc]init];
    profileViewController.delegate = self;
    profileViewController.timelineType = AKUserTimeline;
    profileViewController.userID = [[AKID alloc] initWithIdType:AKIDTypeID text:userID key:nil];
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
    
    if(!activedView){
    
        [buttonMatrix selectCellAtRow:0 column:0];
        [(NSButtonCell *)buttonMatrix.selectedCell performClick:buttonMatrix];
        [(NSButtonCell *)buttonMatrix.selectedCell setState:NSOnState];
        
    }
    lastControlMatrixOrigin = buttonMatrix.frame.origin;
    
    if(_observedObjects){
        _observedObjects = [NSMutableArray new];
    }
    
    if(![_observedObjects containsObject:userProfile]){
        
        [userProfile addObserver:self forKeyPath:AKUserProfilePropertyNamedScreenName options:0 context:NULL];
        [userProfile addObserver:self forKeyPath:AKUserProfilePropertyNamedProfileImage options:0 context:NULL];
        [_observedObjects addObject:userProfile];
        
    }
    
    //Setup Status Bar
    NSMenu *menu = self.statusBarMenu;
    
    //分隔线
//    viewGroupItem.spliterMenuItem = [NSMenuItem separatorItem];
//    [menu addItem:viewGroupItem.spliterMenuItem];
    
    //用户名
    viewGroupItem.nameMenuItem = [[NSMenuItem alloc] initWithTitle:(userProfile.screen_name)?userProfile.screen_name:userProfile.IDString action:NULL keyEquivalent:@""];
    AKMenuItemUserView *menuItemUserView = [[AKMenuItemUserView alloc] initWithFrame:NSMakeRect(0, 0, STATUS_MENU_WIDTH, 37)];
    menuItemUserView.title = (userProfile.screen_name)?userProfile.screen_name:@"(空)";
    menuItemUserView.image = userProfile.profileImage;
    menuItemUserView.backgroundType = AKViewCustomImageBackground;
    menuItemUserView.customBackgroundImage = [NSImage imageNamed:@"status_item_header_background"];
    menuItemUserView.customLeftWidth = 5;
    menuItemUserView.customRightWidth = 5;
    viewGroupItem.nameMenuItem.view = menuItemUserView;
    [menu addItem:viewGroupItem.nameMenuItem];
    

    //主页
    viewGroupItem.homeMenuItem = [[NSMenuItem alloc] initWithTitle:@"主页" action:@selector(homeMenuItemClicked:) keyEquivalent:@""];
    viewGroupItem.homeMenuItem.target = self;
//    viewGroupItem.homeMenuItem.image = [NSImage imageNamed:@"menu-timeline-gray"];
//    viewGroupItem.homeMenuItem.onStateImage = [NSImage imageNamed:@"menu-timeline-white"];
//    viewGroupItem.homeMenuItem.offStateImage = [NSImage imageNamed:@"menu-timeline-gray"];
    viewGroupItem.homeMenuItem.mixedStateImage = nil;
    viewGroupItem.homeMenuItem.state = NSMixedState;
    viewGroupItem.homeMenuItem.tag = [userID integerValue];
    
    AKMenuItemRemindView *homeMenuItemView =[[AKMenuItemRemindView alloc] initWithFrame:NSMakeRect(0, 0, STATUS_MENU_WIDTH, 30)];
    homeMenuItemView.title = viewGroupItem.homeMenuItem.title;
    homeMenuItemView.image = [NSImage imageNamed:@"status_item_tweets_icon"];
//    homeMenuItemView.alternateImage = [NSImage imageNamed:@"menu-timeline-white"];
    homeMenuItemView.count = 0;
    
    
    viewGroupItem.homeMenuItem.view = homeMenuItemView;
    
    [menu addItem:viewGroupItem.homeMenuItem];
    
    //提及
    viewGroupItem.mentionMenuItem = [[NSMenuItem alloc] initWithTitle:@"提及" action:@selector(mentionMenuItemClicked:) keyEquivalent:@""];
    viewGroupItem.mentionMenuItem.target = self;
//    viewGroupItem.mentionMenuItem.image = [NSImage imageNamed:@"menu-mentions-gray"];
//    viewGroupItem.mentionMenuItem.onStateImage = [NSImage imageNamed:@"menu-mentions-white"];
//    viewGroupItem.mentionMenuItem.offStateImage = [NSImage imageNamed:@"menu-mentions-gray"];
    viewGroupItem.mentionMenuItem.mixedStateImage = nil;
    viewGroupItem.mentionMenuItem.state = NSMixedState;
    viewGroupItem.mentionMenuItem.tag = [userID integerValue];
    
    AKMenuItemRemindView *mentionMenuItemView =[[AKMenuItemRemindView alloc] initWithFrame:NSMakeRect(0, 0, STATUS_MENU_WIDTH, 30)];
    mentionMenuItemView.title = viewGroupItem.mentionMenuItem.title;
    mentionMenuItemView.image = [NSImage imageNamed:@"status_item_mentions_icon"];
//    mentionMenuItemView.alternateImage = [NSImage imageNamed:@"menu-mentions-white"];
    mentionMenuItemView.count = 0;
    
    viewGroupItem.mentionMenuItem.view = mentionMenuItemView;
    
    [menu addItem:viewGroupItem.mentionMenuItem];
    
    NSTimer *checkRemindTimer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(checkNewReminds) userInfo:nil repeats:YES];
    
    [_timerDictionary setObject:checkRemindTimer forKey:userID];
    
    
}

-(void)checkNewReminds{
    
    NSLog(@"checkNewReminds");
    
    NSArray *allUserProfile = [userManager allUserProfiles];
    
    for(AKUserProfile *user in allUserProfile){
        
        [[AKWeiboManager currentManager] checkUnreadForUser:user callbackTarget:self];
    }
    
}


-(void)homeMenuItemClicked:(id)sender{

    NSString *userID = [NSString stringWithFormat:@"%ld",[(NSMenuItem *)sender tag]];
    AKWeiboViewGroupItem *viewGroupItem = [weiboViewGroup objectForKey:userID];
    [viewGroupItem.userButton performClick:viewGroupItem.userButton];
    if(viewGroupItem.userControlMatrix.selectedCell != viewGroupItem.weiboViewController.button){
    
        [viewGroupItem.weiboViewController.button performClick:viewGroupItem.weiboViewController.button];
    }
    [NSApp activateIgnoringOtherApps:YES];
    [[[NSApp delegate] window] makeKeyAndOrderFront:NSApp];
//    [[self window] makeKeyAndOrderFront:self];
    
}

-(void)mentionMenuItemClicked:(id)sender{
    NSString *userID = [NSString stringWithFormat:@"%ld",[(NSMenuItem *)sender tag]];
    AKWeiboViewGroupItem *viewGroupItem = [weiboViewGroup objectForKey:userID];
    [viewGroupItem.userButton performClick:viewGroupItem.userButton];
    if(viewGroupItem.userControlMatrix.selectedCell != viewGroupItem.mentionViewController.button){
    
        [viewGroupItem.mentionViewController.button performClick:viewGroupItem.mentionViewController.button];
    }
    [NSApp activateIgnoringOtherApps:YES];
    [[[NSApp delegate] window] makeKeyAndOrderFront:NSApp];
}


-(NSMenu *)statusBarMenu{

    static NSMenu *statusBarMenu;
    if(statusBarMenu){
        return statusBarMenu;
    }
    
    NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
    statusBarItem = [statusBar statusItemWithLength:NSVariableStatusItemLength];
    
    NSImage *normalImage = [NSImage imageNamed:@"menubar-icon-normal"];
    statusBarItem.image = normalImage;
    NSImage *alternateImage=[NSImage imageNamed:@"menubar-icon-highlight"];
    statusBarItem.alternateImage = alternateImage;
    statusBarItem.highlightMode = YES;
    
    statusBarMenu = [[NSMenu alloc] init];

    statusBarMenu.delegate = self;
    NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle:@"写新微博" action:@selector(newStatusMenuItemClicked:) keyEquivalent:@""];
    menuItem.target = self;
    AKMenuItemRemindView *newMenuItemView = [[AKMenuItemRemindView alloc] initWithFrame:NSMakeRect(0, 0, STATUS_MENU_WIDTH, 30)];
    newMenuItemView.title = menuItem.title;
    newMenuItemView.image = [NSImage imageNamed:@"status_item_new_tweet_icon"];
    menuItem.view = newMenuItemView;
    
//    [statusBarMenu setMinimumWidth:130.0];
    [statusBarMenu addItem:menuItem];
    
    statusBarItem.menu = statusBarMenu;
    
    return statusBarMenu;
    
}


-(void)newStatusMenuItemClicked:(id)sender{
    
    [[AKStatusEditorWindowController sharedInstance] showWindow:self];
    
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

    if([keyPath isEqualToString:AKUserProfilePropertyNamedScreenName]){
        AKUserProfile *user = object;
        if(!user.screen_name){
            return;
        }
        AKWeiboViewGroupItem *viewGroupItem = [weiboViewGroup objectForKey:user.IDString];
        viewGroupItem.nameMenuItem.title = user.screen_name;
        [(AKMenuItemUserView *)viewGroupItem.nameMenuItem.view setTitle:user.screen_name];
    }
    else if ([keyPath isEqualToString:AKUserProfilePropertyNamedProfileImage]){
        AKUserProfile *user = object;
        AKWeiboViewGroupItem *viewGroupItem = [weiboViewGroup objectForKey:user.IDString];
        viewGroupItem.nameMenuItem.image = user.profileImage;
        [(AKMenuItemUserView *)viewGroupItem.nameMenuItem.view setImage:user.profileImage];

    }

}

#pragma mark - Menu Delegate
-(void)menu:(NSMenu *)menu willHighlightItem:(NSMenuItem *)item{

    if(item){
        if(item.image){
        
            item.image = item.onStateImage;
        }
    }
    
    if(_lastHighlightedItem){
        if(_lastHighlightedItem.image){
        
            _lastHighlightedItem.image = _lastHighlightedItem.offStateImage;
        }
    }
    
    _lastHighlightedItem = item;
}

-(void)menuDidClose:(NSMenu *)menu{
    
    if(_lastHighlightedItem){
        if(_lastHighlightedItem.image){
            
            _lastHighlightedItem.image = _lastHighlightedItem.offStateImage;
        }
    }
    _lastHighlightedItem = nil;
}
#pragma mark -


-(void)updateUserControlPosition{
    
//    if([userManager.currentUserID isEqualToString:userID]){
//        return;
//    }
    
    
    //AKUserProfile *currentUser = [userIDList objectAtIndex:currentIndex];
//    NSString *currentUserID = userManager.currentUserID;
    NSString *targetUserID = userManager.currentUserID;
    
//    userManager.currentUserID = userID;
    
    NSInteger y = self.bounds.size.height;
    
    [NSAnimationContext beginGrouping];
    for(AKWeiboViewGroupItem *viewGroup in weiboViewGroup.allValues){
        
        //AKUserProfile *userProfile = [userIDList objectAtIndex:i];
        NSButton * userButton = viewGroup.userButton; // [userButtonDictionary objectForKey:userProfile.IDString];
        NSMatrix *userControlMatrix = viewGroup.userControlMatrix; //[userControlMatrixDictionary objectForKey:userProfile.IDString];
        
        NSSize newMatrixSize;
        
        //如果是目标用户的控件组
        if ([viewGroup.userID isEqualToString: targetUserID]){
            
            newMatrixSize = NSMakeSize(userControlMatrix.frame.size.width,
                                       userControlMatrix.cellSize.height * userControlMatrix.cells.count);
            
            //如果该边栏没有按钮被激活 则激活第一个按钮
            if(![userControlMatrix selectedCell]){
                [userControlMatrix selectCellAtRow:0 column:0];
                [(NSButtonCell *)userControlMatrix.selectedCell performClick:userControlMatrix];
                [(NSButtonCell *)userControlMatrix.selectedCell setState:NSOnState];
            }
            //现实用户边栏按钮条
            //            [userControlMatrix setFrameSize:NSMakeSize(userControlMatrix.frame.size.width, userControlMatrix.cellSize.height * userControlMatrix.cells.count)];
            
        }else{
            
            newMatrixSize = NSMakeSize(userControlMatrix.frame.size.width, 0);
            
            //隐藏用户边栏按钮条
            //            [userControlMatrix setFrameSize:NSMakeSize(userControlMatrix.frame.size.width, 0)];
            
        }
        
        
        
        y = y - 10 - userButton.frame.size.height;
        
        NSRect newUserButtonFrame = userButton.frame;
        newUserButtonFrame.origin.y = y;
        [userButton.animator setFrame:newUserButtonFrame];
        //        [userButton setFrameOrigin:NSMakePoint(userButton.frame.origin.x, y)];
        
        //        y = y - 10 - userControlMatrix.frame.size.height;
        y = y - 10 - newMatrixSize.height;
        NSRect newMatrixFrame = userControlMatrix.frame;
        newMatrixFrame.origin.y = y;
        newMatrixFrame.size = newMatrixSize;
        [userControlMatrix.animator setFrame:newMatrixFrame];
        //        [userControlMatrix setFrameOrigin:NSMakePoint(userControlMatrix.frame.origin.x, y)];
        
    }
    
    [NSAnimationContext endGrouping];
    [self.targetTabView selectTabViewItemWithIdentifier:targetUserID];
    
    
    //currentIndex = index;
    
    
    
}


//
//-(void)switchToGroupOfUser:(NSString *)userID{
//    
//    if([userManager.currentUserID isEqualToString:userID]){
//        return;
//    }
//    
//    
//    //AKUserProfile *currentUser = [userIDList objectAtIndex:currentIndex];
//    NSString *currentUserID = userManager.currentUserID;
//    //AKUserProfile *targetUser = [userIDList objectAtIndex:index];
//    NSString *targetUserID = userID;
//    
//    userManager.currentUserID = userID;
//    
//    NSInteger y = self.bounds.size.height;
//    
//    [NSAnimationContext beginGrouping];
//    for(AKWeiboViewGroupItem *viewGroup in weiboViewGroup.allValues){
//        
//        //AKUserProfile *userProfile = [userIDList objectAtIndex:i];
//        NSButton * userButton = viewGroup.userButton; // [userButtonDictionary objectForKey:userProfile.IDString];
//        NSMatrix *userControlMatrix = viewGroup.userControlMatrix; //[userControlMatrixDictionary objectForKey:userProfile.IDString];
//        
//        NSSize newMatrixSize;
//        //如果找到当前用户的控件组
//        if([viewGroup.userID isEqualToString: currentUserID]){
//            
//            newMatrixSize = NSMakeSize(userControlMatrix.frame.size.width, 0);
//            
//            //隐藏用户边栏按钮条
////            [userControlMatrix setFrameSize:NSMakeSize(userControlMatrix.frame.size.width, 0)];
//            
//        }
//        //如果是目标用户的控件组
//        else if ([viewGroup.userID isEqualToString: targetUserID]){
//            
//            newMatrixSize = NSMakeSize(userControlMatrix.frame.size.width,
//                                       userControlMatrix.cellSize.height * userControlMatrix.cells.count);
//            
//            //如果该边栏没有按钮被激活 则激活第一个按钮
//            if(![userControlMatrix selectedCell]){
//                [userControlMatrix selectCellAtRow:0 column:0];
//                [(NSButtonCell *)userControlMatrix.selectedCell performClick:userControlMatrix];
//                [(NSButtonCell *)userControlMatrix.selectedCell setState:NSOnState];
//            }
//            //现实用户边栏按钮条
////            [userControlMatrix setFrameSize:NSMakeSize(userControlMatrix.frame.size.width, userControlMatrix.cellSize.height * userControlMatrix.cells.count)];
//            
//        }
//        
//        y = y - 10 - userButton.frame.size.height;
//        
//        NSRect newUserButtonFrame = userButton.frame;
//        newUserButtonFrame.origin.y = y;
//        [userButton.animator setFrame:newUserButtonFrame];
////        [userButton setFrameOrigin:NSMakePoint(userButton.frame.origin.x, y)];
//        
////        y = y - 10 - userControlMatrix.frame.size.height;
//        y = y - 10 - newMatrixSize.height;
//        NSRect newMatrixFrame = userControlMatrix.frame;
//        newMatrixFrame.origin.y = y;
//        newMatrixFrame.size = newMatrixSize;
//        [userControlMatrix.animator setFrame:newMatrixFrame];
////        [userControlMatrix setFrameOrigin:NSMakePoint(userControlMatrix.frame.origin.x, y)];
//    
//    }
//    
//    [NSAnimationContext endGrouping];
//    [self.targetTabView selectTabViewItemWithIdentifier:targetUserID];
//    
//
//    //currentIndex = index;
//    
//    
//    
//}

//
//-(void)switchToGroupAtIndex:(NSInteger)index{
//    
//    if(currentIndex == index){
//    
//        return;
//        
//    }
//    
//    AKUserProfile *currentUser = [userIDList objectAtIndex:currentIndex];
//    NSString *currentUserID = currentUser.IDString;
//    AKUserProfile *targetUser = [userIDList objectAtIndex:index];
//    NSString *targetUserID = targetUser.IDString;
//    
//    NSInteger y = self.bounds.size.height;
//    for(NSInteger i=0; i<userIDList.count; i++){
//    
//        AKUserProfile *userProfile = [userIDList objectAtIndex:i];
//        NSButton * userButton = [userButtonDictionary objectForKey:userProfile.IDString];
//        NSMatrix *userControlMatrix = [userControlMatrixDictionary objectForKey:userProfile.IDString];
//        
//        if([userProfile.IDString isEqualToString: currentUserID]){
//            
//            [userControlMatrix setFrameSize:NSMakeSize(userControlMatrix.frame.size.width, 0)];
//        }
//        else if ([userProfile.IDString isEqualToString: targetUserID]){
//        
//            [userControlMatrix setFrameSize:NSMakeSize(userControlMatrix.frame.size.width, userControlMatrix.cellSize.height * userControlMatrix.cells.count)];
//        
//        }
//        
//        y = y - 10 - userButton.frame.size.height;
//        [userButton setFrameOrigin:NSMakePoint(userButton.frame.origin.x, y)];
//        
//        y = y - 10 - userControlMatrix.frame.size.height;
//        [userControlMatrix setFrameOrigin:NSMakePoint(userControlMatrix.frame.origin.x, y)];
//    
//    }
//    
//    [self.targetTabView selectTabViewItemWithIdentifier:targetUserID];
//    
//    currentIndex = index;
//    
//
//
//}

-(void)setLightIndicatorState:(BOOL)state forButton:(AKTabButtonType)buttonType userID:(NSString *)userID{


}


#pragma mark - Private Methods

-(void)userButtonClicked:(id)sender{

    AKUserButton *buttonClicked = (AKUserButton *)sender;
    //[self switchToGroupAtIndex:buttonClicked.tag];
//    [self switchToGroupOfUser:buttonClicked.userID];
    [userManager setCurrentUserID:buttonClicked.userID];

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

    
    AKTabViewItem *newTabViewItem = [[AKTabViewItem alloc]initWithIdentifier:[NSString stringWithFormat:@"tab%ld",self.targetTabView.numberOfTabViewItems+1]];
    
    newTabViewItem.tabViewController = viewController;
    [newTabViewItem setView:viewController.view];

    
    //Add tab view item to dictionary for later use.
    [tabViewItemAndControllerDictionary setObject:newTabViewItem forKey: viewController.identifier];
 
    [userTabView addTabViewItem:newTabViewItem];
    
    //[newTabViewItem.view setFrame:NSMakeRect(0, 0, self.targetTabView.frame.size.width, self.targetTabView.frame.size.height)];
    
//    if(!activedView && buttonMatrix.numberOfRows == 1){
//        [buttonMatrix selectCellAtRow:0 column:0];
//        [viewController.button performClick:viewController.button];
//    }
    
}

-(void)tabButtonClicked:(id)sender
{
    NSInteger clickCount = [[NSApp currentEvent] clickCount];
    
    NSString *tabViewControllerID = [(AKTabButton *)[(NSMatrix *)sender selectedCell] tag];
    AKTabViewItem *tabViewItem = (AKTabViewItem *)[tabViewItemAndControllerDictionary objectForKey:tabViewControllerID];
    [tabViewItem.tabView selectTabViewItem:tabViewItem ];
    
    if([tabViewItem.tabViewController isKindOfClass:[AKTabViewController class]]){
        
        [(AKTabViewController *)tabViewItem.tabViewController tabDidActived];
        if(clickCount == 2){
            [(AKTabViewController *)tabViewItem.tabViewController tabButtonDoubleClicked:sender];
        }
        
    }
    
    activedView = tabViewItem.view;
    if(self.delegate){
        [self.delegate viewDidSelected:tabViewItem.tabViewController];
    }
    


    
//    [(AKTabViewController *)tabViewItem.view tabDidActived];
    //tabViewItem.tabView
    
}

-(void)tabView:(NSTabView *)tabView didSelectTabViewItem:(AKTabViewItem *)tabViewItem{

//    AKTabViewItem *myTabViewItem = (AKTabViewItem *)tabViewItem;

    
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
//    userButton.avatarURL =url;
    

}

//
//-(void)addStatuses:(NSArray *)statuses timelineType:(AKWeiboTimelineType)timelineType forUser:(NSString *)userID;{
//
////    AKUserProfile *user = [self currentUser];
//    AKWeiboViewGroupItem *viewGroup = [weiboViewGroup objectForKey:userID];
//    AKWeiboViewController *targetWeiboViewController;
//    
//    switch (timelineType) {
//        case AKFriendsTimeline:
//            targetWeiboViewController = viewGroup.weiboViewController;
//            break;
//            
//        case AKMentionTimeline:
//            targetWeiboViewController = viewGroup.mentionViewController;
//            break;
//            
//        case AKFavoriteTimeline:
//            targetWeiboViewController = viewGroup.favoriteViewController;
//            break;
//            
//            
//        default:
//            return;
//            break;
//    }
//    
//    [targetWeiboViewController addStatuses:statuses];
//    
//}

#pragma mark - Weibo Manager Delegate

-(void)OnDelegateComplete:(AKWeiboManager *)weiboManager methodOption:(AKMethodAction)methodOption httpHeader:(NSString *)httpHeader result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask{
    
    if(methodOption == AKWBOPT_GET_REMIND_UNREAD_COUNT){
        
        NSDictionary *remindDictionary = result.getObject;
        AKUserProfile *user = (AKUserProfile *)pTask.userData;
        AKWeiboViewGroupItem *viewGroupItem = [weiboViewGroup objectForKey:user.IDString];
        AKRemind *remind = [AKRemind getRemindFromDictionary:remindDictionary];
        
        //微博
        viewGroupItem.weiboViewController.button.lightUpIndicator = (remind.status>0);
        
        AKMenuItemRemindView *homeMenuItemView = (AKMenuItemRemindView *)viewGroupItem.homeMenuItem.view;
        [homeMenuItemView setCount:remind.status];
        if(remind.status>0){
            homeMenuItemView.image = [NSImage imageNamed:@"status_item_tweets_unread_icon"];
        }
        else{
            homeMenuItemView.image = [NSImage imageNamed:@"status_item_tweets_icon"];
        }
//
//        if(!viewGroupItem.homeMenuItem.isHighlighted){
//            viewGroupItem.homeMenuItem.image = viewGroupItem.homeMenuItem.offStateImage;
//        }
        
        //提及
        viewGroupItem.mentionViewController.button.lightUpIndicator = (remind.mentionStatus>0);
        [(AKMenuItemRemindView *)viewGroupItem.mentionMenuItem.view setCount:remind.mentionStatus];
        
        AKMenuItemRemindView *mentionMenuItemView = (AKMenuItemRemindView *)viewGroupItem.mentionMenuItem.view;
        [mentionMenuItemView setCount:remind.mentionStatus];
        if(remind.mentionStatus>0){
            mentionMenuItemView.image = [NSImage imageNamed:@"status_item_mentions_unread_icon"];
        }
        else{
            mentionMenuItemView.image = [NSImage imageNamed:@"status_item_mentions_icon"];
        }
//        if(!viewGroupItem.mentionMenuItem.isHighlighted){
//            viewGroupItem.mentionMenuItem.image = viewGroupItem.mentionMenuItem.offStateImage;
//        }
        
        [viewGroupItem.userControlMatrix setNeedsDisplay:YES];

    }

}

-(void)OnDelegateErrored:(AKWeiboManager *)weiboManager methodOption:(AKMethodAction)methodOption error:(AKError *)error result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask{

}

#pragma mark - User Manager Listener

-(void)userProfileDidInserted:(AKUserProfile *)userProfile atIndex:(NSInteger)index{

    [self addControlGroup:userProfile.IDString];
    //[weiboManager addUser:accessToken];
    [[AKWeiboManager currentManager] getUserDetail:userProfile.IDString];
    
}

-(void)userProfileDidRemoved:(AKUserProfile *)userProfile atIndex:(NSInteger)index{
    
    AKWeiboViewGroupItem *viewGroupItem = [weiboViewGroup objectForKey:userProfile.IDString];

    [self.targetTabView removeTabViewItem:viewGroupItem.userTabViewItem];
    
    [viewGroupItem.userButton removeFromSuperview];
    [viewGroupItem.userControlMatrix removeFromSuperview];
    
    [self.statusBarMenu removeItem:viewGroupItem.homeMenuItem];
    [self.statusBarMenu removeItem:viewGroupItem.mentionMenuItem];
//    [self.statusBarMenu removeItem:viewGroupItem.spliterMenuItem];
    
    
    [weiboViewGroup removeObjectForKey:userProfile.IDString];
    
    [self updateUserControlPosition];
    
    
//    [statusBarItem]
    
}

-(void)currentUserDidChanged{
    
    [self updateUserControlPosition];

}

@end
