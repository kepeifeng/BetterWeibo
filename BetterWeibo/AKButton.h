//
//  AKButton.h
//  controlLabs
//
//  Created by Kent on 14-2-25.
//  Copyright (c) 2014年 Kent. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AKButtonCell.h"

@interface AKButton : NSButton

@property (nonatomic) AKButtonStyle buttonStyle;

-(void)setEnabled:(BOOL)flag;

@end
