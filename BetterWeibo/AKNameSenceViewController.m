//
//  AKNameSenceViewController.m
//  controlLabs
//
//  Created by Kent on 14-1-12.
//  Copyright (c) 2014年 Kent. All rights reserved.
//

#import "AKNameSenceViewController.h"

@interface AKNameSenceViewController ()

@end

@implementation AKNameSenceViewController{
    
    NSPopover *_popover;
    NSArray *_userProfiles;
//    NSArray *_searchResult;
    
}

@synthesize searchResult = _searchResult;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        [super loadView];
        [self loadTestData];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchTextChanged:) name:NSControlTextDidChangeNotification object:self.searchField];
        
        [self.tableView setTarget:self];
        [self.tableView setDoubleAction:@selector(tableViewDoubleClicked:)];
        
        //[self.tableView reloadData];
    }
    return self;
}



-(void)loadTestData{

    NSMutableArray *array = [NSMutableArray array];
    
    [array addObject:@"南都周刊"];
    [array addObject:@"南方都市报"];
    [array addObject:@"南方周末"];
    [array addObject:@"小K曾经说过"];
    [array addObject:@"陈丹苗"];
    [array addObject:@"Kitty是猫猫"];
    [array addObject:@"柯培锋"];
    [array addObject:@"梁思成"];
    [array addObject:@"梁启超"];
    [array addObject:@"康有为"];
    [array addObject:@"李白"];
    [array addObject:@"杜甫"];
    [array addObject:@"王维"];
    [array addObject:@"北方人在南方"];
    [array addObject:@"南来北往"];
    [array addObject:@"李开复"];
    [array addObject:@"李嘉诚"];
    [array addObject:@"李泽楷"];
    [array addObject:@"李小龙"];
    [array addObject:@"不要问我从哪里来"];
    [array addObject:@"风中有朵雨做的云"];
    [array addObject:@"中国铁道部"];
    [array addObject:@"天天"];
    [array addObject:@"Kimi"];
    [array addObject:@"我是Cindy"];
//    
//    for(NSInteger i=0; i<20; i++){
//    
//        [array addObject:[NSString stringWithFormat:@"Row - %ld",i]];
//    
//    }
    
    _userProfiles = array;


}


- (void)_makePopoverIfNeeded {
    if (_popover == nil) {
        // Create and setup our window
        _popover = [[NSPopover alloc] init];
        // The popover retains us and we retain the popover. We drop the popover whenever it is closed to avoid a cycle.
        _popover.contentViewController = self;
        _popover.behavior = NSPopoverBehaviorSemitransient;
        _popover.delegate = self;
    }
}

-(void)displayNameSenceForView:(NSView *)view relativeToRect:(NSRect)rect{

    [self _makePopoverIfNeeded];
    [_popover showRelativeToRect:rect ofView:view preferredEdge:NSMinYEdge];
    

}

-(NSArray *)searchResult{

    
    
    if([self.searchField.stringValue isEqualToString:@""]){
        return _userProfiles;
    }
    
    if(!_searchResult){
        
        _searchResult = _userProfiles;
    }
    
    return _searchResult;

}

-(void)searhForText:(NSString *)text{

    if([text isEqualToString:@""]){
        _searchResult = _userProfiles;
        [self.tableView reloadData];
        return;
    }
    
    NSMutableArray *searchResult = [NSMutableArray array];

    
    for(NSString *userName in _userProfiles){
    
        if([userName rangeOfString:text options:NSCaseInsensitiveSearch].location != NSNotFound){
        
            [searchResult addObject:userName];
            
        }
    
    }
    
    _searchResult = searchResult;
    [self.tableView reloadData];
    

}

-(void)searchTextChanged:(NSNotification *)notification{


    [self searhForText:[(NSTextField *)(notification.object) stringValue]];

}

+(instancetype)sharedInstance{
    
    static id gSharedInstance = nil;
    if (gSharedInstance == nil) {
        gSharedInstance = [[[self class] alloc] initWithNibName:@"AKNameSenceViewController" bundle:[NSBundle bundleForClass:[self class]]];
    }
    
    return gSharedInstance;
    
}


- (IBAction)clearButtonClicked:(id)sender {
    
    [self.searchField setStringValue:@""];
    
}
@end


@implementation AKNameSenceViewController(NSTableViewDelegate)

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{

    return self.searchResult.count;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{

    NSTableCellView *cell = [tableView makeViewWithIdentifier:@"userCell" owner:self];

    
//    AKUserProfile *user = _userProfiles[row];
    [cell.textField setStringValue:[NSString stringWithFormat:@"%@", (NSString *)[self.searchResult objectAtIndex:row]]];
    [cell.imageView setImage:[NSImage imageNamed:@"avatar_default"]];
    
    return cell;
    

}

-(void)tableViewDoubleClicked:(id)sender{


    NSInteger selectedIndex = [self.tableView clickedRow];
    
    if(self.delegate){
        
        [self.delegate nameSenceViewController:self userDidSelected:(NSString *)[self.searchResult objectAtIndex:selectedIndex]];
    }
    
}




@end
