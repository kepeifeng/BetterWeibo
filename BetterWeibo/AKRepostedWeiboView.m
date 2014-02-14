//
//  AKRepostedWeiboView.m
//  BetterWeibo
//
//  Created by Kent on 13-10-8.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKRepostedWeiboView.h"
#import "AKUserProfile.h"
#import "AKViewConstant.h"
#import "AKImageViewer.h"

@implementation AKRepostedWeiboView{
    AKImageViewer *_imageViewer;
    
}


static NSImage *_repostedWeiboViewBackground;
@synthesize repostedStatus = _repostedStatus;


- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

+(NSImage *)backgroundImage{
    if (!_repostedWeiboViewBackground) {
        _repostedWeiboViewBackground = [NSImage imageNamed:@"repost-background-frame"];
    }
    
    return _repostedWeiboViewBackground;
}

- (void) setFrameSize:(NSSize)newSize

{
    
    [super setFrameSize:newSize];
    
    
    
    // A change in size has required the view to be invalidated.
    
    if ([self inLiveResize])
        
    {
        
        NSRect rects[4];
        
        NSInteger count;
        
        [self getRectsExposedDuringLiveResize:rects count:&count];
        
        while (count-- > 0)
            
        {
            
            [self setNeedsDisplayInRect:rects[count]];
            
        }
        
    }
    
    else
        
    {
        
        [self setNeedsDisplay:YES];
        
    }
    
}

-(void)setNeedsDisplay:(BOOL)flag{

    [super setNeedsDisplay:flag];
    //[self drawBackground];
    
    
}

-(void)setNeedsDisplayInRect:(NSRect)invalidRect{

    [super setNeedsDisplayInRect:invalidRect];
}



-(void)drawBackground:(NSRect)rect{

    NSImage *repostedWeiboViewBackground = [AKRepostedWeiboView backgroundImage];
    
    NSRect repostedWeiboDrawingRect = rect;
    
    //Top
    [repostedWeiboViewBackground drawInRect:NSMakeRect(0, repostedWeiboDrawingRect.origin.y + repostedWeiboDrawingRect.size.height - 8, repostedWeiboDrawingRect.size.width, 8) fromRect:NSMakeRect(0, 49, 81, 8) operation:NSCompositeSourceOver fraction:1];
    //Middle Part
    [repostedWeiboViewBackground drawInRect:NSMakeRect(0, repostedWeiboDrawingRect.origin.y + 14, repostedWeiboDrawingRect.size.width, repostedWeiboDrawingRect.size.height - 8 - 14) fromRect:NSMakeRect(0, 14, 81, 34) operation:NSCompositeSourceOver fraction:1];
    //Bottom Part - Arrow
    [repostedWeiboViewBackground drawInRect:NSMakeRect(0, repostedWeiboDrawingRect.origin.y, 50, 14) fromRect:NSMakeRect(0, 0, 50, 14) operation:NSCompositeSourceOver fraction:1];
    //Bottom Right Part
    [repostedWeiboViewBackground drawInRect:NSMakeRect(50, repostedWeiboDrawingRect.origin.y, repostedWeiboDrawingRect.size.width - 50, 14) fromRect:NSMakeRect(50, 0, 31, 14) operation:NSCompositeSourceOver fraction:1];
    


}

- (void)drawRect:(NSRect)dirtyRect
{
	//
	
    // Drawing code here.
    
    
    //NSLog(@"(%f, %f, %f, %f", repostedWeiboDrawingRect.origin.x, repostedWeiboDrawingRect.origin.y
    //      , repostedWeiboDrawingRect.size.width, repostedWeiboDrawingRect.size.height);
    
    //Top
    
    //[self resize];
    
    //    if(self.status && self.status.retweeted_status){

    if([self inLiveResize]){
    
//        NSImage *repostedWeiboViewBackground = [NSImage imageNamed:@"repost-background-frame"];
        [self drawBackground:dirtyRect];
        
    }
    else{
    
        if([self needsDisplay]){
        
            [self drawBackground:self.bounds];
        }
    
    }
    //[super drawRect:dirtyRect];
    
    
}


-(AKWeiboStatus *)repostedStatus{

    return _repostedStatus;
}


-(void)setRepostedStatus:(AKWeiboStatus *)repostedStatus{

    _repostedStatus = repostedStatus;

    [self.repostedWeiboContent setStringValue:_repostedStatus.text];
    [self.repostedWeiboUserAlias setStringValue:_repostedStatus.user.screen_name];
    
    if(_repostedStatus.pic_urls && _repostedStatus.pic_urls.count>0){
        
        [self loadImages:_repostedStatus.pic_urls isForRepost:YES];
        
    }

}



-(void)loadImages:(NSArray *)imageURL isForRepost:(BOOL)isForRepost{
    
    NSMatrix *imageMatrix = self.repostedWeiboImageMatrix;
    
    
    if(imageURL && imageURL.count >0){
        
        //        [imageMatrix ]
        
        NSInteger i = 0;
        //第一行 第一列
        //[imageMatrix addRow];
        for(NSDictionary *url in imageURL){
            
            NSImage *image = [[NSImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[url objectForKey:@"thumbnail_pic"]]]];
            
            
            NSButtonCell *imageCell = [imageMatrix cellAtRow:(NSInteger)(i/3) column:(i%3)];
            imageCell.tag = i;
            imageCell.image = image;
            i++;
            
        }
        
        assert(i<=9);
        
        if(imageURL.count == 1){
            
            imageMatrix.cellSize = NSMakeSize(LARGE_THUMBNAIL_SIZE, LARGE_THUMBNAIL_SIZE);
        }else{
            
            imageMatrix.cellSize = NSMakeSize(SMALL_THUMBNAIL_SIZE, SMALL_THUMBNAIL_SIZE);
        }
        
        [imageMatrix setTarget:self];
        [imageMatrix setAction:@selector(imageCellClicked:)];
        [imageMatrix setHidden:NO];
        
    }
    
    else{
        
        [imageMatrix setHidden:YES];
    }
}


