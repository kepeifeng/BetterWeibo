//
//  AKEmotionTableController.h
//  BetterWeibo
//
//  Created by Kent on 14-1-11.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AKEmotionTableController : NSViewController<NSPopoverDelegate, NSPageControllerDelegate>{
    
    NSPopover *_popover;
    
}

@property IBOutlet NSPageController *pageController;

@property (strong) IBOutlet NSBox *emotionViewContainer;

/**
 *  返回选择的表情的代码，比如"[嘻嘻]"
 */
@property NSString *selectedEmotionCode;
@property NSIndexPath *selectedEmotionIndexPath;
@property NSSize cellSize;
@property NSInteger numberOfRow;
@property NSInteger numberOfColumn;

-(void)displayEmotionDialogForView:(NSView *)view;

+(AKEmotionTableController *)sharedInstance;

@end
