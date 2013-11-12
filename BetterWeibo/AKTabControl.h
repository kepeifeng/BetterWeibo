//
//  AKTabController.h
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-29.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AKTabButton.h"
#import "AKWeiboViewController.h"
#import "AKTabViewController.h"
#import "AKTabButton.h"
#import "AKUserProfile.h"

//@class AKTabViewController;

//===================== AKTabControl =====================

@interface AKTabControl : NSView <AKTabViewControllerDelegate>{

    NSMutableArray *tabControlMatrixGroup;
    NSMutableArray *userButtonGroup;
    NSMutableArray *userIDList;

    
    

}

@property NSColor *customBackgroundColor;
@property NSMutableArray *tabViewControllers;
@property IBOutlet NSTabView *targetTabView;

-(void)addControlGroup:(AKUserProfile *)userProfile;
-(void)switchToGroupAtIndex:(NSInteger)index;
-(void)setLightIndicatorState:(BOOL)state forButton:(AKTabButtonType)buttonType userID:(NSString *)userID;

//-(void)addViewController:(AKTabViewController *)viewController;

@end
