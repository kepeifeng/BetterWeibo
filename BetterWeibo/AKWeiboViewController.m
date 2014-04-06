//
//  AKWeiboViewController.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-30.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKWeiboViewController.h"
#import "AKWeiboStatus.h"
#import "AKWeiboTableCellView.h"
#import "AKTableRowView.h"
#import "AKLoadMoreCell.h"
#import "AKWeiboDetailViewController.h"
#import "AKStatusEditorWindowController.h"
#import "AKProfileViewController.h"

@interface AKWeiboViewController ()

@end

@implementation AKWeiboViewController{

    NSMutableArray *_observedVisibleItems;

    
    
    
}


@synthesize timelineType = _timelineType;

-(void)dealloc{
    for (AKWeiboStatus *status in _observedVisibleItems) {
        [status removeObserver:self forKeyPath:AKWeiboStatusPropertyNamedThumbnailImage];
        [status removeObserver:self forKeyPath:AKWeiboStatusPropertyNamedFavorited];
    }
}

- (id)init
{
    self = [super initWithNibName:@"AKWeiboViewController" bundle:[NSBundle bundleForClass:[self class]]];
    if (self) {
//        [self loadView];
        self.title = @"微    博";
        self.button = [[AKTabButton alloc]init];
        self.button.tabButtonIcon = AKTabButtonIconHome;
        self.button.tabButtonType = AKTabButtonTop;
        
//        [self.button setAction:@selector(tabButtonClicked:)];
//        [self.button setTarget:self];
        

        //List Button
        NSButton *listButton = [[NSButton alloc]initWithFrame:NSMakeRect(0, 0, 40, 40)];
        listButton.image = [NSImage imageNamed:@"main_navbar_list_button"];
        listButton.alternateImage = [NSImage imageNamed:@"main_navbar_list_highlighted_button"];
        listButton.title = @"List";
        listButton.imagePosition = NSImageOnly;
        [listButton setBordered:NO];
        [listButton setButtonType:NSMomentaryChangeButton];
        self.leftControls = [NSArray arrayWithObject:listButton];
        
        
        NSButton *postButton = [[NSButton alloc]initWithFrame:NSMakeRect(0, 0, 40, 40)];
        postButton.image = [NSImage imageNamed:@"main_navbar_post_button"];
        postButton.alternateImage = [NSImage imageNamed:@"main_navbar_post_highlighted_button"];
        [postButton setButtonType:NSMomentaryChangeButton];
        postButton.imagePosition = NSImageOnly;
        postButton.target = self;
        postButton.action = @selector(postButtonClicked:);
        [postButton setBordered:NO];

        self.rightControls = [NSArray arrayWithObject:postButton];
      
        weiboArray = [[NSMutableArray alloc]init];
        [self loadWeibo];
        
        [self.weiboManager addMethodActionObserver:self selector:@selector(weiboManagerMethodActionHandler:)];
 
    }
    return self;
}

+ (void)addEdgeConstraint:(NSLayoutAttribute)edge superview:(NSView *)superview subview:(NSView *)subview {
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:subview
                                                          attribute:edge
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superview
                                                          attribute:edge
                                                         multiplier:1
                                                           constant:0]];
}

-(void)loadView{

    [super loadView];
    
    [self.view removeConstraints:self.view.constraints];
    
    [[self class] addEdgeConstraint:NSLayoutAttributeLeft superview:self.view  subview:self.scrollView];
    [[self class] addEdgeConstraint:NSLayoutAttributeRight superview:self.view subview:self.scrollView];
    [[self class] addEdgeConstraint:NSLayoutAttributeTop superview:self.view subview:self.scrollView];
    [[self class] addEdgeConstraint:NSLayoutAttributeBottom superview:self.view subview:self.scrollView];
    

}

