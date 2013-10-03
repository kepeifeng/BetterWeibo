//
//  AKWeiboTableCellView.h
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-30.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AKWeiboTableCellView : NSTableCellView{



}

//Weibo Contents
//微博内容
@property (weak) IBOutlet NSImageView *userImage;
@property (weak) IBOutlet NSTextField *userAlias;
@property (weak) IBOutlet NSImageView *favMark;
@property (weak) IBOutlet NSTextField *dateDuration;
@property (weak) IBOutlet NSButtonCell *repostButton;
@property (weak) IBOutlet NSButtonCell *commentButton;
@property (weak) IBOutlet NSButtonCell *favButton;
@property (weak) IBOutlet NSButtonCell *shareButton;
@property (weak) IBOutlet NSTextField *weiboTextField;
@property (weak) IBOutlet NSMatrix *images;

//Reposted Weibo
//转发微博
@property (weak) IBOutlet NSView *repostedWeiboView;
@property (weak) IBOutlet NSTextField *repostedWeiboDateDuration;
@property (weak) IBOutlet NSTextField *repostedWeiboUserAlias;
@property (weak) IBOutlet NSTextField *repostedWeiboContent;
@property (weak) IBOutlet NSMatrix *repostedWeiboImageMatrix;


//Has Reposted Weibo
//有没有带转发微博
@property BOOL hasRepostedWeibo;


//@property NSString *weiboContent;

-(void)resize;




@end