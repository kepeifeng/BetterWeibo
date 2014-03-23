//
//  AKPopupStatusEditorViewController.h
//  BetterWeibo
//
//  Created by Kent on 14-3-6.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AKWeiboStatus.h"
#import "AKButton.h"
#import "AKWeiboManager.h"
#import "AKStatusTextView.h"
#import "INPopoverController.h"
#import "AKEmotionTableController.h"
typedef NS_ENUM(NSUInteger, AKStatusType){
    
    AKStatusTypeNew,
    AKStatusTypeRepost,
    AKStatusTypeComment
    
};

@interface AKPopupStatusEditorViewController : NSViewController<AKWeiboManagerDelegate, AKEmotionTableControllerDelegate, AKStatusTextViewDelegate>

- (IBAction)cancelButtonClicked:(id)sender;
- (IBAction)postButtonClicked:(id)sender;
- (IBAction)toolbarClicked:(id)sender;
@property (strong) IBOutlet AKButton *postButton;
@property (strong) IBOutlet NSProgressIndicator *progressIndicator;
@property (strong) IBOutlet AKStatusTextView *statusTextView;
@property (readonly) AKWeiboStatus *status;
@property (strong) IBOutlet NSTextField *titleTextField;
@property INPopoverController *popoverController;
@property (strong) IBOutlet NSTextField *countField;
@property (readonly) BOOL isFreezing;

-(void)commentOnStatus:(AKWeiboStatus *)status;
-(void)repostStatus:(AKWeiboStatus *)status;
//@property AKWeiboStatus *targetStatus;
@property (readonly) AKStatusType statusType;

@property (strong) IBOutlet NSButton *additionActionButton;


@end
