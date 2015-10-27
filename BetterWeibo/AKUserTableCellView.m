//
//  AKUserTableCellView.m
//  BetterWeibo
//
//  Created by Kent on 14-3-7.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKUserTableCellView.h"

@implementation AKUserTableCellView{
    NSMutableArray *_observedObjectArray;
}

@synthesize userProfile = _userProfile;

-(void)dealloc{
    for (AKUserProfile *userProfile in _observedObjectArray) {
        [userProfile removeObserver:self forKeyPath:AKUserProfilePropertyNamedIsProcessingFollowingRequest];
    }
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.

    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

-(AKUserProfile *)userProfile{
    return _userProfile;
}

-(void)setUserProfile:(AKUserProfile *)userProfile{
    _userProfile = userProfile;
    
    self.userAlisaTextField.stringValue = userProfile.screen_name;
    self.userAvatar.userProfile = userProfile;
    self.userDescription.stringValue = [NSString stringWithFormat:@"简介：%@",userProfile.userDescription];
    self.numberOfFollowerField.stringValue = [NSString stringWithFormat:@"粉丝数：%ld",userProfile.followers_count];

    
    if(!_observedObjectArray){
        _observedObjectArray = [NSMutableArray new];
    }
    
    if(![_observedObjectArray containsObject:_userProfile]){
        [_userProfile addObserver:self forKeyPath:AKUserProfilePropertyNamedIsProcessingFollowingRequest options:0 context:NULL];
        [_observedObjectArray addObject:_userProfile];
        
    }
    [self updateFollowStatus];

}

-(void)updateFollowStatus{

    if(self.userProfile.isProcessingFollowingRequest){
        [self.followingProgrecessIndicator startAnimation:nil];
    }
    else{
        [self.followingProgrecessIndicator stopAnimation:nil];
    }
    
    if(self.userProfile.following){
        self.followButton.title = @"取消关注";
        self.followButton.buttonStyle = AKButtonStyleRedButton;
        
    }
    else{
        self.followButton.title = @"关  注";
        self.followButton.buttonStyle = AKButtonStyleBlueButton;
    }


}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

    if ([keyPath isEqualToString:AKUserProfilePropertyNamedIsProcessingFollowingRequest]) {
        
        if(self.userProfile != object){
            return;
        }
        
        [self updateFollowStatus];
        
    }

}

-(void)prepareForReuse{

    _userProfile = nil;
    self.userAlisaTextField.stringValue = @"";
    self.userAvatar.image = nil;
    self.userDescription.stringValue = @"";
    self.numberOfFollowerField.stringValue = @"";
    

}

-(void)setBackgroundStyle:(NSBackgroundStyle)backgroundStyle{
    [super setBackgroundStyle: NSBackgroundStyleLight];
}

@end