-(NSSize)intrinsicContentSize{
    
    if(!self.repostedStatus){
        return NSMakeSize(0, 0);
    }
    
    NSSize size = self.frame.size;
    
    size.height = REPOST_STATUS_PADDING_TOP + self.repostedWeiboUserAlias.frame.size.height + STATUS_TEXT_MARGIN_TOP + self.repostedWeiboContent.intrinsicContentSize.height + REPOST_STATUS_PADDING_BOTTOM;
    
    if(_repostedStatus.pic_urls && _repostedStatus.pic_urls.count>0){
        
        size.height += IMAGE_MARGIN_TOP;
        
        if(_repostedStatus.pic_urls.count ==1){
            
            size.height += LARGE_THUMBNAIL_SIZE;
            
        }
        else{
            
            size.height += ((NSInteger)((_repostedStatus.pic_urls.count+2)/3)) * (SMALL_THUMBNAIL_SIZE+SMALL_THUMBNAIL_SPACING)-SMALL_THUMBNAIL_SPACING;
            
        }
        
        
        
    }
    
    return size;

    
}


-(void)resizeSubviewsWithOldSize:(NSSize)oldSize{

    
//    NSSize repostedWeiboViewSize = statusViewSize;
//    repostedWeiboViewSize.height = 1000;
    NSSize statusViewSize = self.frame.size;

    
//    [self.repostedWeiboView setFrameOrigin:NSMakePoint(0, y)];
    
    NSInteger repostY = 0;
    repostY += REPOST_STATUS_PADDING_BOTTOM;
    
    //Images
    if(_repostedStatus.pic_urls && _repostedStatus.pic_urls.count>0)
    {
        NSSize weiboImageMatrixSize;
        if(_repostedStatus.pic_urls.count ==1){
            
            weiboImageMatrixSize = NSMakeSize(LARGE_THUMBNAIL_SIZE, LARGE_THUMBNAIL_SIZE);
            
        }
        else{
            
            weiboImageMatrixSize = NSMakeSize(self.repostedWeiboImageMatrix.numberOfColumns * (SMALL_THUMBNAIL_SIZE+SMALL_THUMBNAIL_SPACING)-SMALL_THUMBNAIL_SPACING,
                                              ((NSInteger)((_repostedStatus.pic_urls.count+2)/3)) * (SMALL_THUMBNAIL_SIZE+SMALL_THUMBNAIL_SPACING)-SMALL_THUMBNAIL_SPACING);
            
        }
        
        
        [self.repostedWeiboImageMatrix setFrameSize:weiboImageMatrixSize];
        [self.repostedWeiboImageMatrix setFrameOrigin:NSMakePoint(60, repostY)];
        
        repostY+=self.repostedWeiboImageMatrix.frame.size.height+IMAGE_MARGIN_TOP;
        
        
    }
    
    //Text
    [self.repostedWeiboContent setFrameSize:NSMakeSize(statusViewSize.width - REPOST_STATUS_PADDING_LEFT - REPOST_STATUS_PADDING_RIGHT, 1000)];
    [self.repostedWeiboContent setFrameSize:self.repostedWeiboContent.intrinsicContentSize];
    
    [self.repostedWeiboContent setFrameOrigin:NSMakePoint(REPOST_STATUS_PADDING_LEFT, repostY)];
    
    repostY+=self.repostedWeiboContent.frame.size.height + STATUS_TEXT_MARGIN_TOP;
    
    //User Alias
    [self.repostedWeiboUserAlias setFrameOrigin:NSMakePoint(self.repostedWeiboContent.frame.origin.x, repostY)];
    
    //Date Duration
    [self.repostedWeiboDateDuration setFrameOrigin:NSMakePoint(statusViewSize.width-self.repostedWeiboDateDuration.frame.size.width - STATUS_MARGIN_RIGHT, repostY)];
    
    repostY += self.repostedWeiboUserAlias.frame.size.height;
    
    repostY += REPOST_STATUS_PADDING_TOP;
    
    NSSize repostedWeiboViewSize = self.frame.size;
    repostedWeiboViewSize.height = repostY;
    
    //[self setFrameSize:repostedWeiboViewSize];
    
//    [super resizeSubviewsWithOldSize:oldSize];
    
    //User Avatar
    //[self.userImage setFrameOrigin:NSMakePoint(USER_AVATAR_MARGIN_LEFT, y-self.userImage.frame.size.height)];


}

-(void)imageCellClicked:(id)sender{
    
    //NSLog(@"imageCellClicked");
    NSMatrix *imageMatrix = sender;
    NSCell *selectedCell = imageMatrix.selectedCell;
    AKWeiboStatus *status = self.repostedStatus;
    NSArray *imageURLArray = (status.pic_urls && status.pic_urls.count>0)?status.pic_urls:status.retweeted_status.pic_urls;
    
    
    if(!_imageViewer){
        _imageViewer = [[AKImageViewer alloc] initWithArray:imageURLArray startAtIndex:selectedCell.tag];
    }
    else{
        _imageViewer.images = imageURLArray;
        _imageViewer.index = selectedCell.tag;
    }
    
    [_imageViewer show];
    
}

@end
