//
//  AKStatusImageEntry.m
//  Wukong
//
//  Created by Kent on 14-4-1.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKStatusImageEntry.h"
#import "AKImageHelper.h"

NSString *const AKStatusImageEntryPropertyNamedThumbnailImage = @"thumbnailImage";

static NSOperationQueue *ATSharedOperationQueue() {
    static NSOperationQueue *_ATSharedOperationQueue = nil;
    if (_ATSharedOperationQueue == nil) {
        _ATSharedOperationQueue = [[NSOperationQueue alloc] init];
        // We limit the concurrency to see things easier for demo purposes. The default value NSOperationQueueDefaultMaxConcurrentOperationCount will yield better results, as it will create more threads, as appropriate for your processor
        [_ATSharedOperationQueue setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
    }
    return _ATSharedOperationQueue;
}


@implementation AKStatusImageEntry

@synthesize thumbnailImage = _thumbnailImage;

-(NSImage *)thumbnailImage{
    if (_thumbnailImage) {
        // Generate the thumbnail right now, synchronously
        return _thumbnailImage;
    } else if (_thumbnailImage == nil && !self.isLoadingThumbnailImage) {
        // Load the image lazily
        [self loadThumbnailImage];
    }

    
    return _thumbnailImage;
}

-(void)setThumbnailImage:(NSImage *)thumbnailImage{
    _thumbnailImage = thumbnailImage;
}

-(void)loadThumbnailImage{
    
    if(!self.thumbnailURL){
        return;
    }
    @synchronized (self) {
        if (_thumbnailImage == nil && !self.isLoadingThumbnailImage) {
            @synchronized (self) {
                self.isLoadingThumbnailImage = YES;
            }
            // We would have to keep track of the block with an NSBlockOperation, if we wanted to later support cancelling operations that have scrolled offscreen and are no longer needed. That will be left as an exercise to the user.
            [ATSharedOperationQueue() addOperationWithBlock:^(void) {
                
                
                    NSImage *image = [AKImageHelper getImageFromData:[NSData dataWithContentsOfURL:self.squareThumbnailURL]];
                
                    if(image){
                        image = [AKImageHelper getSquareImageFrom:image];
                    }else{
                        image = [NSImage imageNamed:@"image-broken"];
                    }

                
                @synchronized (self) {
                    self.isLoadingThumbnailImage = NO;
                    self.thumbnailImage = image;
                    
                    
                }
                
                
            }];
        }
    }



}

+(instancetype)getImageEntryFromURLString:(NSString *)urlString{
    AKStatusImageEntry *newEntry = [AKStatusImageEntry new];
    newEntry.thumbnailURL = [NSURL URLWithString:urlString];
    newEntry.squareThumbnailURL = [NSURL URLWithString:[urlString stringByReplacingOccurrencesOfString:@"/thumbnail/" withString:@"/square/"]];
    newEntry.middleImageURL = [NSURL URLWithString:[urlString stringByReplacingOccurrencesOfString:@"/thumbnail/" withString:@"/bmiddle/"]];
    newEntry.originImageURL = [NSURL URLWithString:[urlString stringByReplacingOccurrencesOfString:@"/thumbnail/" withString:@"/large/"]];
    
    return newEntry;
}

@end
