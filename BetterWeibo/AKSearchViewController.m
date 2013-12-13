//
//  AKSearchViewController.m
//  BetterWeibo
//
//  Created by Kent on 13-11-30.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKSearchViewController.h"

@interface AKSearchViewController ()

@end

@implementation AKSearchViewController

-(id)init{

    self = [super initWithNibName:@"AKSearchViewController" bundle:nil];
    if (self) {
        self.title = @"搜    索";
        self.button = [[AKTabButton alloc]init];
        self.button.tabButtonIcon = AKTabButtonIconSearch;
        self.button.tabButtonType = AKTabButtonMiddle;
        
//        [self.button setAction:@selector(tabButtonClicked:)];
//        [self.button setTarget:self];
        
        
        //List Button
        NSButton *listButton = [[NSButton alloc]initWithFrame:NSMakeRect(0, 0, 40, 40)];
        listButton.image = [NSImage imageNamed:@"main_navbar_list_button"];
        listButton.alternateImage = [NSImage imageNamed:@"main_navbar_list_highlighted_button"];
        listButton.imagePosition = NSImageOnly;
        
        self.leftControls = [NSArray arrayWithObject:listButton];
        
        
        NSButton *postButton = [[NSButton alloc]init];
        postButton.image = [NSImage imageNamed:@"main_navbar_post_button"];
        postButton.alternateImage = [NSImage imageNamed:@"main_navbar_post_highlighted_button"];
        postButton.imagePosition = NSImageOnly;
        
        self.rightControls = [NSArray arrayWithObject:postButton];
        
        

        
        
        
        
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
