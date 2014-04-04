//
//  AKMenuItemRemindView.h
//  Wukong
//
//  Created by Kent on 14-4-1.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AKMenuItemRemindView : NSView

@property NSString *title;
@property NSInteger count;
@property NSImage *image;
@property NSImage *alternateImage;
@property BOOL isHighlight;

@end
