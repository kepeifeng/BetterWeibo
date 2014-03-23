//
//  AKStatusTextView.h
//  controlLabs
//
//  Created by Kent on 14-1-12.
//  Copyright (c) 2014年 Kent. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AKTextView.h"


@protocol AKStatusTextViewDelegate <NSTextViewDelegate>

-(void)atKeyPressed:(id)textView position:(NSRect)atPosition;

@end

@interface AKStatusTextView : NSTextView

@property (nonatomic, assign) id<AKStatusTextViewDelegate> delegate;

@end
