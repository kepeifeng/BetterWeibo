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
#import "AKImageHelper.h"

@interface AKRepostedWeiboView()

@property NSTextField *messageTextField;

@end
@implementation AKRepostedWeiboView{
    AKImageViewer *_imageViewer;
    
}


static NSImage *_repostedWeiboViewBackground;
@synthesize repostedStatus = _repostedStatus;
@synthesize messageTextField = _messageTextField;


-(id)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if(self){
        [self _makeMessageTextField];
    }
    return self;
    
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        [self _makeMessageTextField];
    }
    return self;
}

-(void)_makeMessageTextField{

    _messageTextField = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 15, 100, 20)];
    [_messageTextField setDrawsBackground:NO];
    [_messageTextField setBordered:NO];
    [_messageTextField setEditable:NO];
    [self addSubview:_messageTextField];
    
}

-(void)awakeFromNib{

    [self.repostedWeiboContent setDrawsBackground:NO];
    [self.repostedWeiboContent setEditable:NO];
    [self.repostedWeiboContent setSelectable:YES];

}

+(NSImage *)backgroundImage{
    if (!_repostedWeiboViewBackground) {
        _repostedWeiboViewBackground = [NSImage imageNamed:@"repost-background-frame"];
    }
    
    return _repostedWeiboViewBackground;
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
    
    // Drawing code here.
    [self drawBackground:self.bounds];
    [super drawRect:dirtyRect];
    return;
    
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

    [self setRepostedStatusExists:(repostedStatus && repostedStatus.user)];
    if(_repostedStatus.user){
    
        
//        [self.repostedWeiboContent setStringValue:_repostedStatus.text];
        [self.repostedWeiboContent.textStorage setAttributedString:_repostedStatus.attributedText];
        [self.repostedWeiboUserAlias setStringValue:_repostedStatus.user.screen_name];
        [self.repostedWeiboDateDuration setStringValue:_repostedStatus.dateDuration];
        if(_repostedStatus.pic_urls && _repostedStatus.pic_urls.count>0){
            [self.repostedWeiboImageMatrix setHidden:NO];
        }
        else{
            [self.repostedWeiboImageMatrix setHidden:YES];
        }
        
    }else{
        
        [self.messageTextField setStringValue:repostedStatus.text];
    }


}

-(void)setRepostedStatusExists:(BOOL)exist{

    [self.repostedWeiboContent setHidden:!exist];
    [self.repostedWeiboDateDuration setHidden:!exist];
    [self.repostedWeiboImageMatrix setHidden:!exist];
    [self.repostedWeiboUserAlias setHidden:!exist];
    [self.messageTextField setHidden:exist];
}


-(void)loadImages:(NSArray *)images{
    
    [AKImageHelper putImages:images inMatrix:self.repostedWeiboImageMatrix target:self action:@selector(imageCellClicked:)];
}

-(void)loadImages:(NSArray *)images isForRepost:(BOOL)isForRepost{
    
    [self loadImages:images];
}


-(NSSize)intrinsicContentSize{
    
    if(!self.repostedStatus){
        return NSMakeSize(0, 0);
    }
    
    NSSize size = self.frame.size;
    
    if(!_repostedStatus.user){
    
        size.height = REPOST_STATUS_MESSAGE_BLOCK_HEIGH;
        return size;
    }
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

    NSSize statusViewSize = self.frame.size;

    NSInteger repostY = 0;
    repostY += REPOST_STATUS_PADDING_BOTTOM;
    
    if(!_repostedStatus){
        return;
    }
    
    if(!_repostedStatus.user){
        
        NSInteger bottomArrowHeight = 11;
        NSSize messageFieldSize = NSMakeSize(oldSize.width - REPOST_STATUS_PADDING_LEFT -REPOST_STATUS_PADDING_RIGHT,
                                             self.messageTextField.frame.size.height);
        NSPoint messageFieldPoint = NSMakePoint(REPOST_STATUS_PADDING_LEFT,
                                                (oldSize.height - bottomArrowHeight - messageFieldSize.height)/2);
        self.messageTextField.frame = NSMakeRect(messageFieldPoint.x,
                                                 messageFieldPoint.y,
                                                 messageFieldSize.width,
                                                 messageFieldSize.height);
        return;
    }
    
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
        [self.repostedWeiboImageMatrix setFrameOrigin:NSMakePoint(REPOST_STATUS_PADDING_LEFT, repostY)];
        
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

}

-(void)imageCellClicked:(id)sender{
    
    //NSLog(@"imageCellClicked");
    NSMatrix *imageMatrix = sender;
    NSCell *selectedCell = imageMatrix.selectedCell;
    AKWeiboStatus *status = self.repostedStatus;
    NSArray *imageURLArray = (status.pic_urls && status.pic_urls.count>0)?status.pic_urls:status.retweeted_status.pic_urls;
    
    _imageViewer = [AKImageViewer sharedInstance];
    _imageViewer.images = imageURLArray;
    _imageViewer.index = selectedCell.tag;
    [_imageViewer show];
    
    return;

    
}

@end
