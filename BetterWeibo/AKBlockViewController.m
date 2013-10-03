//
//  AKBlockViewController.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-10-1.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKBlockViewController.h"

@interface AKBlockViewController ()

@end

@implementation AKBlockViewController


- (id)init
{
    self = [super initWithNibName:@"AKBlockViewController" bundle:nil];
    if (self) {
        
        self.title = @"黑 名 单";
        self.button = [[AKTabButton alloc]init];
        self.button.tabButtonIcon = AKTabButtonIconBlocked;
        self.button.tabButtonType = AKTabButtonBottom;
        
        
        [self.button setAction:@selector(tabButtonClicked:)];
        [self.button setTarget:self];
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.

    }
    return self;
}

@end
