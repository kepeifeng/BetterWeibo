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

@interface AKWeiboViewController ()

@end

@implementation AKWeiboViewController{

    NSMutableArray *_observedVisibleItems;

    
    
    
}


@synthesize timelineType = _timelineType;

- (id)init
{
    self = [super initWithNibName:@"AKWeiboViewController" bundle:nil];
    if (self) {
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
        listButton.imagePosition = NSImageOnly;
        [listButton setBordered:NO];
        
        self.leftControls = [NSArray arrayWithObject:listButton];
        
        
        NSButton *postButton = [[NSButton alloc]initWithFrame:NSMakeRect(0, 0, 40, 40)];
        postButton.image = [NSImage imageNamed:@"main_navbar_post_button"];
        postButton.alternateImage = [NSImage imageNamed:@"main_navbar_post_highlighted_button"];
        postButton.imagePosition = NSImageOnly;
        postButton.target = self;
        postButton.action = @selector(postButtonClicked:);
        [postButton setBordered:NO];
        
        
        self.rightControls = [NSArray arrayWithObject:postButton];
        
        

        
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewContentBoundsDidChange:) name:NSViewBoundsDidChangeNotification object:self.tableView];
        
        weiboArray = [[NSMutableArray alloc]init];
        [self loadWeibo];
        
        [self.weiboManager addMethodActionObserver:self selector:@selector(weiboManagerMethodActionHandler:)];
        

        
        
        
    }
    return self;
}

-(void)awakeFromNib{

    
    //Sroll to Refresh
    self.scrollView.refreshBlock = ^(EQSTRScrollView *scrollView){
        
        if(self.delegate){
            
            
            //NSString * latestWeiboID = ((AKWeiboStatus *)weiboArray[0]).idstr;
            [self.delegate WeiboViewRequestForStatuses:self sinceWeiboID: (weiboArray.count>0)?((AKWeiboStatus *)weiboArray[0]).idstr:nil maxWeiboID:0];
            
        }
        //[self.weiboManager getStatus];
        
        //请求获得新微博消息
        
    };
    
    [self.tableView setTarget:self];
    [self.tableView setDoubleAction:@selector(tableViewDoubleClicked:)];
    


}

-(void)postButtonClicked:(id)sender{

//    [[AKStatusEditorWindowController sharedInstance] showWindow:self];
    [[[AKStatusEditorWindowController sharedInstance] window]makeKeyAndOrderFront:self];

}


-(void)tabDidActived{

    if(weiboArray.count == 0)
    {
        
        [self.scrollView.contentView scrollToPoint:NSMakePoint(0, -42)];
        [self.scrollView startLoading];
    }
    

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


- (void)viewContentBoundsDidChange:(NSNotification*)notification
{
    NSRange visibleRows = [self.tableView rowsInRect:self.view.bounds];
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0];
    [self.tableView noteHeightOfRowsWithIndexesChanged:[NSIndexSet indexSetWithIndexesInRange:visibleRows]];
    [NSAnimationContext endGrouping];
}