-(void)awakeFromNib{

    //Sroll to Refresh
    self.scrollView.refreshBlock = ^(EQSTRScrollView *scrollView){
        
        NSString *sinceWeiboID = (weiboArray.count>0)?((AKWeiboStatus *)[weiboArray firstObject]).idstr:nil;
        
        [[AKWeiboManager currentManager] getStatusForUser:nil sinceWeiboID:sinceWeiboID maxWeiboID:nil count:30 page:1 baseApp:NO feature:0 trimUser:0 timelineType:self.timelineType callbackTarget:self];
        
    };
    
    self.scrollView.refreshBottomBlock = ^(EQSTRScrollView *scrollView){
        NSLog(@"refreshBottomBlock Actived.");

        NSString *maxWeiboID = (weiboArray.count>0)?[NSString stringWithFormat:@"%lld",((AKWeiboStatus *)[weiboArray lastObject]).ID-1]:nil;
        
        [[AKWeiboManager currentManager] getStatusForUser:nil sinceWeiboID:nil maxWeiboID:maxWeiboID count:30 page:1 baseApp:NO feature:0 trimUser:0 timelineType:self.timelineType callbackTarget:self];

    };
    
    [self.tableView setTarget:self];
    [self.tableView setDoubleAction:@selector(tableViewDoubleClicked:)];
    
    NSColor *backgroundPattern = [NSColor colorWithPatternImage:[NSImage imageNamed:@"app_content_background"]];
    [self.scrollView setBackgroundColor:backgroundPattern];
    
//    [self.tableView setBackgroundColor:[NSColor clearColor]];

//    [self.scrollView setFrame:self.view.bounds];
//    [self.scrollView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
//    


}

-(void)postButtonClicked:(id)sender{

//    [[AKStatusEditorWindowController sharedInstance] showWindow:self];
    [[AKStatusEditorWindowController sharedInstance] showWindow:self];

}



-(void)tabDidActived{

    
    NSLog(@"tabDidActived");
    if(weiboArray.count == 0 && !self.scrollView.isRefreshing)
    {
//        [self.tableView reloadData];
        [self.scrollView startLoading];
        [self.scrollView.contentView scrollToPoint:NSMakePoint(0, -42)];

    }
    else if(weiboArray.count == 0 && self.scrollView.isRefreshing){
        [self.scrollView.contentView scrollToPoint:NSMakePoint(0, -42)];
    }
    [super tabDidActived];

}

-(void)tabButtonDoubleClicked:(id)sender{

    if(weiboArray.count>0){
        
        //Scroll to Top
        NSPoint newScrollOrigin;
        
        // assume that the scrollview is an existing variable
        if ([[self.scrollView documentView] isFlipped]) {
            newScrollOrigin=NSMakePoint(0.0,0.0);
        } else {
            newScrollOrigin=NSMakePoint(0.0,NSMaxY([[self.scrollView documentView] frame])
                                        -NSHeight([[self.scrollView contentView] bounds]));
        }
        

        [[self.scrollView documentView] scrollPoint:newScrollOrigin];
        
        
    }
    [super tabButtonDoubleClicked:sender];

}

-(void)addStatusesToHead:(NSArray *)statuses{


}

-(void)addStatusesToFood:(NSArray *)statuses{


}

-(void)addStatusesToPosition:(NSArray *)statuses{


}

-(AKWeiboStatus *)getStatusFromDictionary:(NSDictionary *)dictionary{

    
    return nil;
}

-(void)weiboManagerMethodActionHandler:(NSNotification *)notification{
    


    
}


-(void)loadWeibo{
  
    
    //[weiboArray addObject:[NSNull null]];


}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        

        
        
        
        
    }
    return self;
}



