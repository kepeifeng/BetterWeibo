//
//  AKImageItem.m
//  BetterWeibo
//
//  Created by Kent on 14-2-21.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKImageItem.h"

#define IMAGE_ITEM_PADDING_SIZE 8;
#define SHADOW_DISTANCE 4;
#define OUTER_STROKE_WIDTH 5;

@implementation AKImageItem
{
    NSImageView *_imageView;
    NSButton *_closeButton;
    NSImage *_thumbnailImage;
    NSTrackingArea *_trackingArea;

}

@synthesize image = _image;
@synthesize isEnabled = _isEnabled;
@synthesize filePath = _filePath;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        
        //Setup Image View for thumbnail image.
        _imageView = [[NSImageView alloc] init];
        _imageView.imageScaling = NSImageScaleNone;
        _imageView.imageFrameStyle = NSImageFrameNone;
        
        [self addSubview:_imageView];

        //Setup Close Button.
        _closeButton = [[NSButton alloc]init];
        _closeButton.image = [NSImage imageNamed:@"close-button"];
        [_closeButton setFrameSize:_closeButton.image.size];
        _closeButton.bezelStyle = NSRecessedBezelStyle;
        [_closeButton setButtonType:NSMomentaryChangeButton];
        [_closeButton setBordered:NO];
        _closeButton.focusRingType = NSFocusRingTypeNone;
        [_closeButton setHidden:YES];
        
        _closeButton.target = self;
        _closeButton.action = @selector(closeButtonClicked:);
        
        [self addSubview:_closeButton];
        
        
        
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}


-(void)updateTrackingAreas{

    if(_trackingArea){
        [self removeTrackingArea:_trackingArea];
    }
        
    NSTrackingAreaOptions trackingOptions = NSTrackingMouseEnteredAndExited | NSTrackingActiveInActiveApp | NSTrackingEnabledDuringMouseDrag;
    
    _trackingArea = [[NSTrackingArea alloc] initWithRect:self.bounds options:trackingOptions owner:self userInfo:nil];

    
    [self addTrackingArea:_trackingArea];

}

-(BOOL)isEnabled{
    return _isEnabled;
}

-(void)setEnabled:(BOOL)flag{

    _isEnabled = flag;
    if (!_isEnabled) {
        [_closeButton setHidden:YES];
    }
    [_closeButton setEnabled:_isEnabled];
    
    
}

-(void)mouseEntered:(NSEvent *)theEvent{

    if(!self.isEnabled){
        return;
    }
    
    [_closeButton setHidden:NO];
    
}

-(void)mouseExited:(NSEvent *)theEvent{
    
    
    if(!self.isEnabled){
        return;
    }
    
    [_closeButton setHidden:YES];
}

-(NSURL *)filePath{
    return _filePath;
}

-(void)setFilePath:(NSURL *)filePath{
    _filePath = filePath;
    self.image = [[NSImage alloc] initWithContentsOfURL:filePath];
}

-(NSImage *)image{

    return  _image;

}


-(void)setImage:(NSImage *)image{
    
    if(_image == image){
        return;
    }
    
    _image = image;
    _thumbnailImage = [[self class] getThumbnailImage:_image withinSize:self.frame.size];
    _imageView.image = _thumbnailImage;
    [self resizeSubviewsWithOldSize:self.frame.size];
    
    
}

-(void)resizeSubviewsWithOldSize:(NSSize)oldSize{

    [super resizeSubviewsWithOldSize:oldSize];
    
    NSInteger shadowDistance = SHADOW_DISTANCE;
    NSInteger outerStrokeWidth = OUTER_STROKE_WIDTH;
    
    NSInteger x = (self.frame.size.width + shadowDistance - _thumbnailImage.size.width)/2;
    NSInteger y = (self.frame.size.height + shadowDistance - _thumbnailImage.size.height)/2;
    NSRect imageViewFrame = NSMakeRect(x, y, _thumbnailImage.size.width, _thumbnailImage.size.height );
    _imageView.frame = imageViewFrame;
    
    [_closeButton setFrameOrigin:NSMakePoint(_imageView.frame.origin.x + _imageView.frame.size.width - shadowDistance - outerStrokeWidth - _closeButton.frame.size.width / 2 ,
                                             _imageView.frame.origin.y + _imageView.frame.size.height - shadowDistance - outerStrokeWidth - _closeButton.frame.size.height / 2)];
    
    
    

}

