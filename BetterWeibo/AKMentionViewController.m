//
//  AKMentionViewController.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-10-1.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKMentionViewController.h"

@interface AKMentionViewController ()

@end

@implementation AKMentionViewController

-(id)init{

//    self = [super initWithNibName:@"AKWeiboViewController" bundle:nil];
    self = [super init];
    
    if(self){
        // Initialization code here.
        self.title = @"提    及";
        self.button = [[AKTabButton alloc]init];
        self.button.tabButtonIcon = AKTabButtonIconMention;
        self.button.tabButtonType = AKTabButtonMiddle;
        
        
        [self.button setAction:@selector(tabButtonClicked:)];
        [self.button setTarget:self];
    }
    
    return self;
    

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

-(void)tabButtonClicked:(id)sender{

    [super tabButtonClicked:sender];

    
}

@end