-(void)addStatuses:(NSArray *)statuses{
    
    
    if(!statuses || statuses.count == 0){
        return;
    }

    AKWeiboStatus *firstOfNewStatuses = [statuses firstObject];
    AKWeiboStatus *lastOfNewStatuses = [statuses lastObject];
    
    AKWeiboStatus *firstOfOldStatuses = [weiboArray firstObject];
    AKWeiboStatus *lastOfOldStatuses = [weiboArray lastObject];
    
    NSLog(@"First of New Statuses: %lld",firstOfNewStatuses.ID);
    NSLog(@"Last of Old Statuses: %lld",lastOfOldStatuses.ID);
    NSInteger insertIndex = 0;
    if(weiboArray.count==0 || lastOfNewStatuses.ID > firstOfOldStatuses.ID){
    //Insert to the begining
//        [weiboArray insertObject:statuses atIndex:0];
        insertIndex = 0;
        [weiboArray insertObjects:statuses atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)]];
        
    
    }
    else if(firstOfNewStatuses.ID < lastOfOldStatuses.ID){
    //Insert to the last
        insertIndex = weiboArray.count;
        [weiboArray addObjectsFromArray:statuses];
//        [weiboArray insertObjects:statuses atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(weiboArray.count, statuses.count)]];
    }else{
    
        NSInteger startIndex = 0, endIndex = weiboArray.count-1;
        NSUInteger currentIndex = 0;
        
        long long currentStatusID, nextStatusID;
        
        BOOL isDone = NO;
        while (!isDone) {
            currentIndex = (startIndex + endIndex) /2;
            currentStatusID = [(AKWeiboStatus *)[weiboArray objectAtIndex:currentIndex] ID];
            nextStatusID = [(AKWeiboStatus *)[weiboArray objectAtIndex:currentIndex+1] ID];
            
            if(currentStatusID<firstOfNewStatuses.ID && nextStatusID>lastOfNewStatuses.ID){
            
                isDone = true;
                break;
                
            }
            else if(currentStatusID>firstOfNewStatuses.ID){
                endIndex = currentIndex;
            }else if (nextStatusID<lastOfNewStatuses.ID){
                startIndex = currentIndex;
            }
            
        }
        insertIndex = currentIndex-1;
        [weiboArray insertObjects:statuses atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(currentIndex - 1, statuses.count)]];
    
    }
    

    NSRect visibleRect = self.tableView.visibleRect;
    //User -noteNumberOfRowsChanged instead of -reloadData to avoid unneccesary redraw.
    [self.tableView noteNumberOfRowsChanged];
    
    
//    [self.tableView reloadDataForRowIndexes:[[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(insertIndex, statuses.count)] columnIndexes:[[NSIndexSet alloc] initWithIndex:0]];
//    [self.tableView scrollRectToVisible:visibleRect];
    [self.tableView scrollRowToVisible:insertIndex];
    
    
}

#pragma mark - Properties

-(AKWeiboTimelineType)timelineType{

    return _timelineType;

}

-(void)setTimelineType:(AKWeiboTimelineType)timelineType{

    _timelineType = timelineType;
    switch (timelineType) {
        case AKFriendsTimeline:
            self.title = @"微    博";
            self.button = [[AKTabButton alloc]init];
            self.button.tabButtonIcon = AKTabButtonIconHome;
            self.button.tabButtonType = AKTabButtonTop;
            break;
            
        case AKMentionTimeline:
            self.title = @"提    及";
            self.button = [[AKTabButton alloc]init];
            self.button.tabButtonIcon = AKTabButtonIconMention;
            self.button.tabButtonType = AKTabButtonMiddle;
            break;
            
        case AKFavoriteTimeline:
            self.title = @"收    藏";
            self.button = [[AKTabButton alloc]init];
            self.button.tabButtonIcon = AKTabButtonIconFavorite;
            self.button.tabButtonType = AKTabButtonMiddle;
            break;
            
        case AKPublicTimeline:
            self.title = @"广    场";
            self.button = [[AKTabButton alloc]init];
            self.button.tabButtonIcon = AKTabButtonIconHome;
            self.button.tabButtonType = AKTabButtonMiddle;
            break;
            
        default:
            break;
    }
    

}


