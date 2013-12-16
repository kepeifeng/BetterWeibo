//
//  AKTabController.h
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-29.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AKTabButton.h"
#import "AKWeiboViewController.h"
#import "AKTabViewController.h"
#import "AKTabButton.h"
#import "AKPanelView.h"
#import "AKUserProfile.h"
#import "AKWeiboViewGroupItem.h"

//@class AKTabViewController;

@protocol AKTabControlDelegate;
//===================== AKTabControl =====================

@interface AKTabControl : NSView <AKTabViewControllerDelegate,AKWeiboViewControllerDelegate>{

    NSMutableArray *tabControlMatrixGroup;
    NSMutableArray *userButtonGroup;

}

@property NSColor *customBackgroundColor;
@property NSMutableArray *tabViewControllers;
@property IBOutlet NSTabView *targetTabView;
@property id<AKTabControlDelegate> delegate;

-(void)addControlGroup:(NSString *)userID;
-(void)switchToGroupAtIndex:(NSInteger)index;
-(void)setLightIndicatorState:(BOOL)state forButton:(AKTabButtonType)buttonType userID:(NSString *)userID;
-(BOOL)isUserExist:(NSString *)userID;

-(void)updateUser:(AKUserProfile *)userProfile;
-(void)setAvatarForUser:(NSString *)userID URL:(NSString *)url;
-(void)addStatuses:(NSArray *)statuses;
-(void)addStatuses:(NSArray *)statuses timelineType:(AKWeiboTimelineType)timelineType forUser:(NSString *)userID;


//-(void)addViewController:(AKTabViewController *)viewController;

@end


@protocol AKTabControlDelegate


/**
 *  请求获得用户好友的微博状态
 *
 *  @param weiboViewController 发出请求的View
 *  @param userID              用户ID
 *  @param sinceWeiboID        若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *  @param maxWeiboID          若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *  @param count               单页返回的记录条数，最大不超过100，默认为20。
 *  @param page                返回结果的页码，默认为1。
 *  @param baseApp             是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 *  @param feature             过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
 *  @param trimUser            返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0。
 */
-(void)WeiboViewRequestForStatuses:(AKWeiboViewController *)weiboViewController forUser:(NSString *)userID sinceWeiboID:(NSString *)sinceWeiboID maxWeiboID:(NSString *)maxWeiboID count:(int)count page:(int)page baseApp:(BOOL)baseApp feature:(int)feature trimUser:(int)trimUser;





/**
 *  请求获得好友分组的微博状态
 *
 *  @param weiboViewController 发出请求的View
 *  @param userID              用户ID
 *  @param listID              好友分组ID
 *  @param sinceWeiboID        若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *  @param maxWeiboID          若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *  @param count               单页返回的记录条数，最大不超过100，默认为20。
 *  @param page                返回结果的页码，默认为1。
 *  @param baseApp             是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 *  @param feature             过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
 *  @param trimUser            返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0。
 */
-(void)WeiboViewRequestForGroupStatuses:(AKWeiboViewController *)weiboViewController listID:(NSString *)listID sinceWeiboID:(NSString *)sinceWeiboID maxWeiboID:(NSString *)maxWeiboID count:(int)count page:(int)page baseApp:(BOOL)baseApp feature:(int)feature trimUser:(int)trimUser;


/**
 *  当视图发生转变是该方法被激活。
 *
 *  @param view 新的视图
 */
-(void)viewDidSelected:(NSViewController *)viewController;

@end
