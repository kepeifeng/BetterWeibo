//
//  AKRepostedWeiboView.h
//  BetterWeibo
//
//  Created by Kent on 13-10-8.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AKWeiboStatus.h"
#import "AKTextField.h"
#import "AKTextView.h"

@interface AKRepostedWeiboView : NSView

@property AKWeiboStatus * repostedStatus;


@property (nonatomic, strong) IBOutlet NSTextField *repostedWeiboDateDuration;
@property (nonatomic, strong) IBOutlet NSTextField *repostedWeiboUserAlias;
@property (nonatomic, strong) IBOutlet AKTextView *repostedWeiboContent;
@property (strong) IBOutlet NSMatrix *repostedWeiboImageMatrix;

-(void)loadImages:(NSArray *)images;


@end
