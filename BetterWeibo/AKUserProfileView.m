//
//  AKUserProfileView.m
//  BetterWeibo
//
//  Created by Kent on 14-3-3.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKUserProfileView.h"
#import "AKWeiboManager.h"

@interface AKUserProfileView()

@property (readonly, nonatomic) NSGradient *backgroundGradient;

@end


@implementation AKUserProfileView{

    NSTextField *_follower;
    NSTextField *_following;
    NSTextField *_status;


    

}
@synthesize userProfile = _userProfile;
@synthesize backgroundGradient = _backgroundGradient;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        
        NSFont *smallLabelFont = [NSFont systemFontOfSize:12];
        _follower = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 30, 20)];
        _follower.stringValue = @"粉丝";
        _follower.font = smallLabelFont;
        [_follower setEditable:NO];
        [_follower setDrawsBackground:NO];
        [_follower setBordered:NO];
        [_follower setAlignment:NSCenterTextAlignment];
        
        [self addSubview:_follower];
        
        _following = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 30, 20)];
        _following.stringValue = @"关注";
        _following.font = smallLabelFont;
        [_following setEditable:NO];
        [_following setDrawsBackground:NO];
        [_following setBordered:NO];
        [_following setAlignment:NSCenterTextAlignment];
        
        [self addSubview:_following];
        
        _status = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 30, 20)];
        _status.stringValue = @"微博";
        _status.font = smallLabelFont;
        [_status setEditable:NO];
        [_status setDrawsBackground:NO];
        [_status setBordered:NO];
        [_status setAlignment:NSCenterTextAlignment];
        
        [self addSubview:_status];
        
        NSFont *numberLabelFont = [NSFont systemFontOfSize:24];
        self.numberOfFollowing = [[NSButton alloc] initWithFrame:NSMakeRect(0, 0, 60, 60)];
        [self.numberOfFollowing setFont:numberLabelFont];
//        self.numberOfFollowing.autoresizingMask = NSViewMinXMargin | NSViewMaxXMargin;
//        [self.numberOfFollowing setEditable:NO];
//        [self.numberOfFollowing setDrawsBackground:NO];
        [self.numberOfFollowing setButtonType:NSMomentaryChangeButton];
        [self.numberOfFollowing setBordered:NO];
        [self.numberOfFollowing setAlignment:NSCenterTextAlignment];
        [self.numberOfFollowing setTitle:@"0"];

        
        [self addSubview:self.numberOfFollowing];
        
        self.numberOfFollower = [[NSButton alloc] initWithFrame:NSMakeRect(0, 0, 60, 60)];
        [self.numberOfFollower  setFont:numberLabelFont];
//        self.numberOfFollower.autoresizingMask = NSViewMinXMargin | NSViewMaxXMargin;
//        [self.numberOfFollower setEditable:NO];
//        [self.numberOfFollower setDrawsBackground:NO];
        [self.numberOfFollower setButtonType:NSMomentaryChangeButton];
        [self.numberOfFollower setBordered:NO];
        [self.numberOfFollower setAlignment:NSCenterTextAlignment];
        [self.numberOfFollower setTitle:@"0"];

        [self addSubview:self.numberOfFollower];
        
        
        self.numberOfStatuses = [[NSButton alloc] initWithFrame:NSMakeRect(0, 0, 60, 60)];
        [self.numberOfStatuses  setFont:numberLabelFont];
//        self.numberOfFollowing.autoresizingMask = NSViewMinXMargin | NSViewMaxXMargin;
//        [self.numberOfStatuses setEditable:NO];
//        [self.numberOfStatuses setDrawsBackground:NO];
        [self.numberOfFollowing setButtonType:NSMomentaryChangeButton];
        [self.numberOfStatuses setBordered:NO];
        [self.numberOfStatuses setAlignment:NSCenterTextAlignment];
        [self.numberOfStatuses setTitle:@"0"];
        
        [self addSubview:self.numberOfStatuses];
        
        self.userDescription = [[AKTextField alloc] initWithFrame:NSMakeRect(0, 0, 300, 20)];
        [self.userDescription setEditable:NO];
        [self.userDescription setDrawsBackground:NO];
        [self.userDescription setBordered:NO];
        
        [self addSubview:self.userDescription];
        
        
        self.userAvatar = [[AKUserButton alloc] initWithFrame:NSMakeRect(0, 0, 60, 60)];
//        [self.userAvatar setEnabled:NO];
        [(NSButtonCell *)self.userAvatar.cell setImageScaling:NSImageScaleProportionallyUpOrDown];
        [self addSubview:self.userAvatar];
        
        self.varifiedInfo = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 300, 20)];
        [self.varifiedInfo setEditable:NO];
        [self.varifiedInfo setDrawsBackground:NO];
        [self.varifiedInfo setBordered:NO];
        [self.varifiedInfo.cell setTextColor:[NSColor grayColor]];


        [self addSubview:self.varifiedInfo];
        
        self.screenName = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 300, 30)];
        self.screenName.font = [NSFont systemFontOfSize:18];
        [self.screenName setEditable:NO];
        [self.screenName setDrawsBackground:NO];
        [self.screenName setBordered:NO];
        
        [self addSubview:self.screenName];
        
        self.followButton = [[AKButton alloc] initWithFrame:NSMakeRect(0, 0, 75, 31)];
        [self addSubview:self.followButton];

        self.followingProgrecessIndicator = [[NSProgressIndicator alloc] init];
        [self.followingProgrecessIndicator setDisplayedWhenStopped:NO];
        [self.followingProgrecessIndicator setControlSize:NSSmallControlSize];
        [self.followingProgrecessIndicator sizeToFit];
        [self.followingProgrecessIndicator setStyle:NSProgressIndicatorSpinningStyle];
        
        [self addSubview:self.followingProgrecessIndicator];
        
        NSShadow *userProfileViewShadow = [[NSShadow alloc]init];
        userProfileViewShadow.shadowBlurRadius = 5;
        userProfileViewShadow.shadowColor = [NSColor colorWithCalibratedWhite:0 alpha:0.5];
        userProfileViewShadow.shadowOffset = NSMakeSize(0, -5);
        
