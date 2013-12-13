//
//  AKMessageViewController.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-10-1.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKMessageViewController.h"

@interface AKMessageViewController ()

@end

@implementation AKMessageViewController


- (id)init
{
    self = [super initWithNibName:@"AKMessageViewController" bundle:nil];
    if (self) {
        
        self.title = @"私    信";
        self.button = [[AKTabButton alloc]init];
        self.button.tabButtonIcon = AKTabButtonIconMessage;
        self.button.tabButtonType = AKTabButtonMiddle;
//        [self.button setAction:@selector(tabButtonClicked:)];
//        [self.button setTarget:self];
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
