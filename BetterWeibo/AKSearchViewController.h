//
//  AKSearchViewController.h
//  BetterWeibo
//
//  Created by Kent on 13-11-30.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKTabViewController.h"
#import "AKView.h"
#import "AKWeiboManager.h"
typedef NS_ENUM(NSUInteger, AKSearchType){
    
    AKSearchStatus,
    AKSearchUser
};

@interface AKSearchViewController : AKTabViewController<NSTextFieldDelegate>

@property (strong) IBOutlet NSTabView *searchTab;
@property (strong) IBOutlet AKView *searchBarView;
@property (strong) IBOutlet AKView *searchFieldView;
@property (strong) IBOutlet NSButton *searchButton;
@property (strong) IBOutlet NSPopUpButton *searchOptionButton;
@property (strong) IBOutlet NSTextField *searchField;
@property AKSearchType searchType;

- (IBAction)searchOptionSelected:(id)sender;
- (IBAction)searchFieldEndEditing:(id)sender;
- (IBAction)searchButtonClicked:(id)sender;


@end
