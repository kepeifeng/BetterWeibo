//
//  AKNameSenceViewController.h
//  controlLabs
//
//  Created by Kent on 14-1-12.
//  Copyright (c) 2014年 Kent. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol AKNameSenceViewControllerDelegate;

@interface AKNameSenceViewController : NSViewController<NSPopoverDelegate, NSTableViewDataSource, NSTableViewDelegate>

-(id)init;

@property id<AKNameSenceViewControllerDelegate> delegate;
@property (strong) IBOutlet NSTableView *tableView;

- (IBAction)clearButtonClicked:(id)sender;

@property (strong) IBOutlet NSTextField *searchField;

@property (readonly, nonatomic) NSArray * searchResult;


-(void)displayNameSenceForView:(NSView *)view relativeToRect:(NSRect)rect;
-(void)closeNameSence;

+(instancetype)sharedInstance;

@end

@protocol AKNameSenceViewControllerDelegate

//-(void)userDidSelected:(AKNameSenceViewController *)nameSenceViewController;
-(void)nameSenceViewController:(AKNameSenceViewController *)nameSenceViewController userDidSelected:(NSString *)user;

@end