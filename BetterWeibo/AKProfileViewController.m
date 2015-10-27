//
//  AKProfileViewController.m
//  BetterWeibo
//
//  Created by Kent on 13-11-30.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKProfileViewController.h"
#import "AKUserProfileView.h"
#import "AKUserTableViewController.h"


@interface AKProfileViewController ()

@property  (nonatomic) AKUserProfile *userProfile;

@end

@implementation AKProfileViewController{

    BOOL _isLoadingUserProfile;
    BOOL _isUserProfileLoaded;
    AKUserProfileView *_userProfileView;
    NSMutableArray *_observedObjectArray;
}


-(void)dealloc{
    
    for (AKUserProfile *userProfile in _observedObjectArray) {
        [userProfile removeObserver:self forKeyPath:AKUserProfilePropertyNamedIsProcessingFollowingRequest];
    }
}


-(id)init{

    self = [super init];
    if(self){
    
        [self loadView];
        self.title = @"用  户";
        self.button = [[AKTabButton alloc]init];
        self.button.tabButtonIcon = AKTabButtonIconUser;
        self.button.tabButtonType = AKTabButtonMiddle;
        self.timelineType = AKUserTimeline;
        [self setupUserProfileView];

    
    }
    return self;
    
}

-(void)disableScrollView{

    [self.scrollView setHasHorizontalScroller:NO];
    [self.scrollView setHasVerticalScroller:NO];
    [self.scrollView setHorizontalScrollElasticity:NSScrollElasticityNone];
    [self.scrollView setVerticalScrollElasticity:NSScrollElasticityNone];
    
}

-(void)awakeFromNib{

    
    [super awakeFromNib];
    
    
    
    //Sroll to Refresh
/*
    self.scrollView.refreshBlock = ^(EQSTRScrollView *scrollView){
        
        NSString *sinceWeiboID = (weiboArray.count>0)?((AKWeiboStatus *)[weiboArray firstObject]).idstr:nil;
        
        [[AKWeiboManager currentManager] getStatusForUser:self.userID sinceWeiboID:sinceWeiboID maxWeiboID:nil count:30 page:1 baseApp:NO feature:0 trimUser:0 timelineType:self.timelineType callbackTarget:self];
        
    };
    
    self.scrollView.refreshBottomBlock = ^(EQSTRScrollView *scrollView){
        NSLog(@"refreshBottomBlock Actived.");
        
        NSString *maxWeiboID = (weiboArray.count>0)?[NSString stringWithFormat:@"%lld",((AKWeiboStatus *)[weiboArray lastObject]).ID-1]:nil;
        
        [[AKWeiboManager currentManager] getStatusForUser:self.userID sinceWeiboID:nil maxWeiboID:maxWeiboID count:30 page:1 baseApp:NO feature:0 trimUser:0 timelineType:self.timelineType callbackTarget:self];
        
    };
*/
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(viewBoundsChanged:) name:NSViewFrameDidChangeNotification object:self.view];
    
    self.view.wantsLayer = YES;
}

-(void)viewBoundsChanged:(NSNotification *)notification{
    NSSize userProfileViewSize = _userProfileView.intrinsicContentSize;
    
    [_userProfileView setFrame:NSMakeRect(0,
                                          self.view.frame.size.height - userProfileViewSize.height,
                                          userProfileViewSize.width,
                                          userProfileViewSize.height)];
    
    for (NSLayoutConstraint *constraint in self.view.constraints) {
        
        if(constraint.firstItem == self.scrollView && constraint.firstAttribute == NSLayoutAttributeTop){
            constraint.constant = userProfileViewSize.height;
            break;
        }
    }
}

-(void)setupUserProfileView{
    
    //    NSView *userProfileView = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, self.view.frame.size.width,
    _userProfileView = [[AKUserProfileView alloc]initWithFrame:NSMakeRect(0, 0, self.view.frame.size.width, 200)];
//    _userProfileView.wantsLayer = YES;
//    _userProfileView.layer.backgroundColor = CGColorCreateGenericRGB(0, 0, 0, 1);
    _userProfileView.autoresizingMask = NSViewWidthSizable | NSViewMinYMargin;
    [self.view addSubview:_userProfileView];
//    _userProfileView = userProfileView;
    
    for (NSLayoutConstraint *constraint in self.view.constraints) {
        
//        NSLog(@"%@",constraint);
        if(constraint.firstItem == self.scrollView && constraint.firstAttribute == NSLayoutAttributeTop){
            constraint.constant = _userProfileView.frame.size.height;
            break;
        }
    }
    [_userProfileView setFrameOrigin:NSMakePoint(0, self.view.frame.size.height - _userProfileView.frame.size.height)];
    
    [_userProfileView.numberOfFollowing setTarget:self];
    [_userProfileView.numberOfFollowing setAction:@selector(numberOfFollowingButtonClicked:)];
    
    [_userProfileView.numberOfFollower setTarget:self];
    [_userProfileView.numberOfFollower setAction:@selector(numberOfFollowerButtonClicked:)];
    
    [_userProfileView.followButton setTarget:self];
    [_userProfileView.followButton setAction:@selector(followButtonClicked:)];
    
//    [_userProfileView setWantsLayer:YES];

    
//    _userProfileView.layer.shadowColor = CGColorCreateGenericGray(0, 1);
//    _userProfileView.layer.shadowRadius = 5.0;
//    _userProfileView.layer.shadowOpacity = 1;

//    [_userProfileView setShadow:userProfileViewShadow];
//    [_userProfileView setNeedsDisplay:YES];
    
    
//    [_userProfileView resizeSubviewsWithOldSize:_userProfileView.frame.size];

}

