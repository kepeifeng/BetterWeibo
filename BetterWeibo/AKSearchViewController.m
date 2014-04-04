//
//  AKSearchViewController.m
//  BetterWeibo
//
//  Created by Kent on 13-11-30.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKSearchViewController.h"
#import "AKWeiboViewController.h"
#import "AKUserTableViewController.h"


@interface AKSearchViewController ()

@end

@implementation AKSearchViewController{
    AKWeiboViewController *_weiboViewController;
    AKUserTableViewController *_userTableViewController;
}

@synthesize searchType = _searchType;

-(id)init{

    self = [self initWithNibName:@"AKSearchViewController" bundle:[NSBundle bundleForClass:[self class]]];
    if (self) {

    }
    return self;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        self.title = @"搜    索";
        self.button = [[AKTabButton alloc]init];
        self.button.tabButtonIcon = AKTabButtonIconSearch;
        self.button.tabButtonType = AKTabButtonMiddle;
        
        _weiboViewController = [[AKWeiboViewController alloc] init];
        _userTableViewController = [[AKUserTableViewController alloc] init];
        self.searchType = AKSearchUser;
    }
    return self;
}

-(void)awakeFromNib{
    
    self.searchFieldView.backgroundType = AKViewCustomImageBackground;
    self.searchFieldView.customBackgroundImage = [NSImage imageNamed:@"search-field"];
    self.searchFieldView.customLeftWidth = 47;
    self.searchFieldView.customRightWidth = 28;
    
    self.searchBarView.backgroundType = AKViewLightGrayGraient;
    
    self.searchType = _searchType;
    
    [[self.searchTab tabViewItemAtIndex:0] setView:_weiboViewController.view];
    [[self.searchTab tabViewItemAtIndex:1] setView:_userTableViewController.view];


}

-(AKSearchType)searchType{
    return _searchType;
}

-(void)setSearchType:(AKSearchType)searchType{
    _searchType = searchType;
    
    for(NSMenuItem *item in self.searchOptionButton.menu.itemArray){
        item.state = (item.tag == searchType)?NSOnState:NSOffState;
        [self.searchOptionButton selectItem:item];
    }
    
    [self.searchTab selectTabViewItemAtIndex:_searchType];
}


- (IBAction)searchOptionSelected:(id)sender {
    NSLog(@"searchOptionSelected");
    
    NSMenuItem *selectedItem = [(NSPopUpButton *)sender selectedItem];
    if(selectedItem.isEnabled){
        return;
    }
    NSInteger selectedTag = selectedItem.tag;
    self.searchType = selectedTag;
    
}

-(void)startSearch{
    
    NSString *searchString = [self.searchField.stringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([searchString length] == 0){
        NSBeep();
        return;
    }
    if(self.searchType == AKSearchUser){
//        [[AKWeiboManager currentManager] searchUser:self.searchField.stringValue callbackTarget:self];
        [_userTableViewController searchUser:self.searchField.stringValue];
    }else{

    }


}

- (IBAction)searchFieldEndEditing:(id)sender {
    
    [self startSearch];
//    NSLog(@"searchFieldActived");
    
    
}

- (IBAction)searchButtonClicked:(id)sender {
    [self startSearch];
}



@end