//        self.wantsLayer = YES;
        self.shadow = userProfileViewShadow;

    }
    return self;
}


-(void)resizeSubviewsWithOldSize:(NSSize)oldSize{

    NSInteger y = 5;
    
    NSInteger numberLabelWidth = oldSize.width/3;
    NSInteger smallNumberLabelHeight = 16;
    NSInteger largeNumberLabelHeight = 36;
    
    [_follower setFrame:NSMakeRect(0, y, numberLabelWidth, smallNumberLabelHeight)];
    [_following setFrame:NSMakeRect(numberLabelWidth, y, numberLabelWidth, smallNumberLabelHeight)];
    [_status setFrame:NSMakeRect(numberLabelWidth*2, y, numberLabelWidth, smallNumberLabelHeight)];
    
    y += smallNumberLabelHeight + 5;
    
    [self.numberOfFollower setFrame:NSMakeRect(0, y, numberLabelWidth, largeNumberLabelHeight)];
    [self.numberOfFollowing setFrame:NSMakeRect(numberLabelWidth, y, numberLabelWidth, largeNumberLabelHeight)];
    [self.numberOfStatuses setFrame:NSMakeRect(numberLabelWidth * 2, y, numberLabelWidth, largeNumberLabelHeight)];
    
    y += largeNumberLabelHeight +10;
    
    NSInteger descMargin = 10;
    
    [self.userDescription setFrameSize:NSMakeSize(oldSize.width - descMargin*2, 100)];
    NSSize userDescSize = self.userDescription.intrinsicContentSize;
    [self.userDescription setFrame:NSMakeRect(descMargin, y, userDescSize.width, userDescSize.height)];
    
    y += userDescSize.height + 10;
    
    [self.userAvatar setFrameOrigin:NSMakePoint(descMargin, y)];
    
    y += self.userAvatar.frame.size.height;
    
    NSInteger x = self.userAvatar.frame.origin.x + self.userAvatar.frame.size.width + descMargin;
    
    NSInteger screenNameY = y - self.screenName.frame.size.height;
    [self.screenName setFrame:NSMakeRect(x, screenNameY, oldSize.width - x, self.screenName.frame.size.height)];
    
    screenNameY -= self.varifiedInfo.frame.size.height;
    [self.varifiedInfo setFrame:NSMakeRect(x, screenNameY, oldSize.width - x, self.varifiedInfo.frame.size.height)];
    
    NSPoint followButtonOrigin = NSMakePoint(0,0);
    followButtonOrigin.y = y - self.followButton.frame.size.height;
    followButtonOrigin.x = oldSize.width - self.followButton.frame.size.width - 10;
    [self.followButton setFrameOrigin:followButtonOrigin];
    
    NSPoint followingIndicatorOrigin = followButtonOrigin;
    followingIndicatorOrigin.x -= self.followingProgrecessIndicator.frame.size.width - 10;
    followingIndicatorOrigin.y += (self.followButton.frame.size.height - self.followingProgrecessIndicator.frame.size.height)/2;
    [self.followingProgrecessIndicator setFrameOrigin:followingIndicatorOrigin];
    
    
    [super resizeSubviewsWithOldSize:oldSize];


}

-(NSSize)intrinsicContentSize{
    NSSize contentSize = NSZeroSize;
    contentSize.width = self.frame.size.width;
    contentSize.height = self.userDescription.frame.size.height+161;
    return contentSize;
    
}


-(AKUserProfile *)userProfile{
    return _userProfile;
}

-(NSGradient *)backgroundGradient{
    if(!_backgroundGradient){
        NSColor *startColor = [NSColor colorWithCalibratedWhite:0.8 alpha:1];
        NSColor *endColor = [NSColor colorWithCalibratedWhite:0.9 alpha:1];
        _backgroundGradient = [[NSGradient alloc] initWithStartingColor:startColor endingColor:endColor];
    }
    return _backgroundGradient;
    
}

-(void)setUserProfile:(AKUserProfile *)userProfile{

    _userProfile = userProfile;
    self.screenName.stringValue = userProfile.screen_name;
    self.varifiedInfo.stringValue = userProfile.verified_reason;
    self.userAvatar.userProfile = userProfile;
//    self.userAvatar.image = userProfile.profileImage;
    self.userDescription.stringValue = userProfile.userDescription;
    self.numberOfFollower.title = [NSString stringWithFormat:@"%ld",userProfile.followers_count];
    self.numberOfFollowing.title = [NSString stringWithFormat:@"%ld",userProfile.friends_count];
    self.numberOfStatuses.title = [NSString stringWithFormat:@"%ld",userProfile.statuses_count];
    

    [self resizeSubviewsWithOldSize:self.frame.size];
    
}





- (void)drawRect:(NSRect)dirtyRect
{

	[self.backgroundGradient drawInRect:self.bounds angle:-90];
    [super drawRect:dirtyRect];
	
    // Drawing code here.
}


@end
