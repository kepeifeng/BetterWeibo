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


@property (weak) IBOutlet NSTextField *repostedWeiboDateDuration;
@property (weak) IBOutlet NSTextField *repostedWeiboUserAlias;
@property IBOutlet AKTextView *repostedWeiboContent;
@property (weak) IBOutlet NSMatrix *repostedWeiboImageMatrix;

-(void)loadImages:(NSArray *)images;


@end