-(void)tabDidActived{
    
    [[AKWeiboManager currentManager] getUserDetail:self.userID callbackTarget:self];
    
    if([self.userID.ID isEqualToString:[[AKUserManager defaultUserManager] currentUserID]]){
        [super tabDidActived];
    }
    else{
//        [self disableScrollView];
        [self.scrollView setHidden:YES];
    }
    
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

-(void)OnDelegateComplete:(AKWeiboManager *)weiboManager methodOption:(AKMethodAction)methodOption httpHeader:(NSString *)httpHeader result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask{


    //NSDictionary *resultDictionary = (NSDictionary *)[result getObject];
    
    if(methodOption == AKWBOPT_GET_USERS_SHOW){
    
        AKUserProfile *userProfile = (AKUserProfile *)[AKUserProfile getUserProfileFromDictionary:[result getObject]];
        self.userProfile = userProfile;
    
    }
    
    [super OnDelegateComplete:weiboManager methodOption:methodOption httpHeader:httpHeader result:result pTask:pTask];


}

-(void)OnDelegateErrored:(AKWeiboManager *)weiboManager methodOption:(AKMethodAction)methodOption error:(AKError *)error result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask{

    [super OnDelegateErrored:weiboManager methodOption:methodOption error:error result:result pTask:pTask];
}

#pragma mark - Properties

-(AKUserProfile *)userProfile{
    return _userProfileView.userProfile;
}

-(void)setUserProfile:(AKUserProfile *)userProfile{
    _userProfileView.userProfile = userProfile;
    
    if(!_observedObjectArray){
        _observedObjectArray = [NSMutableArray new];
    }
    
    if(![_observedObjectArray containsObject:userProfile]){
        [userProfile addObserver:self forKeyPath:AKUserProfilePropertyNamedIsProcessingFollowingRequest options:0 context:NULL];
        [_observedObjectArray addObject:userProfile];
        
    }
    
    self.title = userProfile.screen_name;
    [self updateFollowStatus];
    
    
}

-(void)updateFollowStatus{
    
    if([[AKUserManager defaultUserManager] currentUserProfile] == self.userProfile){
        [_userProfileView.followButton setHidden:YES];
    }
    else{
        [_userProfileView.followButton setHidden:NO];
    }
    if(self.userProfile.isProcessingFollowingRequest){
        [_userProfileView.followingProgrecessIndicator startAnimation:nil];
    }
    else{
        [_userProfileView.followingProgrecessIndicator stopAnimation:nil];
    }
    
    if(self.userProfile.following){
        _userProfileView.followButton.title = @"取消关注";
        _userProfileView.followButton.buttonStyle = AKButtonStyleRedButton;
        
    }
    else{
        _userProfileView.followButton.title = @"关  注";
        _userProfileView.followButton.buttonStyle = AKButtonStyleBlueButton;
    }
    
}



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if ([keyPath isEqualToString:AKUserProfilePropertyNamedIsProcessingFollowingRequest]) {
        
        if(self.userProfile != object){
            return;
        }
        
        [self updateFollowStatus];
        
    }
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    
}

#pragma mark - Actions

-(void)numberOfFollowingButtonClicked:(id)sender{
    if(!self.userProfile){
        return;
    }
    AKUserTableViewController *userTableViewController = [AKUserTableViewController new];
    [userTableViewController followingListOfUser:self.userProfile];
    [self goToViewOfController:userTableViewController];

}

-(void)numberOfFollowerButtonClicked:(id)sender{
    if(!self.userProfile){
        return;
    }
    AKUserTableViewController *userTableViewController = [AKUserTableViewController new];
    [userTableViewController followerListOfUser:self.userProfile];
    [self goToViewOfController:userTableViewController];
    
}

#pragma mark - User Table Cell View

-(void)followButtonClicked:(id)sender{
    
    //    NSInteger row = [self.tableView rowForView:sender];
    //    NSLog(@"Row %ld followButtonClicked",row);
    AKUserProfile *userProfile = self.userProfile;
    
    AKID *userID = [[AKID alloc]initWithIdType:AKIDTypeID text:userProfile.IDString key:nil];
    if(userProfile.following){
        
        [[AKWeiboManager currentManager] unfollowUser:userID callbackTarget:self];
    }
    else{
        [[AKWeiboManager currentManager] followUser:userID callbackTarget:self];
    }
    
    userProfile.isProcessingFollowingRequest = YES;
    
}

@end
