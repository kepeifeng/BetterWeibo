//
//  AKWeiboDetailViewController.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-10-2.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKWeiboDetailViewController.h"
#import "AKUserProfile.h"
#import "AKCommentViewCell.h"
#import "AKWeiboTableCellView.h"
#import "AKWeiboManager.h"
#import "AKTableRowView.h"
#import "AKProfileViewController.h"
#import "INPopoverController.h"
#import "AKPopupStatusEditorViewController.h"

#pragma mark - Constants

#define LISTVIEW_CELL_IDENTIFIER		@"AKCommentViewCell"




@interface AKWeiboDetailViewController ()

@end

@implementation AKWeiboDetailViewController{

    NSMutableArray *_comments;
    NSMutableArray *_reposts;
    NSTrackingArea *trackingArea;
    BOOL isRepostTabActived;
    //For cell height calculation usage.
    AKTextView *_textField;
    INPopoverController *gPopoverController;
    NSMenu *_shareButtonContextMenu;
    
}

@synthesize status = _status;


#pragma mark - Init/Dealloc

- (id)init
{

    
    self = [super initWithNibName:@"AKWeiboDetailViewController" bundle:nil];
    if (self) {
        self.title = @"评    论";        
        _comments = [NSMutableArray new];
        _reposts = [NSMutableArray new];
        
        isRepostTabActived = NO;
        
        NSArray *topLevelObjects;
        [[NSBundle mainBundle]loadNibNamed:@"AKWeiboStatusDetailView" owner:self topLevelObjects:&topLevelObjects];
        
        for(id object in topLevelObjects){
            
            if([object isKindOfClass:[NSView class]]){
                self.statusDetailView = object;
                
                break;
            }
        }
        
        [self.view addSubview:self.statusDetailView];
        
        [self.statusDetailView setFrameSize:self.view.bounds.size];
       // NSSize statusDetailViewSize = [self.statusDetailView intrinsicContentSize];
        //NSPoint statusDetailViewOrigin = NSMakePoint(0, self.view.bounds.size.height - statusDetailViewSize.height);
        

        //[self.statusDetailView setFrameSize:statusDetailViewSize];
        //[self.statusDetailView setFrameOrigin:statusDetailViewOrigin];
        //[self.statusDetailView setAutoresizesSubviews:YES];
        self.statusDetailView.commentListView.delegate =self;
        self.statusDetailView.commentListView.dataSource = self;
        [self.statusDetailView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
        self.statusDetailView.weiboTextField.delegate = self;
        self.statusDetailView.repostedWeiboView.repostedWeiboContent.delegate = self;
        self.statusDetailView.toolbar.target = self;
        self.statusDetailView.toolbar.action = @selector(toolbarClicked:);
        

        
    }
    return self;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        _comments = [NSMutableArray new];

    }
    return self;
}


- (void)awakeFromNib
{

    if(!_shareButtonContextMenu){
        _shareButtonContextMenu = [[NSMenu alloc] init];
        
        NSMenuItem *menuItem = [[NSMenuItem alloc]initWithTitle:@"复制微博" action:@selector(copyStatusMenuClicked:) keyEquivalent:@""];
        menuItem.target = self;
        [_shareButtonContextMenu addItem:menuItem];
        
        /*
         menuItem = [[NSMenuItem alloc] initWithTitle:@"在浏览器查看微博" action:@selector(openStatusInBrowser:) keyEquivalent:@""];
         menuItem.target = self;
         [_shareButtonContextMenu addItem:menuItem];
         */
        
        
    }

//    self.view.wantsLayer = YES;
//    self.view.layer.backgroundColor = CGColorCreateGenericRGB(1, 1, 1, 1);
    
    
    //self.view.layer.contents = [NSImage imageNamed:@"app_content_background"];
    
}

-(INPopoverController *)popoverStatusEditior{
    
    [self _makePopupPanelIfNeeded];
    return gPopoverController;
}

-(void)_makePopupPanelIfNeeded{
    
    if(!gPopoverController){
        AKPopupStatusEditorViewController *popupStatusEditorController = [[AKPopupStatusEditorViewController alloc] init];
        gPopoverController = [[INPopoverController alloc] initWithContentViewController:popupStatusEditorController];
        gPopoverController.borderColor = [NSColor colorWithWhite:0.1 alpha:1];
        gPopoverController.color = [NSColor colorWithWhite:0.2 alpha:1];
        gPopoverController.topHighlightColor = [NSColor colorWithWhite:0.5 alpha:1];
        popupStatusEditorController.popoverController = gPopoverController;
        
    }
    
    
}

