//
//  AKImageSelector.h
//  BetterWeibo
//
//  Created by Kent on 14-2-21.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AKImageItem.h"

@protocol AKImageSelectorDelegate;

@interface AKImageSelector : NSView<AKImageItemDelegate>

@property id<AKImageSelectorDelegate> delegate;
@property NSInteger numberOfColumns;
@property NSInteger numberOfRows;
@property NSSize cellSize;

@property (nonatomic, readonly) NSArray * imageItems;
@property (readonly) NSInteger count;
@property (readonly) BOOL isEnabled;

-(NSArray *)allFileURLs;
-(void)addImageItemFromFileURL:(NSURL *)url;
-(void)addImageItem:(AKImageItem *)imageItem;
-(void)removeImageItem:(AKImageItem *)imageItem;
-(void)removeImageItemAtIndex:(NSInteger)index;
-(void)removeAllImages;

-(void)setEnabled:(BOOL)flag;


@end

@protocol AKImageSelectorDelegate

-(void)imageSelector:(AKImageSelector *)imageSelector numberOfImagesChanged:(NSInteger)numberOfImage;

-(void)imageSelector:(AKImageSelector *)imageSelector addButtonClicked:(NSButton *)addButton;

-(void)imageSelector:(AKImageSelector *)imageSelector imageItemClicked:(AKImageItem *)imageItem;

@end