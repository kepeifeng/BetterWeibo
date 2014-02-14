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
    AKTextField *_textField;
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

    

    //self.view.wantsLayer = YES;
    //self.view.layer.backgroundColor = CGColorCreateGenericRGB(1, 1, 1, 1);
    
    
    //self.view.layer.contents = [NSImage imageNamed:@"app_content_background"];
    
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
    
    NSInteger minHeight = 68;
    
    if(!_textField){
        _textField = [AKTextField new];
    }
    
    [_textField setFrameSize:NSMakeSize(tableView.frame.size.width - 64-20, 100)];
    
    
    [_textField setStringValue:text];
    
    CGFloat cellHeight = _textField.intrinsicContentSize.height+27+10;
    
    
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
        [cell.userAvatar setImage:comment.user.profileImage];
    
        
    }
    else if (tableView == self.statusDetailView.repostListView){
    
        AKWeiboStatus *status = [_reposts objectAtIndex:row];
        
        [cell.userAliasField setStringValue:status.user.screen_name];
        [cell.commentField setStringValue:status.text];
        [cell.userAvatar setImage:status.user.profileImage];
        
    }
    
    return cell;


}

#pragma mark - Weibo Manager Delegate

-(void)OnDelegateComplete:(AKWeiboManager*)weiboManager methodOption:(AKMethodAction)methodOption  httpHeader:(NSString *)httpHeader result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask{
    
    if(methodOption == AKWBOPT_GET_COMMENTS_SHOW){
//        NSLog(@"getStatusCommentCallback");
        
        _comments = [NSMutableArray new];
        NSArray *commentArray = [(NSDictionary *)[result getObject] objectForKey:@"comments"];
        for (NSDictionary *commentItem in commentArray) {
        
            
            [_comments addObject:[AKComment getCommentFromDictionary:commentItem forStatus:self.status]];
            
            
        }
        
        [self.statusDetailView.commentListView reloadData];

    }else if (methodOption == AKWBOPT_GET_STATUSES_REPOST_TIMELINE){
        _reposts = [NSMutableArray new];
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



- (IBAction)tabBarSelectionChanged:(id)sender {

    NSSegmentedControl *segmentedControl = sender;
    //转发
    if([segmentedControl selectedSegment] == 1 && !isRepostTabActived){
        
        [[AKWeiboManager currentManager] getStatusRepost:self.status.idstr callbackTarget:self];
        
        isRepostTabActived = YES;
    }
    
    [self.statusDetailView.tab selectTabViewItemAtIndex:[segmentedControl selectedSegment] ];
    
    
}
@end
