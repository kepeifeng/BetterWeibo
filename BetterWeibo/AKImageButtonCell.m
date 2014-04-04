//
//  AKImageButtonCell.m
//  Wukong
//
//  Created by Kent on 14-4-1.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKImageButtonCell.h"

@implementation AKImageButtonCell{
    NSMutableArray *_observedObjects;
}

@synthesize imageEntry = _imageEntry;

-(void)dealloc{
    for (AKStatusImageEntry *imageEntry in _observedObjects) {
        [imageEntry removeObserver:self forKeyPath:AKStatusImageEntryPropertyNamedThumbnailImage];
    }
}

-(AKStatusImageEntry *)imageEntry{
    return _imageEntry;
}

-(void)setImageEntry:(AKStatusImageEntry *)imageEntry{
    
    _imageEntry = imageEntry;
    if(!_imageEntry){
        self.image = nil;
        return;
    }
    
    if (!_observedObjects) {
        _observedObjects = [NSMutableArray new];
    }
    
    if(![_observedObjects containsObject:imageEntry]){
        
        [imageEntry addObserver:self forKeyPath:AKStatusImageEntryPropertyNamedThumbnailImage options:0 context:NULL];
        [_observedObjects addObject:imageEntry];
    }
    
    if(!imageEntry.thumbnailImage){
        self.image = [NSImage imageNamed:@"image-loading"];
        [imageEntry loadThumbnailImage];

    }
    else{
        self.image = imageEntry.thumbnailImage;
    }
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if([keyPath isEqualToString:AKStatusImageEntryPropertyNamedThumbnailImage] && self.imageEntry==object){
        [self performSelectorOnMainThread:@selector(_reloadImage:) withObject:object waitUntilDone:NO modes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
        
    }
}

-(void)_reloadImage:(id)object{
    AKStatusImageEntry *imageEntry = object;
    if(imageEntry.thumbnailImage){
        self.image = imageEntry.thumbnailImage;
    }
    
    [self.controlView setNeedsDisplay:YES];

}




@end
