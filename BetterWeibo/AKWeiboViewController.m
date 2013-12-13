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


@interface AKWeiboViewController ()

@end

@implementation AKWeiboViewController{


    
    
    
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
        
        self.leftControls = [NSArray arrayWithObject:listButton];
        
        
        NSButton *postButton = [[NSButton alloc]init];
        postButton.image = [NSImage imageNamed:@"main_navbar_post_button"];
        postButton.alternateImage = [NSImage imageNamed:@"main_navbar_post_highlighted_button"];
        postButton.imagePosition = NSImageOnly;
        
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


}


-(void)tabDidActived{

    if(weiboArray.count == 0)
    {
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
    cell.hasRepostedWeibo = (weibo.retweeted_status != nil);
    if(weibo.user.profileImage){
        [cell.userImage setImage:weibo.user.profileImage];
    }
    
    if (weibo.thumbnail_pic) {
        cell.thumbnailImageURL = weibo.thumbnail_pic;
    }
    
    [cell loadImages:weibo.pic_urls];
    [cell loadImages:weibo.retweeted_status.pic_urls isForRepost:YES];
    if(cell.hasRepostedWeibo)
    {
        cell.repostedWeiboUserAlias.stringValue = weibo.retweeted_status.user.screen_name;
        cell.repostedWeiboContent.stringValue = weibo.retweeted_status.text;
    }
    
    
    //cell.objectValue = weibo;
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
    
    CGFloat height = [AKWeiboTableCellView caculateWeiboHeight:weiboArray[row]
                                                      forWidth:self.view.frame.size.width]-2;
    
    //NSLog(@"%f",height);
    return height;
}


#pragma Super class method override

-(void)tabButtonClicked:(id)sender{

//    [super tabButtonClicked:sender];

}



@end
