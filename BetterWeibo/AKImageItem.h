//
//  AKImageItem.h
//  BetterWeibo
//
//  Created by Kent on 14-2-21.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol AKImageItemDelegate;

@interface AKImageItem : NSView

@property id<AKImageItemDelegate> delegate;
@property (readonly) NSImage *image;
@property NSURL *filePath;
@property (readonly) BOOL isEnabled;
-(void)setEnabled:(BOOL)flag;

@end

@protocol AKImageItemDelegate

-(void)imageItemCloseButtonClicked:(AKImageItem *)imageItem;
-(void)imageClicked:(AKImageItem *)imageItem;
@end
