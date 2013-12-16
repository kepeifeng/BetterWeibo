//
//  AKWeiboStatusDetailView.h
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-12-15.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AKTextField.h"
#import "AKWeiboStatus.h"
#import "PXListView.h"

@interface AKWeiboStatusDetailView : NSView


@property AKWeiboStatus *status;

@property NSString *thumbnailImageURL;
@property (weak) IBOutlet NSView *statusView;

//Weibo Contents
//微博内容

@property (weak) IBOutlet NSImageView *userImage;
@property (weak) IBOutlet NSTextField *userAlias;
@property (weak) IBOutlet NSTextField *dateDuration;
@property (weak) IBOutlet NSButtonCell *repostButton;
@property (weak) IBOutlet NSButtonCell *commentButton;
@property (weak) IBOutlet NSButtonCell *favButton;
@property (weak) IBOutlet NSButtonCell *shareButton;
@property (weak) IBOutlet AKTextField *weiboTextField;
@property (weak) IBOutlet NSMatrix *images;
@property (weak) IBOutlet NSMatrix *toolbar;
@property (weak) IBOutlet NSTextField *statusDateField;


//Reposted Weibo
//转发微博
@property (weak) IBOutlet NSView *repostedWeiboView;
@property (weak) IBOutlet NSTextField *repostedWeiboDateDuration;
@property (weak) IBOutlet NSTextField *repostedWeiboUserAlias;
@property (weak) IBOutlet AKTextField *repostedWeiboContent;
@property (weak) IBOutlet NSMatrix *repostedWeiboImageMatrix;


//Has Reposted Weibo
//有没有带转发微博
@property BOOL hasRepostedWeibo;

@property (weak) IBOutlet PXListView *listView;

-(void)resize;
-(void)loadImages:(NSArray *)imageURL;
-(void)loadImages:(NSArray *)imageURL isForRepost:(BOOL)isForRepost;
-(IBAction)toolbarClicked:(id)sender;

@end
