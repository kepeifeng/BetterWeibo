//
//  AKImageHelper.h
//  BetterWeibo
//
//  Created by Kent on 14-2-19.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKImageHelper : NSObject

+(NSImage *)getSquareImageFrom:(NSImage *)image;
+(NSImage *)getImageFromData:(NSData *)data;
+(void)putImages:(NSArray *)images inMatrix:(NSMatrix *)imageMatrix target:(id)target action:(SEL)action;

+(void)getThreePartImageFrom:(NSImage *)image leftWidth:(NSUInteger)leftPartWidth rightWidth:(NSUInteger)rightPartWidth leftPart:(NSImage **)leftPart middlePart:(NSImage **)middlePart rightPart:(NSImage **)rightPart;
@end