#pragma mark - TableView Delegate

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return weiboArray.count;
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{

    return [weiboArray objectAtIndex:row];
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    

    if([weiboArray[row] isKindOfClass:[NSNull class]]){
    
        AKLoadMoreCell *loadMoreCell = [tableView makeViewWithIdentifier:@"loadMoreCell" owner:self];
        loadMoreCell.loadMoreButton.target = self;
        loadMoreCell.loadMoreButton.action = @selector(loadMoreButtonClicked:);
        
        return loadMoreCell;
    
    }
    
    AKWeiboTableCellView *cell = [tableView makeViewWithIdentifier:@"weiboItem" owner:self];

    AKWeiboStatus *weibo = weiboArray[row];
    
    
    [cell.userAlias setStringValue:weibo.user.screen_name];

    
    [cell.weiboTextField.textStorage setAttributedString:weibo.attributedText];
    cell.weiboTextField.delegate  = self;
    [self updateFavoriteViewForCell:cell isFavorited:weibo.favorited];
    [cell.dateDuration setStringValue:weibo.dateDuration];
    cell.hasRepostedWeibo = (weibo.retweeted_status != nil);
    cell.userImage.userProfile = weibo.user;
    cell.userImage.target = self;
    cell.userImage.action = @selector(userImageClicked:);

    if(cell.hasRepostedWeibo)
    {
        
        cell.repostedWeiboView.repostedStatus = weibo.retweeted_status;
        cell.repostedWeiboView.repostedWeiboContent.delegate = self;
    }
    
    
    cell.objectValue = weibo;
    
    
    if (_observedVisibleItems == nil) {
        _observedVisibleItems = [NSMutableArray new];
    }
    
    if (![_observedVisibleItems containsObject:weibo]) {
        [_observedVisibleItems addObject:weibo];
        
//        [weibo addObserver:self forKeyPath:AKWeiboStatusPropertyNamedThumbnailImage options:0 context:NULL];
//        [weibo loadThumbnailImages];
        [weibo addObserver:self forKeyPath:AKWeiboStatusPropertyNamedFavorited options:0 context:NULL];
        
    }

    
    //如果本条微博或转发的微博中包含有图片，则加载/显示图片
    if(weibo.hasImages || (weibo.retweeted_status && weibo.retweeted_status.hasImages)){

        // Use KVO to observe for changes of the thumbnail image
        //如果本微博有图片，不过还没加载
        if (weibo.hasImages){
            [cell loadImages:weibo.pictures];
//            if(weibo.thumbnailImages){
//                [cell loadImages:weibo.thumbnailImages];
//            }

        }
        //要不然如果转发微博有带图片,不过还没加载
        else if (weibo.retweeted_status && weibo.retweeted_status.hasImages ){
            [cell.repostedWeiboView loadImages:weibo.retweeted_status.pictures];
            
//            if(weibo.thumbnailImages){
//                [cell.repostedWeiboView loadImages:weibo.thumbnailImages];
//            }
        }

    }
    
    
    
    [cell.images setHidden:!weibo.hasImages];
    [cell resize];
    return cell;
    //return nil;

}

-(void)loadMoreButtonClicked:(id)sender{
    
   
    
    [self.tableView reloadData];
    //NSLog(@"Load more button clicked");

}

-(void)tableViewColumnDidResize:(NSNotification *)notification{

    NSLog(@"tableViewColumnDidResize");
    
//    NSRange visibleRows = [self.tableView rowsInRect:self.view.bounds];
//    [NSAnimationContext beginGrouping];
//    [[NSAnimationContext currentContext] setDuration:0];
//    [self.tableView noteHeightOfRowsWithIndexesChanged:[NSIndexSet indexSetWithIndexesInRange:visibleRows]];
//    [NSAnimationContext endGrouping];
    
    //NSRange visibleRows = [self.tableView rowsInRect:self.view.bounds];
    [self.tableView noteHeightOfRowsWithIndexesChanged:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.tableView.numberOfRows)]];



}

