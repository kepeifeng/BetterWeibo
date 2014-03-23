//
//  AKEmotionTableController.h
//  BetterWeibo
//
//  Created by Kent on 14-1-11.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AKEmotion.h"
@protocol AKEmotionTableControllerDelegate;

@interface AKEmotionTableController : NSViewController<NSPopoverDelegate, NSPageControllerDelegate>{
    
    NSPopover *_popover;
    
}

@property id<AKEmotionTableControllerDelegate> delegate;
@property IBOutlet NSPageController *pageController;
@property (readonly,nonatomic) BOOL isShown;

@property (strong) IBOutlet NSBox *emotionViewContainer;

/**
 *  返回选择的表情的代码，比如"[嘻嘻]"
 */
@property NSString *selectedEmotionCode;
@property NSIndexPath *selectedEmotionIndexPath;
@property NSSize cellSize;
@property NSInteger numberOfRow;
@property NSInteger numberOfColumn;

-(void)displayEmotionDialogForView:(NSView *)view relativeToRect:(NSRect)rect;
-(void)displayEmotionDialogForView:(NSView *)view;
-(void)closeEmotionDialog;

+(AKEmotionTableController *)sharedInstance;

@end

@protocol AKEmotionTableControllerDelegate

-(void)emotionTable:(AKEmotionTableController *)emotionTable emotionSelected:(AKEmotion *)emotion;

@end