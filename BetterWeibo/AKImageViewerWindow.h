//
//  AKImageViewerWindow.h
//  BetterWeibo
//
//  Created by Kent on 14-3-8.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol AKImageViewerWindowDelegate;

@interface AKImageViewerWindow : NSView

@property IBOutlet id<AKImageViewerWindowDelegate> delegate;

@end

@protocol AKImageViewerWindowDelegate

-(void)windowReceivedKeyDown:(AKImageViewerWindow *)window keyDown:(NSEvent *)keyDown;

@end