-(void)closeButtonClicked:(id)sender{

    if(self.delegate){
        [self.delegate imageItemCloseButtonClicked:self];
    }

}

+(NSImage *)getThumbnailImage:(NSImage *)image withinSize:(NSSize)size{
    
    NSInteger outerStrokeWidth = OUTER_STROKE_WIDTH;
    NSInteger innerPadding = IMAGE_ITEM_PADDING_SIZE;
    NSInteger shadowDistance = SHADOW_DISTANCE;
    
    //计算出图片部分的Frame，用于计算缩略图图片部分的大小
    NSSize thumbnailImageSizeFrame = NSMakeSize(size.width - innerPadding * 2 -  outerStrokeWidth * 2 - shadowDistance,
                                                size.height - innerPadding * 2 - outerStrokeWidth * 2 - shadowDistance);
    
    NSSize imageSize = [image size];
    CGFloat imageAspectRatio = imageSize.width / imageSize.height;
    
    NSSize thumbnailImageSize = NSZeroSize;
    
    //计算图片部分的尺寸
    if(imageSize.width>=imageSize.height){
        
        thumbnailImageSize.width = thumbnailImageSizeFrame.width;
        thumbnailImageSize.height = (NSInteger)(thumbnailImageSize.width /imageAspectRatio);
        
    }else{
        
        thumbnailImageSize.height = thumbnailImageSizeFrame.height;
        thumbnailImageSize.width = (NSInteger)(thumbnailImageSize.height * imageAspectRatio);
    }
    
    //图片部分的位置和尺寸
    NSRect thumbnailImageRect = NSMakeRect(shadowDistance + outerStrokeWidth,
                                           shadowDistance + outerStrokeWidth,
                                           thumbnailImageSize.width,
                                           thumbnailImageSize.height);
    
    //描边部分的位置和尺寸
    NSRect thumbnailStrokeRect = NSMakeRect(shadowDistance,
                                            shadowDistance,
                                            thumbnailImageSize.width + outerStrokeWidth * 2,
                                            thumbnailImageSize.height + outerStrokeWidth * 2);
    
    //整个缩略图的尺寸
    NSRect fullThumbnailRect = NSMakeRect(0,
                                          0,
                                          thumbnailStrokeRect.size.width + shadowDistance * 2,
                                          thumbnailStrokeRect.size.height + shadowDistance * 2);
    
    NSImage *thumbnail = [[NSImage alloc] initWithSize:fullThumbnailRect.size];
    
    
    
    
    //开始画图
    [thumbnail lockFocus];
    
    [NSGraphicsContext saveGraphicsState];
    
    //创建阴影
    NSShadow* theShadow = [[NSShadow alloc] init];
    [theShadow setShadowOffset:NSMakeSize(shadowDistance/2, -shadowDistance/2)];
    [theShadow setShadowBlurRadius:shadowDistance/2];
    
    // Use a partially transparent color for shapes that overlap.
    [theShadow setShadowColor:[[NSColor blackColor]
                               colorWithAlphaComponent:0.3]];
    //绘制阴影
    [theShadow set];
    
    
    [[NSColor whiteColor]setFill];
    [[NSColor clearColor]setStroke];
    
    //画一个白色的长方形
    [NSBezierPath fillRect:thumbnailStrokeRect];
    
    //停止阴影
    [NSGraphicsContext restoreGraphicsState];
    
    //绘制图片
    [image drawInRect:thumbnailImageRect
             fromRect:NSMakeRect(0, 0, image.size.width, image.size.height)
            operation:NSCompositeSourceOver
             fraction:1];
    [thumbnail unlockFocus];
    
    
    return thumbnail;
    
    
}


@end
