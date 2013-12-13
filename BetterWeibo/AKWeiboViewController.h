//
//  AKWeiboViewController.h
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-30.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AKTabViewController.h"
#import "AKWeiboTableCellView.h"
#import "PXListViewDelegate.h"
#import "NS(Attributed)String+Geometrics.h"
#import "EQSTRScrollView.h"
#import "AKWeiboManager.h"



@protocol AKWeiboViewControllerDelegate;

@interface AKWeiboViewController : AKTabViewController< NSTableViewDataSource,NSTableViewDelegate>{

    NSMutableArray *weiboArray;
}

@property id<AKWeiboViewControllerDelegate> delegate;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet EQSTRScrollView *scrollView;
@property AKWeiboManager *weiboManager;
@property AKWeiboTimelineType timelineType;
-(void)addStatuses:(NSArray *)statuses;
-(void)tabDidActived;

@end

@protocol AKWeiboViewControllerDelegate



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
-(void)WeiboViewRequestForStatuses:(AKWeiboViewController *)weiboViewController sinceWeiboID:(NSString *)sinceWeiboID maxWeiboID:(NSString *)maxWeiboID;

//-(void)WeiboViewRequestForStatuses:(AKWeiboViewController *)weiboViewController forUser:(NSString *)userID sinceWeiboID:(NSString *)sinceWeiboID maxWeiboID:(NSString *)maxWeiboID count:(int)count page:(int)page baseApp:(BOOL)baseApp feature:(int)feature trimUser:(int)trimUser;



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
-(void)WeiboViewRequestForGroupStatuses:(AKWeiboViewController *)weiboViewController listID:(NSString *)listID sinceWeiboID:(NSString *)sinceWeiboID maxWeiboID:(NSString *)maxWeiboID;

//-(void)WeiboViewRequestForGroupStatuses:(AKWeiboViewController *)weiboViewController listID:(NSString *)listID sinceWeiboID:(NSString *)sinceWeiboID maxWeiboID:(NSString *)maxWeiboID count:(int)count page:(int)page baseApp:(BOOL)baseApp feature:(int)feature trimUser:(int)trimUser;

@end