-(void)repostButtonClicked:(id)sender{
    
    //NSMatrix *toolbar = sender;
    
    NSButtonCell *selectedButtonCell = (NSButtonCell *)[(NSMatrix *)sender selectedCell];
    NSRect buttonCellBounds = NSMakeRect(0, 0, selectedButtonCell.cellSize.width, selectedButtonCell.cellSize.height);
    
    if (self.popoverStatusEditior.popoverIsVisible) {
        [self.popoverStatusEditior closePopover:nil];
    } else {
        [(AKPopupStatusEditorViewController *)self.popoverStatusEditior.contentViewController repostStatus:self.status];
        [self.popoverStatusEditior presentPopoverFromRect:buttonCellBounds
                                                   inView:sender
                                  preferredArrowDirection:INPopoverArrowDirectionUp
                                    anchorsToPositionView:YES];
    }
    
}
-(void)commentButtonClicked:(id)sender{
    
    //NSMatrix *toolbar = sender;
    
    NSButtonCell *selectedButtonCell = (NSButtonCell *)[(NSMatrix *)sender selectedCell];
    NSRect buttonCellBounds = NSMakeRect(selectedButtonCell.cellSize.width, 0, selectedButtonCell.cellSize.width, selectedButtonCell.cellSize.height);
    
    if (self.popoverStatusEditior.popoverIsVisible) {
        [self.popoverStatusEditior closePopover:nil];
    } else {
        
        [(AKPopupStatusEditorViewController *)self.popoverStatusEditior.contentViewController commentOnStatus:self.status];
        [self.popoverStatusEditior presentPopoverFromRect:buttonCellBounds
                                                   inView:sender
                                  preferredArrowDirection:INPopoverArrowDirectionUp
                                    anchorsToPositionView:YES];
    }
    
}

-(void)favButtonClicked:(id)sender{
    
    
    
}

-(void)shareButtonClicked:(id)sender{
    
    NSMatrix *toolbarMatrix = sender;
    //    NSMenu *menu = [(NSButtonCell *)toolbarMatrix.selectedCell menu];
    [_shareButtonContextMenu popUpMenuPositioningItem:nil atLocation:NSMakePoint(toolbarMatrix.frame.size.width, 0) inView:toolbarMatrix];
}


-(void)copyStatusMenuClicked:(id)sender{
    
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard clearContents];
    [pasteboard setString:self.status.text forType:NSStringPboardType];
    
}

-(void)openStatusInBrowser:(id)sender{
    
    NSString *urlString = @"";
    [[NSWorkspace sharedWorkspace]openURL:[NSURL URLWithString:urlString]];
    
}


-(IBAction)toolbarClicked:(id)sender{
    
    NSButtonCell *clickedButton = [(NSMatrix *)sender selectedCell];
    switch (clickedButton.tag) {
        case 0:
            //转发
            [self repostButtonClicked:sender];
            break;
            
        case 1:
            //评论
            [self commentButtonClicked:sender];
            break;
            
        case 2:
            //收藏
            [self favButtonClicked:sender];
            break;
            
        case 3:
            //其它
            [self shareButtonClicked:sender];
            break;
            
        default:
            break;
    }
    
    
}



#pragma mark - Properties

-(AKWeiboStatus *)status{
    
    return _status;
}

-(void)setStatus:(AKWeiboStatus *)status {
    
    
    _status = status;
    
    self.statusDetailView.status = status;
    [self.statusDetailView adjustPosition];
    
    
    if(status){
        [[AKWeiboManager currentManager] getStatusComment:status.idstr callbackTarget:self];
        
        
    }

    
}


-(NSMutableArray *)getContentArrayByTableView:(NSTableView *)tableView{

    NSMutableArray *contentArray;
    if(tableView == self.statusDetailView.commentListView){
        contentArray = _comments;
    }
    else if (tableView == self.statusDetailView.repostListView){
        contentArray = _reposts;
    }
    
    return contentArray;

}

#pragma mark - List View Delegate Methods

