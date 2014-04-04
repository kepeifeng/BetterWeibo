//
//  AKStatusImageEntry.h
//  Wukong
//
//  Created by Kent on 14-4-1.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const AKStatusImageEntryPropertyNamedThumbnailImage;

@interface AKStatusImageEntry : NSObject

@property NSURL *thumbnailURL;
@property NSImage *thumbnailImage;
@property BOOL isLoadingThumbnailImage;
-(void)loadThumbnailImage;

@property NSURL *squareThumbnailURL;
@property NSImage *squareThumbnailImage;

@property NSURL *middleImageURL;
@property NSImage *middleImage;

@property NSURL *originImageURL;
@property NSImage *originImage;

+(instancetype)getImageEntryFromURLString:(NSString *)urlString;

@end
