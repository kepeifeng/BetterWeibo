//
//  AKWeiboTableCellView.h
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-30.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AKTextField.h"
#import "AKWeiboStatus.h"
#import "AKRepostedWeiboView.h"
#import "AKTextView.h"


@interface AKWeiboTableCellView : NSTableCellView{



}

@property AKWeiboStatus *status;
@property NSString *thumbnailImageURL;

//Weibo Contents
//微博内容
@property (weak) IBOutlet NSView *weiboView;
@property (weak) IBOutlet NSImageView *userImage;
@property (weak) IBOutlet NSTextField *userAlias;
@property (weak) IBOutlet NSImageView *favMark;
@property (weak) IBOutlet NSTextField *dateDuration;
@property (weak) IBOutlet NSButtonCell *repostButton;
@property (weak) IBOutlet NSButtonCell *commentButton;
@property (weak) IBOutlet NSButtonCell *favButton;
@property (weak) IBOutlet NSButtonCell *shareButton;
//@property (weak) IBOutlet AKTextField *weiboTextField;
@property IBOutlet AKTextView *weiboTextField;

@property (weak) IBOutlet NSMatrix *images;
@property (weak) IBOutlet NSMatrix *toolbar;


//Reposted Weibo
//转发微博
@property (weak) IBOutlet AKRepostedWeiboView *repostedWeiboView;
//@property (weak) IBOutlet NSTextField *repostedWeiboDateDuration;
//@property (weak) IBOutlet NSTextField *repostedWeiboUserAlias;
//@property (weak) IBOutlet AKTextField *repostedWeiboContent;
//@property (weak) IBOutlet NSMatrix *repostedWeiboImageMatrix;


//Has Reposted Weibo
//有没有带转发微博
@property BOOL hasRepostedWeibo;

+(CGFloat)caculateWeiboHeight:(AKWeiboStatus *)weibo forWidth:(CGFloat)width;


+(CGFloat)caculateWeiboCellHeight:(AKWeiboStatus *)weibo
                         forWidth:(CGFloat)width
              repostedWeiboHeight:(CGFloat *)repostedWeiboHeight
          repostedWeiboViewHeight:(CGFloat *)repostedWeiboViewHeight
                      weiboHeight:(CGFloat *)weiboHeight
                  weiboViewHeight:(CGFloat *)weiboViewHeight;


-(void)resize;
-(void)loadImages:(NSArray *)images;
-(void)loadImages:(NSArray *)images isForRepost:(BOOL)isForRepost;
-(IBAction)toolbarClicked:(id)sender;

@property AKWeiboStatus *objectValue;


@end