-(NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row{
    
    //    NSLog(@"NEW ROWVIEW");
    AKTableRowView *tableRowView = [[AKTableRowView alloc]init];
    return tableRowView;
    
    
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{

    NSArray *contentArray = [self getContentArrayByTableView:tableView];
    return contentArray.count;
}

-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{


    NSString *text;
    //NSMutableArray *contentArray;
    if(tableView == self.statusDetailView.commentListView){
        //contentArray = _comments;
        text = [(AKComment *)[_comments objectAtIndex:row] text];
    }
    else if (tableView == self.statusDetailView.repostListView){
//        contentArray = _reposts;
        text = [(AKWeiboStatus *)[_reposts objectAtIndex:row] text];
    }
    
    NSInteger minHeight = 62;
    
    if(!_textField){
        _textField = [[AKTextView alloc] initWithFrame:NSMakeRect(0, 0, tableView.bounds.size.width, 100)];
    }
    
    [_textField setFrameSize:NSMakeSize(tableView.bounds.size.width - 10 - 48 - 10 - 10, 100)];
    
    
    [_textField setStringValue:text];
    
    CGFloat cellHeight = _textField.intrinsicContentSize.height + 5 + 27 + 10;
    
    
    return (cellHeight>minHeight)?cellHeight:minHeight;
    
    //return 100;

}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    NSArray *contentArray = [self getContentArrayByTableView:tableView];

    return [contentArray objectAtIndex:row];

}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    AKCommentViewCell *cell = [tableView makeViewWithIdentifier:@"commentItem" owner:self];
    
    if(tableView == self.statusDetailView.commentListView){
        
        AKComment *comment = [_comments objectAtIndex:row];
        
        
        [cell.userAliasField setStringValue:comment.user.screen_name];
        [cell.commentField setStringValue:comment.text];
//        [cell.userAvatar setImage:comment.user.profileImage];
        cell.userAvatar.userProfile = comment.user;
    
        
    }
    else if (tableView == self.statusDetailView.repostListView){
    
        AKWeiboStatus *status = [_reposts objectAtIndex:row];
        
        [cell.userAliasField setStringValue:status.user.screen_name];
        [cell.commentField setStringValue:status.text];
        cell.userAvatar.userProfile = status.user;
        
    }
    
    return cell;


}

#pragma mark - Weibo Manager Delegate

-(void)OnDelegateComplete:(AKWeiboManager*)weiboManager methodOption:(AKMethodAction)methodOption  httpHeader:(NSString *)httpHeader result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask{
    
    if(methodOption == AKWBOPT_GET_COMMENTS_SHOW){
//        NSLog(@"getStatusCommentCallback");
        
        
//        _comments = [NSMutableArray new];
        NSArray *commentArray = [(NSDictionary *)[result getObject] objectForKey:@"comments"];
        for (NSDictionary *commentItem in commentArray) {
        
            
            [_comments addObject:[AKComment getCommentFromDictionary:commentItem forStatus:self.status]];
            
            
        }
        
        [self.statusDetailView.commentListView reloadData];

    }else if (methodOption == AKWBOPT_GET_STATUSES_REPOST_TIMELINE){
//        _reposts = [NSMutableArray new];
        NSArray *repostArray = [(NSDictionary *)[result getObject] objectForKey:@"reposts"];
        for (NSDictionary *repostItem in repostArray) {
            
            
            [_reposts addObject:[AKWeiboStatus getStatusFromDictionary:repostItem forStatus:self.status]];
            
            
        }
        
        [self.statusDetailView.repostListView reloadData];
        
    
    }


}

-(void)OnDelegateErrored:(AKWeiboManager *)weiboManager methodOption:(AKMethodAction)methodOption errCode:(NSInteger)errCode subErrCode:(NSInteger)subErrCode result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask{


}

-(void)OnDelegateWillRelease:(AKWeiboManager *)weiboManager methodOption:(AKMethodAction)methodOption pTask:(AKUserTaskInfo *)pTask{


}

-(void)textView:(AKTextView *)textView attributeClicked:(NSString *)attribute ofType:(AKAttributeType)attributeType atIndex:(NSUInteger)index{
    
    if(attributeType == AKLinkAttribute){
        
        [[NSWorkspace sharedWorkspace]openURL:[NSURL URLWithString:attribute]];
        
    }
    else if(attributeType == AKUserNameAttribute){
        
        AKProfileViewController *profileViewController = [[AKProfileViewController alloc] init];
        profileViewController.userID = [[AKID alloc] initWithIdType:AKIDTypeScreenname text:[attribute substringFromIndex:1] key:nil];
        [self goToViewOfController:profileViewController];
        
    }
    else if(attributeType == AKHashTagAttribute){
        
        
        
    }


}


- (IBAction)tabBarSelectionChanged:(id)sender {

    NSSegmentedControl *segmentedControl = sender;
    //转发
    if([segmentedControl selectedSegment] == 1 && !isRepostTabActived){
        
        [[AKWeiboManager currentManager] getStatusRepost:self.status.idstr callbackTarget:self];
        
        isRepostTabActived = YES;
    }
    
    [self.statusDetailView.tab selectTabViewItemAtIndex:[segmentedControl selectedSegment] ];
    
    for(NSTabViewItem* tabViewItem in self.statusDetailView.tab.tabViewItems){
        
        NSView *tabView = tabViewItem.view;
        for(NSView *subView in [tabView subviews]){
            
            [subView setFrame:NSMakeRect(0, 0, tabView.frame.size.width, tabView.frame.size.height)];
            
        }
        
        
    }
    
}
@end