-(void)addStatuses:(NSArray *)statuses{
    [self.scrollView stopLoading];
    [weiboArray addObjectsFromArray:statuses];
    [self.tableView reloadData];
    
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
    
    //return 2;

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
//    if(cell.objectValue){
//        return cell;
//    }
    
//    NSLog(@"Weibo Text = %@",cell.weiboTextField.stringValue);
    
    
    
    AKWeiboStatus *weibo = weiboArray[row];
    
    
    [cell.userAlias setStringValue:weibo.user.screen_name];
    [cell.weiboTextField setStringValue:weibo.text];
    [cell.favMark setHidden:!weibo.favorited];
    cell.hasRepostedWeibo = (weibo.retweeted_status && weibo.retweeted_status.user);
    if(weibo.user.profileImage){
        [cell.userImage setImage:weibo.user.profileImage];
    }
    
    if (weibo.thumbnail_pic) {
        //cell.thumbnailImageURL = weibo.thumbnail_pic;
    }
    
    //[cell loadImages:weibo.pic_urls];
    //[cell loadImages:weibo.retweeted_status.pic_urls isForRepost:YES];
    if(cell.hasRepostedWeibo)
    {
        
        cell.repostedWeiboView.repostedStatus = weibo.retweeted_status;
//        cell.repostedWeiboUserAlias.stringValue = weibo.retweeted_status.user.screen_name;
//        cell.repostedWeiboContent.stringValue = weibo.retweeted_status.text;
    }
    
    
    cell.objectValue = weibo;
    
    //如果本条微博或转发的微博中包含有图片，则加载/显示图片
    if(weibo.hasImages || (weibo.retweeted_status && weibo.retweeted_status.hasImages)){
    
        
        
        // Use KVO to observe for changes of the thumbnail image
        if (_observedVisibleItems == nil) {
            _observedVisibleItems = [NSMutableArray new];
        }
        if (![_observedVisibleItems containsObject:weibo]) {
            [weibo addObserver:self forKeyPath:ATEntityPropertyNamedThumbnailImage options:0 context:NULL];
            [weibo loadThumbnailImages];
            [_observedVisibleItems addObject:weibo];
        }
        
        // Hide/show progress based on the thumbnail image being loaded or not.
        
        //如果本微博有图片，不过还没加载
        if (weibo.hasImages){
            if(!weibo.thumbnailImages){
                //        [cellView.progessIndicator setHidden:NO];
                //        [cellView.progessIndicator startAnimation:nil];
                //        [cellView.imageView setHidden:YES];
            }
            else{
            
                [cell loadImages:weibo.thumbnailImages];
            
            }

        }
        //要不然如果转发微博有带图片,不过还没加载
        else if (weibo.retweeted_status && weibo.retweeted_status.hasImages ){
            if(!weibo.thumbnailImages){
                //        [cellView.progessIndicator setHidden:NO];
                //        [cellView.progessIndicator startAnimation:nil];
                //        [cellView.imageView setHidden:YES];
                
            }
            else{
            
                [cell.repostedWeiboView loadImages:weibo.thumbnailImages];
            
            }
        
        }
        
    
    }
    
    [cell.images setHidden:!weibo.hasImages];
    
    //[cell.weiboTextField setFrameSize:NSMakeSize(660, 100)];
    
    //[cell resize];
    return cell;
    //return nil;

}

-(void)loadMoreButtonClicked:(id)sender{
    
   
    
    [self.tableView reloadData];
    //NSLog(@"Load more button clicked");

}

-(void)tableViewColumnDidResize:(NSNotification *)notification{

    
    //NSRange visibleRows = [self.tableView rowsInRect:self.view.bounds];
    [self.tableView noteHeightOfRowsWithIndexesChanged:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.tableView.numberOfRows)]];



}

-(NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row{

//    NSLog(@"NEW ROWVIEW");
    AKTableRowView *tableRowView = [[AKTableRowView alloc]init];
    return tableRowView;


}


-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{

    if([weiboArray[row] isKindOfClass:[NSNull class]]){
    
        return 50;
    }
    assert(weiboArray[row]);
    CGFloat height = [AKWeiboTableCellView caculateWeiboHeight:weiboArray[row]
                                                      forWidth:self.view.frame.size.width]-2;
    
    //NSLog(@"%f",height);
    return height;
}

-(void)tableViewDoubleClicked:(id)sender{

    
    AKWeiboDetailViewController *weiboDetailViewController = [AKWeiboDetailViewController new];
    weiboDetailViewController.status = [weiboArray objectAtIndex:[(NSTableView *)sender selectedRow]];

    [self goToViewOfController:weiboDetailViewController];
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:ATEntityPropertyNamedThumbnailImage]) {
        // Find the row and reload it.
        // Note that KVO notifications may be sent from a background thread (in this case, we know they will be)
        // We should only update the UI on the main thread, and in addition, we use NSRunLoopCommonModes to make sure the UI updates when a modal window is up.
        [self performSelectorOnMainThread:@selector(_reloadRowForEntity:) withObject:object waitUntilDone:NO modes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    }
}


- (void)_reloadRowForEntity:(id)object {
    NSInteger row = [weiboArray indexOfObject:object];
    if (row != NSNotFound) {
        AKWeiboStatus *entity = [weiboArray objectAtIndex:row];
        AKWeiboTableCellView *cellView = [self.tableView viewAtColumn:0 row:row makeIfNecessary:NO];
        if (cellView) {
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



@end
