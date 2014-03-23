//
//  AKUserTableViewController.m
//  BetterWeibo
//
//  Created by Kent on 14-3-7.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKUserTableViewController.h"
#import "AKUserTableCellView.h"
#import "AKTableRowView.h"
#import "AKWeiboManager.h"
#import "AKProfileViewController.h"

@interface AKUserTableViewController ()

@end

@implementation AKUserTableViewController{
    NSMutableArray *_userArray;
}

@synthesize searchQuery = _searchQuery;
@synthesize user = _user;
@synthesize tableViewType = _tableViewType;


- (id)init
{
    self = [super initWithNibName:@"AKUserTableViewController" bundle:[NSBundle bundleForClass:self.class]];
    if (self) {
        
        [self loadView];
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        _userArray = [NSMutableArray new];
    }
    return self;
}

-(void)awakeFromNib{

    [self.tableView setTarget:self];
    [self.tableView setDoubleAction:@selector(tableViewDoubleClicked:)];
}

#pragma mark - Properties

-(NSString *)searchQuery{
    return _searchQuery;
}

-(AKUserProfile *)user{
    return _user;
}

-(AKUserTableViewType)tableViewType{
    return _tableViewType;
}

#pragma mark - Public Methods

-(void)searchUser:(NSString *)searchQuery{
    _tableViewType = AKUserTableViewTypeSearch;
    _user = nil;
    _searchQuery = searchQuery;
//    _userArray = [NSMutableArray new];
    
    [[AKWeiboManager currentManager] searchUser:searchQuery callbackTarget:self];

}
-(void)followerListOfUser:(AKUserProfile *)user{
    
    _tableViewType = AKUserTableViewTypeFollower;
    _searchQuery = nil;
    _user = user;
    
//    _userArray = [NSMutableArray new];
    
    AKID *userID = [[AKID alloc] initWithIdType:AKIDTypeID text:user.IDString key:nil];
    [[AKWeiboManager currentManager] getFollowerListOfUser:userID callbackTarget:self];
    


}
-(void)followingListOfUser:(AKUserProfile *)user{
    
    _tableViewType = AKUserTableViewTypeFollowing;
    _searchQuery = nil;
    _user = user;
//    _userArray = [NSMutableArray new];
    
    AKID *userID = [[AKID alloc] initWithIdType:AKIDTypeID text:user.IDString key:nil];
    [[AKWeiboManager currentManager] getFollowingListOfUser:userID callbackTarget:self];
    

}



#pragma mark - Table View Delegate

-(NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row{
    return [AKTableRowView new];
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return _userArray.count;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    AKUserTableCellView *cellView = [tableView makeViewWithIdentifier:@"userCell" owner:self];
    
    AKUserProfile *userProfile = [_userArray objectAtIndex:row];
    cellView.userProfile = userProfile;

    return cellView;
}

-(void)tableViewDoubleClicked:(id)sender{
    
    NSInteger selectedIndex = [(NSTableView *)sender selectedRow];
    AKUserProfile *userProfile = [_userArray objectAtIndex:selectedIndex];
    AKProfileViewController *profileViewController = [[AKProfileViewController alloc] init];
    profileViewController.userID = [[AKID alloc] initWithIdType:AKIDTypeID text:userProfile.IDString key:nil];
    [self goToViewOfController:profileViewController];

}


#pragma mark - User Table Cell View

-(void)followButtonClicked:(id)sender{
    
    NSInteger row = [self.tableView rowForView:sender];
    NSLog(@"Row %ld followButtonClicked",row);
    AKUserProfile *userProfile = [_userArray objectAtIndex:row];
    
    AKID *userID = [[AKID alloc]initWithIdType:AKIDTypeID text:userProfile.IDString key:nil];
    if(userProfile.following){
        
        [[AKWeiboManager currentManager] unfollowUser:userID callbackTarget:self];
    }
    else{
        [[AKWeiboManager currentManager] followUser:userID callbackTarget:self];
    }
    
    userProfile.isProcessingFollowingRequest = YES;
    
}


#pragma mark - Weibo Manager Delegate

-(void)OnDelegateComplete:(AKWeiboManager*)weiboManager methodOption:(AKMethodAction)methodOption  httpHeader:(NSString *)httpHeader result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask{
    
    if(methodOption == AKWBOPT_GET_FRIENDSHIPS_FRIENDS || methodOption == AKWBOPT_GET_FRIENDSHIPS_FRIENDS_FOLLOWERS){
        NSLog(@"got user list");
        
        NSDictionary *resultDictionary = [result getObject];
        NSArray *userArray = [resultDictionary objectForKey:@"users"];
        _userArray = [NSMutableArray new];
        for (NSDictionary *userObject in userArray) {
            [_userArray addObject:[AKUserProfile getUserProfileFromDictionary:userObject]];
        }
        [self.tableView reloadData];

    }else if (methodOption == AKWBOPT_POST_FRIENDSHIPS_CREATE || methodOption == AKWBOPT_POST_FRIENDSHIPS_DESTROY){
    
        NSDictionary *resultDictionary = [result getObject];
        AKUserProfile *userProfile = [AKUserProfile getUserProfileFromDictionary:resultDictionary];
        //不要相信返回来的数据里面的following，那个不准的！
        userProfile.following = (methodOption == AKWBOPT_POST_FRIENDSHIPS_CREATE);
        userProfile.isProcessingFollowingRequest = NO;
    }else if (methodOption == AKWBOPT_GET_SEARCH_SUGGESTIONS_USERS){ //搜索用户
        NSArray *resultArray = [result getObject];
        NSLog(@"%@",resultArray);
        _userArray = [NSMutableArray new];
        for (NSDictionary *userInfoDictionary in resultArray) {
            AKUserProfile *userProfile = [AKUserProfile new];
            userProfile.ID  = [(NSNumber *)[userInfoDictionary objectForKey:@"uid"] longLongValue];
            userProfile.IDString = [(NSNumber *)[userInfoDictionary objectForKey:@"uid"] stringValue];
            userProfile.followers_count = [(NSNumber *)[userInfoDictionary objectForKey:@"followers_count"] longLongValue];
            userProfile.screen_name = [userInfoDictionary objectForKey:@"screen_name"];
            
            [_userArray addObject:userProfile];
        }
        [self.tableView reloadData];
        
    }
    

    
}

-(void)OnDelegateErrored:(AKWeiboManager *)weiboManager methodOption:(AKMethodAction)methodOption errCode:(NSInteger)errCode subErrCode:(NSInteger)subErrCode result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask{

}

-(void)OnDelegateWillRelease:(AKWeiboManager *)weiboManager methodOption:(AKMethodAction)methodOption pTask:(AKUserTaskInfo *)pTask{

}





@end
