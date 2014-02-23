//
//  AKImageSelector.m
//  BetterWeibo
//
//  Created by Kent on 14-2-21.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKImageSelector.h"


@implementation AKImageSelector{

    NSButton * _addImageButton;
    NSMutableArray *_images;
    NSMutableArray *_imageItems;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        
        _images = [NSMutableArray new];
        _imageItems = [NSMutableArray new];
        _addImageButton = [[NSButton alloc]init];
        _addImageButton.image = [NSImage imageNamed:@"add-button"];
        _addImageButton.frame = NSMakeRect(0,
                                           0,
                                           _addImageButton.image.size.width,
                                           _addImageButton.image.size.height);

        _addImageButton.bezelStyle = NSRecessedBezelStyle;
        [_addImageButton setButtonType:NSMomentaryChangeButton];
        [_addImageButton setBordered:NO];
        _addImageButton.focusRingType = NSFocusRingTypeNone;
        
        _addImageButton.target = self;
        _addImageButton.action = @selector(addImageButtonClicked:);
        
        [self addSubview:_addImageButton];
        
    }
    return self;
}

-(void)viewWillDraw{
    //NSLog(@"AKImageSelector will Draw");
}

-(void)resizeSubviewsWithOldSize:(NSSize)oldSize{
    
    [super resizeSubviewsWithOldSize:oldSize];
    
    NSInteger index = 0;
//    NSPoint basicPoint = NSMakePoint((NSInteger)((self.frame.size.width - self.cellSize.width * self.numberOfColumns)/2),
//                                     (NSInteger)((self.frame.size.height - self.cellSize.height * self.numberOfRows)/2));
    NSPoint basicPoint = NSZeroPoint;
    for (NSInteger rowIndex = 0; rowIndex<self.numberOfRows; rowIndex++) {
        
        BOOL shouldBreak = NO;
        
        for (NSInteger columnIndex = 0; columnIndex < self.numberOfColumns; columnIndex++) {
            
            NSPoint imageItemOrigin = NSMakePoint(columnIndex * self.cellSize.width + basicPoint.x, rowIndex * self.cellSize.height + basicPoint.y);
            if(index<self.count){
            
                AKImageItem *imageItem = [_imageItems objectAtIndex:index];
                [imageItem setFrameOrigin:imageItemOrigin];
                
                
                index++;
            }
            else{
                
                NSPoint addImageButtonOrigin = NSMakePoint(imageItemOrigin.x + (self.cellSize.width - _addImageButton.frame.size.width)/2,
                                                           imageItemOrigin.y + (self.cellSize.height - _addImageButton.frame.size.height)/2);
                
                [_addImageButton setFrameOrigin:addImageButtonOrigin];
                
                shouldBreak = YES;
                break;
            
            }
        }

        
        if(shouldBreak){
            break;
        }
    }
    
    if(index>=self.numberOfColumns * self.numberOfRows){
        
        [_addImageButton setHidden:YES];
    }
    else{
        [_addImageButton setHidden: NO];
    }
    

}

-(BOOL)isFlipped{
    return YES;
}

- (void)drawRect:(NSRect)dirtyRect
{

    
    NSColor *startColor = [NSColor colorWithCalibratedRed:57/255.0 green:62/255.0 blue:66/255.0 alpha:1];
    NSColor *endColor = [NSColor colorWithCalibratedRed:99/255.0 green:108/255.0 blue:115/255.0 alpha:1];
	
    NSGradient *gradient = [[NSGradient alloc]initWithStartingColor:startColor endingColor:endColor];
    
    [gradient drawInRect:self.bounds angle:90];
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(void)addImageButtonClicked:(id)sender{

    if(self.delegate){
        [self.delegate imageSelector:self addButtonClicked:_addImageButton];
    }

}

-(NSInteger)count{
    return _images.count;
}

-(NSArray *)images{
    return _images;
}

- (void)addImage:(NSImage *)image{
    
    if ([_images containsObject:image]) {
        
        return;
    }
    
    if (_images.count == self.numberOfRows * self.numberOfColumns) {
        
        
        
        return;
    }
    
    
    
    [_images addObject:image];
    AKImageItem *imageItem = [[AKImageItem alloc] initWithFrame:NSMakeRect(0, 0, self.cellSize.width, self.cellSize.height)];
    imageItem.image = image;
    imageItem.delegate = self;
    [_imageItems addObject:imageItem];
    
    [self addSubview:imageItem];
    
    [self resizeSubviewsWithOldSize:self.bounds.size];
    
    if(self.delegate) {
    
        [self.delegate imageSelector:self numberOfImagesChanged:self.count];
        
    }


}


-(void)removeImage:(NSImage *)image{
    
    NSInteger index = [_images indexOfObject:image];
    [self removeImageAtIndex:index];

}

-(void)removeImageAtIndex:(NSInteger)index{
    
    [_images removeObjectAtIndex:index];
    AKImageItem *imageItem = [_imageItems objectAtIndex:index];
    [imageItem removeFromSuperview];
    [_imageItems removeObjectAtIndex:index];
    [self resizeSubviewsWithOldSize:self.frame.size];
    
    if(self.delegate){
        [self.delegate imageSelector:self numberOfImagesChanged:self.count];
    }

}



#pragma mark - Image Item
-(void)imageItemCloseButtonClicked:(AKImageItem *)imageItem{
    [self removeImage:imageItem.image];
    

}

-(void)imageClicked:(AKImageItem *)imageItem{

}

@end
