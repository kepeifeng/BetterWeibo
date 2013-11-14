//
//  AKTabView.h
//  BetterWeibo
//
//  Created by Kent on 13-11-5.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKTabControl.h"
#import "AKUserProfile.h"

@protocol AKTabViewDelegate;

@interface AKTabView : NSObject

@property IBOutlet AKTabControl *tabControl;
@property id<AKTabViewDelegate> delegate;

-(void)addUser:(AKUserProfile *)userProfile;
-(BOOL)isUserExist:(NSString *)userID;

@end

@protocol AKTabViewDelegate

-(void)needToUpdateStatus:(AKTabView *)tabView userID:(NSString *)userID;
-(void)needToUpdateMention:(AKTabView *)tabView userID:(NSString *)userID;
-(void)needToUpdateComment:(AKTabView *)tabView userID:(NSString *)userID;
-(void)needToUpdateFavorite:(AKTabView *)tabView userID:(NSString *)userID;
-(void)needToUpdateProfile:(AKTabView *)tabView userID:(NSString *)userID;



@end