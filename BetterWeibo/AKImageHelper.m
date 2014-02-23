//
//  AKImageHelper.m
//  BetterWeibo
//
//  Created by Kent on 14-2-19.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKImageHelper.h"
#import "AKViewConstant.h"

@implementation AKImageHelper

+(NSImage *)getImageFromData:(NSData *)data{

    NSImage *image = [[NSImage alloc]initWithData:data];
    
    //确保图片按照其实际像素尺寸现实（而不受图片的分辨率影响）
    NSArray * imageReps = [image representations];
    
    NSInteger width = 0;
    NSInteger height = 0;
    
    for (NSImageRep * imageRep in imageReps) {
        if ([imageRep pixelsWide] > width) width = [imageRep pixelsWide];
        if ([imageRep pixelsHigh] > height) height = [imageRep pixelsHigh];
    }
    
    NSLog(@"Width from NSBitmapImageRep: %f",(CGFloat)width);
    NSLog(@"Height from NSBitmapImageRep: %f",(CGFloat)height);
    [image setSize:NSMakeSize(width, height)];
    
    return image;
}

+(void)putImages:(NSArray *)images inMatrix:(NSMatrix *)imageMatrix target:(id)target action:(SEL)action{

    
    if(images && images.count >0){
        
        //        [imageMatrix ]
        
        NSInteger i = 0;
        //第一行 第一列
        //[imageMatrix addRow];
        for(NSImage *image in images){
            
            
            
            NSButtonCell *imageCell = [imageMatrix cellAtRow:(NSInteger)(i/3) column:(i%3)];
            imageCell.tag = i;
            imageCell.image = image;
            
            i++;
            
        }
        
        assert(i<=9);
        
        if(images.count == 1){
            
            imageMatrix.cellSize = NSMakeSize(LARGE_THUMBNAIL_SIZE, LARGE_THUMBNAIL_SIZE);
        }else{
            
            imageMatrix.cellSize = NSMakeSize(SMALL_THUMBNAIL_SIZE, SMALL_THUMBNAIL_SIZE);
        }
        
        [imageMatrix setTarget:target];
        [imageMatrix setAction:action];
        [imageMatrix setHidden:NO];
        
    }
    
    else{
        
        [imageMatrix setHidden:YES];
    }
    

}

@end
