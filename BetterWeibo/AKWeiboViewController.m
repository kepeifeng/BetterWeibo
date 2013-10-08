//
//  AKWeiboViewController.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-30.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKWeiboViewController.h"
#import "AKWeibo.h"
#import "AKWeiboTableCellView.h"

@interface AKWeiboViewController ()

@end

@implementation AKWeiboViewController{

    NSMutableArray *weiboArray;
    
    
    
}




- (id)init
{
    self = [super initWithNibName:@"AKWeiboViewController" bundle:nil];
    if (self) {
        self.title = @"微    博";
        self.button = [[AKTabButton alloc]init];
        self.button.tabButtonIcon = AKTabButtonIconHome;
        self.button.tabButtonType = AKTabButtonTop;
        
        [self.button setAction:@selector(tabButtonClicked:)];
        [self.button setTarget:self];
        
        weiboArray = [[NSMutableArray alloc]init];
        
        NSDictionary *weibo = [[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:
                                                                    @"南方都市报",
                                                                    @"【赢了！广州恒大客场4:1逆转日本柏太阳神】在刚结束的亚冠半决赛首回合比赛中，广州恒大在客场，依靠下半场的穆里奇，孔卡，埃尔克森的四粒进球，逆转日本柏太阳神。在两回合比赛中占得先机，恭喜恒大。",
                                                                    [NSNumber numberWithBool:YES],
                                                                    @"实用小百科",
                                                                    @"【扫盲贴：这些字你都认识吗？】囧 jiǒng；槑méi；玊sù；天明：奣wěng；水人：氼 nì；王八：兲 tiān；好心：恏 hào；开火：烎 yín；强力：勥 jiàng；功夫：巭 pu或bu；二心：忈 rén；火化：炛 guāng；只要：嘦 jiào；不要：嫑 biáo。这些字你认识几个？除了囧还是囧吧 ，快学起来！",
                                                                    nil]
                                                           forKeys:[NSArray arrayWithObjects:
                                                                    @"userAlias",
                                                                    @"weiboContent",
                                                                    @"hasRepostedWeibo",
                                                                    @"repostedWeiboUserAlias",
                                                                    @"repostedWeiboContent",
                                                                    nil]];
        
        AKWeibo * weiboObj = [[AKWeibo alloc]init];
        weiboObj.userAlias = (NSString *)[weibo objectForKey:@"userAlias"];
        weiboObj.weiboContent = (NSString *)[weibo objectForKey:@"weiboContent"];
        if([(NSNumber *)[weibo objectForKey:@"hasRepostedWeibo"] boolValue]){
            weiboObj.repostedWeibo = [[AKWeibo alloc]init];
            weiboObj.repostedWeibo.userAlias = [weibo objectForKey:@"repostedWeiboUserAlias"];
            weiboObj.repostedWeibo.weiboContent = [weibo objectForKey:@"repostedWeiboContent"];
        }
        
        [weiboArray addObject:weiboObj];
        
        weibo = [[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:
                                                      @"南方都市报",
                                                      @"世上没有一件工作不辛苦，没有一处人事不复杂。即使你再排斥现在的不愉快，光阴也不会过得慢点。所以，长点心吧！不要随意发脾气，谁都不欠你的。要学会低调，取舍间必有得失，不用太计较。要学着踏实而务实，越简单越快乐。当一个人有了足够的内涵和物质做后盾，人生就会变得底气十足。",
                                                      [NSNumber numberWithBool:NO],
                                                      @"",
                                                      @"",
                                                      nil]
                                             forKeys:[NSArray arrayWithObjects:
                                                      @"userAlias",
                                                      @"weiboContent",
                                                      @"hasRepostedWeibo",
                                                      @"repostedWeiboUserAlias",
                                                      @"repostedWeiboContent",
                                                      nil]];
        
//        [weiboArray addObject:weibo];
        weiboObj = [[AKWeibo alloc]init];
        weiboObj.userAlias = (NSString *)[weibo objectForKey:@"userAlias"];
        weiboObj.weiboContent = (NSString *)[weibo objectForKey:@"weiboContent"];
        if([(NSNumber *)[weibo objectForKey:@"hasRepostedWeibo"] boolValue]){
            weiboObj.repostedWeibo = [[AKWeibo alloc]init];
            weiboObj.repostedWeibo.userAlias = [weibo objectForKey:@"repostedWeiboUserAlias"];
            weiboObj.repostedWeibo.weiboContent = [weibo objectForKey:@"repostedWeiboContent"];
        }
        
        [weiboArray addObject:weiboObj];
        
        weibo = [[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:
                                                      @"南方都市报",
                                                      @"世上没有一件工作不辛苦",
                                                      [NSNumber numberWithBool:NO],
                                                      @"",
                                                      @"",
                                                      nil]
                                             forKeys:[NSArray arrayWithObjects:
                                                      @"userAlias",
                                                      @"weiboContent",
                                                      @"hasRepostedWeibo",
                                                      @"repostedWeiboUserAlias",
                                                      @"repostedWeiboContent",
                                                      nil]];
        
//        [weiboArray addObject:weibo];
        weiboObj = [[AKWeibo alloc]init];
        weiboObj.userAlias = (NSString *)[weibo objectForKey:@"userAlias"];
        weiboObj.weiboContent = (NSString *)[weibo objectForKey:@"weiboContent"];
        if([(NSNumber *)[weibo objectForKey:@"hasRepostedWeibo"] boolValue]){
            weiboObj.repostedWeibo = [[AKWeibo alloc]init];
            weiboObj.repostedWeibo.userAlias = [weibo objectForKey:@"repostedWeiboUserAlias"];
            weiboObj.repostedWeibo.weiboContent = [weibo objectForKey:@"repostedWeiboContent"];
        }
        
        [weiboArray addObject:weiboObj];
        
        
        
        
        
    }
    return self;
}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        

        
        
        
        
    }
    return self;
}



