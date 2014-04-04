//
//  AKImageHelper.m
//  BetterWeibo
//
//  Created by Kent on 14-2-19.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKImageHelper.h"
#import "AKViewConstant.h"
#import "AKImageButtonCell.h"

@implementation AKImageHelper

+(NSImage *)getSquareImageFrom:(NSImage *)image{

    NSSize originImageSize = image.size;
    if(originImageSize.width == originImageSize.height){
        return image;
    }
    NSInteger squareBorderLength = MIN(image.size.width, image.size.height);
//    NSSize sqareImageSize = NSMakeSize(squareBorderLength, squareBorderLength);
    
    NSRect drawingRect = NSMakeRect((originImageSize.width - squareBorderLength)/2,
                                    (originImageSize.height - squareBorderLength)/2,
                                    squareBorderLength,
                                    squareBorderLength);
    
    NSImage *squareImage = [[NSImage alloc] initWithSize:drawingRect.size];
    
    [squareImage lockFocus];
    [image drawInRect:NSMakeRect(0, 0, squareBorderLength, squareBorderLength) fromRect:drawingRect operation:NSCompositeSourceOver fraction:1];
    [squareImage unlockFocus];
    
    return squareImage;

    
}

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
    
//    NSLog(@"Width from NSBitmapImageRep: %f",(CGFloat)width);
//    NSLog(@"Height from NSBitmapImageRep: %f",(CGFloat)height);
    [image setSize:NSMakeSize(width, height)];
    
    return image;
}

+(void)putImages:(NSArray *)images inMatrix:(NSMatrix *)imageMatrix target:(id)target action:(SEL)action{

    
    if(images && images.count >0){
        
        //        [imageMatrix ]
        
        NSInteger i = 0;
        //第一行 第一列
        //[imageMatrix addRow];
        
        for(NSInteger rowIndex = 0; rowIndex<imageMatrix.numberOfRows; rowIndex++ ){
            
            for(NSInteger columnIndex = 0; columnIndex<imageMatrix.numberOfColumns; columnIndex++){
        
                NSInteger cellIndex = rowIndex*imageMatrix.numberOfColumns+columnIndex;
                NSButtonCell *imageCell = [imageMatrix cellAtRow:rowIndex column:columnIndex];
                
                if([imageCell isKindOfClass:[AKImageButtonCell class]]){
                    //如果cellIndex没有超出images数组的范围
                    if(cellIndex<images.count){
                        //设置图片
                        [imageCell setEnabled:YES];
                        imageCell.tag = cellIndex;
                        [(AKImageButtonCell *)imageCell setImageEntry:(AKStatusImageEntry *)[images objectAtIndex:cellIndex]];
//                        imageCell.image = (NSImage *)[images objectAtIndex:cellIndex];
                    }else{
                        [imageCell setEnabled:NO];
                        imageCell.image = nil;
                    }

                    
                }else{
                    //如果cellIndex没有超出images数组的范围
                    if(cellIndex<images.count){
                        //设置图片
                        [imageCell setEnabled:YES];
                        imageCell.tag = cellIndex;
                        imageCell.image = (NSImage *)[images objectAtIndex:cellIndex];
                    }else{
                        [imageCell setEnabled:NO];
                        imageCell.image = nil;
                    }
                }

                
            }
            
        }
        
        [imageMatrix setNeedsDisplay:YES];
        
        
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

+(void)getThreePartImageFrom:(NSImage *)image leftWidth:(NSUInteger)leftPartWidth rightWidth:(NSUInteger)rightPartWidth leftPart:(NSImage **)leftPart middlePart:(NSImage **)middlePart rightPart:(NSImage **)rightPart{
    
    NSImage *_leftPartImage;
    NSImage *_middlePartImage;
    NSImage *_rightPartImage;
    
    
    _leftPartImage = [[NSImage alloc]initWithSize:NSMakeSize(leftPartWidth, image.size.height)];
    _middlePartImage = [[NSImage alloc]initWithSize:NSMakeSize(image.size.width - leftPartWidth - rightPartWidth, image.size.height)];
    _rightPartImage = [[NSImage alloc]initWithSize:NSMakeSize(rightPartWidth, image.size.height)];
    
    //For Normal Status Button
    [_leftPartImage lockFocus];
    [image drawInRect:NSMakeRect(0, 0, _leftPartImage.size.width, _leftPartImage.size.height)
             fromRect:NSMakeRect(0, 0, _leftPartImage.size.width, _leftPartImage.size.height)
            operation:NSCompositeSourceOver
             fraction:1];
    [_leftPartImage unlockFocus];
    
    [_middlePartImage lockFocus];
    [image drawInRect:NSMakeRect(0, 0, _middlePartImage.size.width, _middlePartImage.size.height)
             fromRect:NSMakeRect(_leftPartImage.size.width, 0, _middlePartImage.size.width, _middlePartImage.size.height)
            operation:NSCompositeSourceOver
             fraction:1];
    [_middlePartImage unlockFocus];
    
    [_rightPartImage lockFocus];
    [image drawInRect:NSMakeRect(0, 0, _rightPartImage.size.width, _rightPartImage.size.height)
             fromRect:NSMakeRect(image.size.width - _rightPartImage.size.width, 0, _rightPartImage.size.width, _rightPartImage.size.height)
            operation:NSCompositeSourceOver
             fraction:1];
    [_rightPartImage unlockFocus];
    
    *leftPart = _leftPartImage;
    *middlePart = _middlePartImage;
    *rightPart = _rightPartImage;
    
    
}


@end