-(NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row{

//    NSLog(@"NEW ROWVIEW");
    AKTableRowView *tableRowView = [[AKTableRowView alloc]init];
    return tableRowView;


}


-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{

    //NSLog(@"heightOfRow");
    AKWeiboStatus *weibo = weiboArray[row];
    if([weiboArray[row] isKindOfClass:[NSNull class]]){
    
        return 50;
    }

    assert(weiboArray[row]);
    
    //forWidth必须用self.view.frame.size.width-2， 因为self.view.frame.size.width比单元格的width大了2px
    CGFloat height = [AKWeiboTableCellView caculateWeiboHeight:weiboArray[row]
                                                      forWidth:self.view.frame.size.width];

    return height;
}

-(void)tableViewDoubleClicked:(id)sender{

    
    AKWeiboDetailViewController *weiboDetailViewController = [AKWeiboDetailViewController new];
    weiboDetailViewController.status = [weiboArray objectAtIndex:[(NSTableView *)sender selectedRow]];

    [self goToViewOfController:weiboDetailViewController];
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:AKWeiboStatusPropertyNamedThumbnailImage]) {
        // Find the row and reload it.
        // Note that KVO notifications may be sent from a background thread (in this case, we know they will be)
        // We should only update the UI on the main thread, and in addition, we use NSRunLoopCommonModes to make sure the UI updates when a modal window is up.
        [self performSelectorOnMainThread:@selector(_reloadRowForEntity:) withObject:object waitUntilDone:NO modes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    }
    else if([keyPath isEqualToString:AKWeiboStatusPropertyNamedFavorited]){
        [self performSelectorOnMainThread:@selector(updateFavoriteView:) withObject:object waitUntilDone:NO modes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    }
}


-(void)updateFavoriteViewForCell:(AKWeiboTableCellView *)cellView isFavorited:(BOOL)favorited{

    if(favorited){
        [cellView.favMark setHidden:NO];
        [cellView.favButton setImage:[NSImage imageNamed:@"favorited"]];
        [cellView.favButton setAlternateImage:[NSImage imageNamed:@"favorited-highlight"]];
    }else{
        [cellView.favMark setHidden:YES];
        [cellView.favButton setImage:[NSImage imageNamed:@"weibo-toolbar-normal_fav"]];
        [cellView.favButton setAlternateImage:[NSImage imageNamed:@"weibo-toolbar-active_fav"]];
    }

}

-(void)updateFavoriteView:(id)object{
    NSInteger row = [weiboArray indexOfObject:object];
    if (row != NSNotFound) {
        AKWeiboStatus *status = [weiboArray objectAtIndex:row];
        AKWeiboTableCellView *cellView = [self.tableView viewAtColumn:0 row:row makeIfNecessary:NO];
        if (cellView) {

            [self updateFavoriteViewForCell:cellView isFavorited:status.favorited];

        }
    }
    
}

- (void)_reloadRowForEntity:(id)object {
    NSInteger row = [weiboArray indexOfObject:object];
    if (row != NSNotFound) {
        AKWeiboStatus *entity = [weiboArray objectAtIndex:row];
        AKWeiboTableCellView *cellView = [self.tableView viewAtColumn:0 row:row makeIfNecessary:NO];
        if (cellView && cellView.objectValue == object) {
            // Fade the imageView in, and fade the progress indicator out
            //[NSAnimationContext beginGrouping];
            //[[NSAnimationContext currentContext] setDuration:0.8];
            
//            [cellView.imageView setAlphaValue:0];
//            cellView.imageView.image = entity.thumbnailImage;
//            [cellView.imageView setHidden:NO];
            
            if(entity.hasImages){
                
                [cellView loadImages:entity.thumbnailImages];
                
            }else{
            
                [cellView.repostedWeiboView loadImages:entity.thumbnailImages];
            
            }
            
            
            //[[cellView.imageView animator] setAlphaValue:1.0];
            //[cellView.progessIndicator setHidden:YES];
            //[NSAnimationContext endGrouping];
        }
    }
}


#pragma -mark Super class method override

-(void)tabButtonClicked:(id)sender{

//    [super tabButtonClicked:sender];

}

#pragma mark - Text View Delegate
-(void)textView:(AKTextView *)textView attributeClicked:(NSString *)attribute ofType:(AKAttributeType)attributeType atIndex:(NSUInteger)index{

    if(attributeType == AKLinkAttribute){
    
        [[NSWorkspace sharedWorkspace]openURL:[NSURL URLWithString:attribute]];
        
    }
    else if(attributeType == AKUserNameAttribute){
        
        [self goToUserProfileViewOf: [[AKID alloc] initWithIdType:AKIDTypeScreenname text:[attribute substringFromIndex:1] key:nil]];
    }
    else if(attributeType == AKHashTagAttribute){
    
        
    
    }

}

-(void)goToUserProfileViewOf:(AKID *)userID{
    AKProfileViewController *profileViewController = [[AKProfileViewController alloc] init];
    profileViewController.userID = userID;

    [self goToViewOfController:profileViewController];
}

-(AKWeiboStatus *)getStatusByID:(NSString *)statusID{

    for(AKWeiboStatus *status in weiboArray){
        if([status.idstr isEqualToString:statusID]){
            return status;
        }
    }
    return nil;
}

#pragma mark - Weibo Manager Callback Methods

-(void)OnDelegateComplete:(AKWeiboManager*)weiboManager methodOption:(AKMethodAction)methodOption  httpHeader:(NSString *)httpHeader result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask{
    
    
    NSMutableArray *statusObjectArray;
    NSDictionary *resultDictionary = (NSDictionary *)[result getObject];
    
    if (methodOption == AKWBOPT_GET_STATUSES_HOME_TIMELINE || methodOption == AKWBOPT_GET_STATUSES_MENTIONS || methodOption == AKWBOPT_GET_STATUSES_PUBLIC_TIMELINE || methodOption == AKWBOPT_GET_STATUSES_USER_TIMELINE){
        
        
        [self.scrollView stopLoading];
        [self.scrollView stopBottomLoading];
        
        AKError *error = [AKWeiboManager getErrorFromResult:result];
        if(!error){
            
            NSArray *statusArray = (NSArray *)[resultDictionary objectForKey:@"statuses"];
            NSObject *adInfo = [resultDictionary objectForKey:@"ad"];
            long long adID = 0;
            if(adInfo && [adInfo isKindOfClass:[NSDictionary class]] ){
                adID = [(NSNumber *)[(NSDictionary*)adInfo objectForKey:@"id"] longLongValue];
            }
            
            statusObjectArray = [[NSMutableArray alloc]init];
            for(NSDictionary *status in statusArray){
                
                AKWeiboStatus *statusObject = [AKWeiboStatus getStatusFromDictionary:status];
                if (statusObject.text && statusObject.user && statusObject.ID !=adID) {
                    [statusObjectArray addObject:statusObject];
                }
            }
            [self addStatuses:statusObjectArray];
        }
        else{
        
        }

        
    }
    else if(methodOption == AKWBOPT_GET_FAVORITES){
        
        [self.scrollView stopLoading];
        [self.scrollView stopBottomLoading];
        
        NSArray *statusArray = (NSArray *)[resultDictionary objectForKey:@"favorites"];
        statusObjectArray = [[NSMutableArray alloc]init];
        for(NSDictionary *status in statusArray){
            
            AKWeiboStatus *statusObject = [AKWeiboStatus getStatusFromDictionary:[status objectForKey:@"status"]];
            if (statusObject.text && statusObject.user) {
            
                [statusObjectArray addObject:statusObject];
            }
            
        }
        
        [self addStatuses:statusObjectArray];
        
    }else if(methodOption == AKWBOPT_POST_FAVORITES_CREATE){
        
        NSDictionary *resultDictionary = [result getObject];
        NSString *statusID = [(NSDictionary *)[resultDictionary objectForKey:@"status"] objectForKey:@"idstr"];
        AKWeiboStatus *status = [self getStatusByID:statusID];
        
        status.favorited = YES;
    }else if (methodOption == AKWBOPT_POST_FAVORITES_DESTROY){
        
        NSDictionary *resultDictionary = [result getObject];
        NSString *statusID = [(NSDictionary *)[resultDictionary objectForKey:@"status"] objectForKey:@"idstr"];
        AKWeiboStatus *status = [self getStatusByID:statusID];
        
        status.favorited = NO;
        
    }
    
    
    
}

-(void)OnDelegateErrored:(AKWeiboManager *)weiboManager methodOption:(AKMethodAction)methodOption error:(AKError *)error result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask{
    
    if(methodOption == AKWBOPT_GET_STATUSES_HOME_TIMELINE || methodOption == AKWBOPT_GET_STATUSES_MENTIONS || methodOption == AKWBOPT_GET_STATUSES_PUBLIC_TIMELINE || methodOption == AKWBOPT_GET_STATUSES_USER_TIMELINE){
        [self.scrollView stopLoading];
        [self.scrollView stopBottomLoading];
        
    }

}

-(void)OnDelegateErrored:(AKWeiboManager *)weiboManager methodOption:(AKMethodAction)methodOption errCode:(NSInteger)errCode subErrCode:(NSInteger)subErrCode result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask{
    


}

-(void)OnDelegateWillRelease:(AKWeiboManager *)weiboManager methodOption:(AKMethodAction)methodOption pTask:(AKUserTaskInfo *)pTask{

}

-(void)userImageClicked:(id)sender{

    AKUserProfile *userProfile = [(AKUserButton *)sender userProfile];
    AKID *userID = [[AKID alloc] initWithIdType:AKIDTypeID text:userProfile.IDString key:nil];
    [self goToUserProfileViewOf:userID];
}

- (IBAction)favButtonClicked:(id)sender {
    
//    NSLog(@"favButton Clicked");
    NSInteger index = [self.tableView rowForView:sender];
    AKWeiboStatus *status = [weiboArray objectAtIndex:index];
    if(status.favorited){
    
        [[AKWeiboManager currentManager] postRemoveFavorite:status.idstr callbackTarget:self];
    }
    else{
        [[AKWeiboManager currentManager] postFavorite:status.idstr callbackTarget:self];
    }
    
}

-(void)searchForStatus:(NSString *)status{

}

@end