#pragma mark - TableView Delegate

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{

    return weiboArray.count;
    
    //return 2;

}


-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    AKWeiboTableCellView *cell = [tableView makeViewWithIdentifier:@"weiboItem" owner:tableView];
    
    AKWeibo *weibo = weiboArray[row];
    
    [cell.userAlias setStringValue:weibo.userAlias];
    [cell.weiboTextField setStringValue:weibo.weiboContent];
    cell.hasRepostedWeibo = (weibo.repostedWeibo != nil);
    [cell loadImages:weibo.images];
    if(cell.hasRepostedWeibo)
    {
        cell.repostedWeiboUserAlias.stringValue = weibo.repostedWeibo.userAlias;
        cell.repostedWeiboContent.stringValue = weibo.repostedWeibo.weiboContent;
    }
    
    cell.objectValue = weibo;
    //[cell.weiboTextField setFrameSize:NSMakeSize(660, 100)];
    
    //[cell resize];
    return cell;
    //return nil;

}

-(void)tableViewColumnDidResize:(NSNotification *)notification{

    
    [self.tableView noteHeightOfRowsWithIndexesChanged:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, weiboArray.count)]];
    
    //NSLog(@"tableViewColumnDidResize");


}



-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{

    
    return [AKWeiboTableCellView caculateWeiboHeight:weiboArray[row] forWidth:tableView.frame.size.width];
    
    
    AKWeibo *cell = weiboArray[row];
    
    float cellHeight = 0;
    float repostedWeiboViewHeight = 0;
    float weiboViewHeight = 0;
    
    if(cell.repostedWeibo){
        
        repostedWeiboViewHeight = 200;
        
        
    }
    
    //Image Matrix
    if(!cell.images){
        weiboViewHeight += roundf((cell.images.count)/3)*45 + 10;
    }
    
    //Weibo Content
    float weiboTextFieldHeight = [cell.weiboContent heightForWidth:tableView.frame.size.width-84 font:[NSFont fontWithName:@"STHeitiSC-Light" size:15]];
    weiboTextFieldHeight *= 1.5;
    //[cell.weiboTextField setFrameSize:NSMakeSize(cell.weiboTextField.frame.size.width, weiboTextFieldHeight)];
    
    weiboViewHeight += weiboTextFieldHeight;
    weiboViewHeight += 10;
    
    //User Alias
    
    weiboViewHeight += 20;
    weiboViewHeight += 10;
    
    //Top Space
    weiboViewHeight += 10;
    
    //[cell.weiboView setFrameSize:NSMakeSize(cell.weiboView.frame.size.width, weiboViewHeight)];
    
    
    cellHeight = repostedWeiboViewHeight + weiboViewHeight + 2;
    //[cell setFrameSize:NSMakeSize(cell.frame.size.width, cellHeight)];
    
    return cellHeight;
    

    

}


#pragma Super class method override

-(void)tabButtonClicked:(id)sender{

    [super tabButtonClicked:sender];

}



@end
