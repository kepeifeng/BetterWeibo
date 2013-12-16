//
//  AKWeiboViewGroupItem.h
//  BetterWeibo
//
//  Created by Kent on 13-12-1.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKUserButton.h"
#import "AKWeiboViewController.h"
#import "AKMessageViewController.h"
#import "AKBlockViewController.h"
#import "AKSearchViewController.h"
#import "AKProfileViewController.h"

@interface AKWeiboViewGroupItem : NSObject

@property NSString *userID;
@property NSTabView *tabView;
@property AKUserButton *userButton;
@property NSMatrix *userControlMatrix;
@property AKWeiboViewController *weiboViewController;
@property AKWeiboViewController *mentionViewController;
@property AKWeiboViewController *favoriteViewController;



@end
