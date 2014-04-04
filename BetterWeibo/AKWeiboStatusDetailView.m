//
//  AKWeiboStatusDetailView.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-12-15.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKWeiboStatusDetailView.h"
#import "AKImageViewer.h"
#import "AKUserProfile.h"
#import "AKWeiboTableCellView.h"
#import "AKViewConstant.h"

#import "AKImageHelper.h"

@implementation AKWeiboStatusDetailView{
    AKImageViewer *_imageViewer;
    NSMutableArray *_observedObjectArray;
    
}
@synthesize hasRepostedWeibo = _hasRepostedWeibo;
@synthesize weiboTextField = _weiboTextField;
@synthesize status = _status;
@synthesize thumbnailImageURL = _thumbnailImageURL;


#pragma mark - Setup

-(void)dealloc{
    for (AKWeiboStatus *status in _observedObjectArray) {
        [status removeObserver:self forKeyPath:AKWeiboStatusPropertyNamedThumbnailImage];
    }
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

//        self.frame = frame;
        self.weiboTextField.minimalHeight = 32;
        self.weiboTextField.drawsBackground = NO;
        
    }
    return self;
}



- (void)drawRect:(NSRect)dirtyRect
{
	
    // Drawing code here.
    [super drawRect:dirtyRect];
//    
//    NSRect drawingRect = self.bounds;
//    
//    NSBezierPath *backgroundPath = [NSBezierPath bezierPathWithRect:drawingRect];
//    NSColor *backgroundColor = [NSColor whiteColor];
//    [backgroundColor setFill];
//    [backgroundPath fill];

    
//    CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
//    NSPoint startPoint = NSMakePoint(0, drawingRect.size.height - REPOST_STATUS_MARGIN_TOP + 0.5);
//    NSPoint endPoint = NSMakePoint(drawingRect.size.width, drawingRect.size.height - REPOST_STATUS_MARGIN_TOP + 0.5);
//    
//    NSColor *pathStrokeColor = [NSColor colorWithCalibratedWhite:0.5 alpha:1];
//    [pathStrokeColor setStroke];
//    NSBezierPath *path = [NSBezierPath bezierPath];
//    [path moveToPoint:startPoint];
//    [path lineToPoint:endPoint];
//    [path stroke];
//    
//    NSColor *shadowStartColor = [NSColor colorWithCalibratedWhite:0 alpha:1];
//    NSColor *shadowEndColor = [NSColor colorWithCalibratedWhite:0 alpha:0];
//    
//    NSGradient *shadowGradient = [[NSGradient alloc] initWithStartingColor:shadowStartColor endingColor:shadowEndColor];
//    
//    NSRect gradientRect = NSMakeRect(0,
//                                     self.statusView.frame.origin.y-5,
//                                     self.frame.size.width,
//                                     5);
//    
//    [shadowGradient drawInRect:gradientRect angle:90];


//    CGContextSetLineWidth(myContext, 1);
//    CGContextSetRGBStrokeColor(myContext, 0, 0, 0, 1);
//    CGContextMoveToPoint(myContext, startPoint.x, startPoint.y);
//    CGContextAddLineToPoint(myContext, endPoint.x, endPoint.y);
//    CGContextStrokePath(myContext);
    
    

}

-(void)awakeFromNib{
    
    self.userImage.borderType = AKUserButtonBorderTypeBezel;
    self.repostedWeiboView.autoresizingMask = NSViewWidthSizable;
    self.statusDateField.autoresizingMask = NSViewMaxXMargin | NSViewMinXMargin;
    //self.repostedWeiboDateDuration.autoresizingMask = NSViewMinXMargin | NSViewMinYMargin;
    
    scrollView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
    //不要忘了View的SuperView要wantsLayer
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowBlurRadius = 5;
    shadow.shadowColor = [NSColor colorWithCalibratedWhite:0 alpha:0.5];
    shadow.shadowOffset = NSMakeSize(0, -5);
    
    self.wantsLayer = YES;
    self.layer.backgroundColor = CGColorCreateGenericRGB(1, 1, 1, 1);
    self.statusView.layer.backgroundColor = CGColorCreateGenericRGB(1, 1, 1, 1);
    self.statusView.shadow = shadow;
    
    self.statusView.backgroundType = AKViewCustomDrawingBlock;
    self.statusView.customDrawingBlock = ^(NSRect dirtyRect){
        NSRect drawingRect = self.statusView.bounds;
        
        NSPoint startPoint = NSMakePoint(0, drawingRect.size.height - REPOST_STATUS_MARGIN_TOP + 0.5);
        NSPoint endPoint = NSMakePoint(drawingRect.size.width, drawingRect.size.height - REPOST_STATUS_MARGIN_TOP + 0.5);
        
        NSColor *pathStrokeColor = [NSColor colorWithCalibratedWhite:0.8 alpha:1];
        [pathStrokeColor setStroke];
        NSBezierPath *path = [NSBezierPath bezierPath];
        [path moveToPoint:startPoint];
        [path lineToPoint:endPoint];
        [path stroke];
        
    };
}
//
//-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
//    NSRect drawingRect = self.statusView.bounds;
//
//    NSPoint startPoint = NSMakePoint(0, drawingRect.size.height - REPOST_STATUS_MARGIN_TOP + 0.5);
//    NSPoint endPoint = NSMakePoint(drawingRect.size.width, drawingRect.size.height - REPOST_STATUS_MARGIN_TOP + 0.5);
//
//    
//    CGContextSetLineWidth(ctx, 1);
//    CGContextSetRGBStrokeColor(ctx, 0, 0, 0, 1);
//    CGContextMoveToPoint(ctx, startPoint.x, startPoint.y);
//    CGContextAddLineToPoint(ctx, endPoint.x, endPoint.y);
//    CGContextStrokePath(ctx);
//    
//}



#pragma mark - Properties

-(AKWeiboStatus *)status{
    
    return _status;
}



-(void)setStatus:(AKWeiboStatus *)status {
    
    
    _status = status;
    [self.userAlias setStringValue:status.user.screen_name];
    [self.weiboTextField.textStorage setAttributedString:status.attributedText];
    
    if(status.retweeted_status){
    
        self.repostedWeiboView.repostedStatus = status.retweeted_status;
        
        
    }else{
    
        [self.repostedWeiboView setHidden:YES];
        [self.repostedWeiboView setFrameSize:NSMakeSize(0, 0)];
        
    }
    
    self.userImage.userProfile = status.user;
//    AKWeiboStatus * _status = _status;
    
    //如果本条微博或转发的微博中包含有图片，则加载/显示图片
    if(_status.hasImages || (_status.retweeted_status && _status.retweeted_status.hasImages)){
    
        if(!_observedObjectArray){
            _observedObjectArray = [NSMutableArray new];
        }
        
        
        if(![_observedObjectArray containsObject:_status]){
            [_status addObserver:self forKeyPath:AKWeiboStatusPropertyNamedThumbnailImage options:0 context:NULL];
            [_status loadThumbnailImages];
            [_observedObjectArray addObject:_status];
        }
        
        //[_observedVisibleItems addObject:weibo];
        
        
        //如果本微博有图片，不过还没加载
        if (_status.hasImages){
            if(!_status.thumbnailImages){
                //        [cellView.progessIndicator setHidden:NO];
                //        [cellView.progessIndicator startAnimation:nil];
                //        [cellView.imageView setHidden:YES];
            }
            else{
                
                [self loadImages:_status.thumbnailImages];
                
            }
            
        }
        //要不然如果转发微博有带图片,不过还没加载
        else if (_status.retweeted_status && _status.retweeted_status.hasImages ){
            if(!_status.thumbnailImages){
                //        [cellView.progessIndicator setHidden:NO];
                //        [cellView.progessIndicator startAnimation:nil];
                //        [cellView.imageView setHidden:YES];
                
            }
            else{
                
                [self.repostedWeiboView loadImages:_status.thumbnailImages];
                
            }
            
        }
        
    }
    
    [self adjustPosition];
    
    [self.tabBar setLabel:@"评论" forSegment:0 ];
    [self.tabBar setLabel:@"转发" forSegment:1];
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:AKWeiboStatusPropertyNamedThumbnailImage]) {
        // Find the row and reload it.
        // Note that KVO notifications may be sent from a background thread (in this case, we know they will be)
        // We should only update the UI on the main thread, and in addition, we use NSRunLoopCommonModes to make sure the UI updates when a modal window is up.
        [self performSelectorOnMainThread:@selector(_reloadForEntity:) withObject:object waitUntilDone:NO modes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    }
}


- (void)_reloadForEntity:(id)object {


            // Fade the imageView in, and fade the progress indicator out
            //[NSAnimationContext beginGrouping];
            //[[NSAnimationContext currentContext] setDuration:0.8];
            
            //            [cellView.imageView setAlphaValue:0];
            //            cellView.imageView.image = entity.thumbnailImage;
            //            [cellView.imageView setHidden:NO];
            
            if(_status.hasImages){
                
                [self loadImages:_status.thumbnailImages];
                
            }else{
                
                [self.repostedWeiboView loadImages:_status.thumbnailImages];
                
            }
            
            
            //[[cellView.imageView animator] setAlphaValue:1.0];
            //[cellView.progessIndicator setHidden:YES];
            //[NSAnimationContext endGrouping];
    
    
}



-(void)adjustPosition{


    
    //[self.statusView setFrameSize:[self getStatusViewIntrinsicContentSize]];
    
    NSSize statusViewSize = self.frame.size;
    NSInteger y = 0;
    
    //Tab Bar
    [self.tabBar setFrameOrigin:NSMakePoint((NSInteger)((statusViewSize.width - self.tabBar.frame.size.width)/2), 5)];
    
    y = self.tabBar.frame.origin.y + self.tabBar.frame.size.height;
    

    
    //Toolbar
    [self.toolbar setFrameOrigin:NSMakePoint((statusViewSize.width - self.toolbar.frame.size.width)/2,  y + TOOLBAR_MARGIN_BOTTOM)];
    
    y += TOOLBAR_MARGIN_BOTTOM + self.toolbar.frame.size.height +TOOLBAR_MARGIN_TOP;
    
    NSInteger textMarginLeft = USER_AVATAR_MARGIN_LEFT+self.userImage.frame.size.width+USER_AVATAR_MARGIN_RIGHT;
    
    //Images
    if(_status.pic_urls && _status.pic_urls.count>0){
    
        NSSize weiboImageMatrixSize;
        if(_status.pic_urls.count ==1){
            
            weiboImageMatrixSize = NSMakeSize(LARGE_THUMBNAIL_SIZE, LARGE_THUMBNAIL_SIZE);
            
        }
        else{
            
            weiboImageMatrixSize = NSMakeSize(self.images.numberOfColumns * (SMALL_THUMBNAIL_SIZE+SMALL_THUMBNAIL_SPACING)-SMALL_THUMBNAIL_SPACING,
                                              ((NSInteger)((_status.pic_urls.count+2)/3)) * (SMALL_THUMBNAIL_SIZE+SMALL_THUMBNAIL_SPACING)-SMALL_THUMBNAIL_SPACING);
            
        }
        
        
        [self.images setFrameSize:weiboImageMatrixSize];
        [self.images setFrameOrigin:NSMakePoint(textMarginLeft, y)];
    
        y+=self.images.frame.size.height+IMAGE_MARGIN_TOP;
    }
    
    //Text
    [self.weiboTextField setFrameSize:NSMakeSize(statusViewSize.width-(textMarginLeft+STATUS_MARGIN_RIGHT), 1000)];
    [self.weiboTextField setFrameSize:self.weiboTextField.intrinsicContentSize];
    [self.weiboTextField setFrameOrigin:NSMakePoint(textMarginLeft, y)];
    
    y+=self.weiboTextField.frame.size.height + STATUS_TEXT_MARGIN_TOP;
    
    //User Alias
    [self.userAlias setFrameOrigin:NSMakePoint(self.weiboTextField.frame.origin.x, y)];
    
    //Date Duration
    [self.dateDuration setFrameOrigin:NSMakePoint(statusViewSize.width-self.dateDuration.frame.size.width - STATUS_MARGIN_RIGHT, y)];
    
    y += self.userAlias.frame.size.height;
    
    //User Avatar
    [self.userImage setFrameOrigin:NSMakePoint(USER_AVATAR_MARGIN_LEFT, y-self.userImage.frame.size.height)];
    
    y += STATUS_MARGIN_TOP;
    
    NSInteger repostY = 0;
    //Repost View Part
    if(_status.retweeted_status){
        //For new layout
        NSSize repostedWeiboViewSize;
        if(!_status.retweeted_status.user){
        
            repostedWeiboViewSize = statusViewSize;
            repostedWeiboViewSize.height = REPOST_STATUS_MESSAGE_BLOCK_HEIGH;
            
        
        }else{
        
            repostedWeiboViewSize = self.repostedWeiboView.intrinsicContentSize;
        
        }
        [self.repostedWeiboView setFrameSize:repostedWeiboViewSize];
        [self.repostedWeiboView setFrameOrigin:NSMakePoint(0, y)];
        repostY = self.repostedWeiboView.frame.size.height;
       
    }
    
    y+=repostY;
    
    
    //Date
    [self.statusDateField setFrameOrigin:(NSMakePoint((statusViewSize.width-self.statusDateField.frame.size.width)/2, y+(REPOST_STATUS_MARGIN_TOP - self.statusDateField.frame.size.height)/2))];
    
    

//    [self.spliter setFrame:NSMakeRect(0, y, statusViewSize.width, 1)];
//    [self.spliter setNeedsDisplay:YES];
    
    y += REPOST_STATUS_MARGIN_TOP;
    statusViewSize.height = y;
    
    [self.statusView setFrameSize:statusViewSize];
    [self.statusView setFrameOrigin:NSMakePoint(0, self.bounds.size.height - self.statusView.frame.size.height)];
    
    NSSize tabViewSize = self.frame.size;
    tabViewSize.height = self.frame.size.height - self.statusView.frame.size.height;
    [self.tab setFrameSize:tabViewSize];
    [self.tab setFrameOrigin:NSMakePoint(0, 0)];
    
    for(NSTabViewItem* tabViewItem in self.tab.tabViewItems){
    
        NSView *tabView = tabViewItem.view;
        for(NSView *subView in [tabView subviews]){
        
            [subView setFrame:NSMakeRect(0, 0, tabView.frame.size.width, tabView.frame.size.height)];

        }
  
        
    }
    
//    NSRange visibleRows = [self.commentListView rowsInRect:self.visibleRect];
//    [NSAnimationContext beginGrouping];
//    [[NSAnimationContext currentContext] setDuration:0];
//    [self.commentListView noteHeightOfRowsWithIndexesChanged:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, <#NSUInteger len#>)]];
//    [NSAnimationContext endGrouping];
    
    
    //[self needsDisplay];
    
    
    

    
}

-(NSString *)thumbnailImageURL{
    
    return _thumbnailImageURL;
    
}

-(void)setThumbnailImageURL:(NSString *)thumbnailImageURL{
    
    _thumbnailImageURL = thumbnailImageURL;
    if(_thumbnailImageURL)
    {
        return;
    }
    
    NSImage *image = [[NSImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:thumbnailImageURL]]];
    NSImageCell *imageCell = [[NSImageCell alloc]initImageCell:image];
    [self.images setCell:imageCell];
    
    [self.images setHidden:NO];
    
}

-(BOOL)hasRepostedWeibo{
    
    return _hasRepostedWeibo;
    
}


-(void)setHasRepostedWeibo:(BOOL)hasRepostedWeibo{
    
    _hasRepostedWeibo = hasRepostedWeibo;
    
    //[self.repostedWeiboView setHidden:!hasRepostedWeibo];
    
    
    //[self resize];
    
}


-(void)loadImages:(NSArray *)images{
    
    [self loadImages:images isForRepost:NO];
    
    
}


-(void)loadImages:(NSArray *)images isForRepost:(BOOL)isForRepost{
    
    //assert(self.images.numberOfRows == 0);
    //    NSLog(@"COUNT = ",cell.weiboTextField.stringValue);
    
    NSMatrix *imageMatrix;
    if(isForRepost){
        return;
        imageMatrix = self.repostedWeiboView.repostedWeiboImageMatrix;
        [self.images setHidden:YES];
    }
    else{
        imageMatrix = self.images;
        //[self.repostedWeiboView.repostedWeiboImageMatrix setHidden:YES];
    }
    
    
    [AKImageHelper putImages:images inMatrix:self.images target:self action:@selector(imageCellClicked:)];

}

-(void)imageCellClicked:(id)sender{
    
    //NSLog(@"imageCellClicked");
    NSMatrix *imageMatrix = sender;
    NSCell *selectedCell = imageMatrix.selectedCell;
    AKWeiboStatus *status = self.status;
    NSArray *imageURLArray = (status.pic_urls && status.pic_urls.count>0)?status.pic_urls:status.retweeted_status.pic_urls;

    _imageViewer = [AKImageViewer sharedInstance];
    _imageViewer.images = imageURLArray;
    _imageViewer.index = selectedCell.tag;

    [_imageViewer show];
    
}


-(NSSize)getRepostedWeiboViewSize{

    if(!self.status.retweeted_status){
        return NSMakeSize(0, 0);
    }
    NSSize size = self.repostedWeiboView.frame.size;
    
    size.height = REPOST_STATUS_PADDING_TOP + self.repostedWeiboUserAlias.frame.size.height + STATUS_TEXT_MARGIN_TOP + self.repostedWeiboContent.intrinsicContentSize.height + REPOST_STATUS_PADDING_BOTTOM;
    
    if(_status.retweeted_status.pic_urls && _status.retweeted_status.pic_urls.count>0){
        
        size.height += IMAGE_MARGIN_TOP;
        
        if(_status.retweeted_status.pic_urls.count ==1){
            
            size.height += LARGE_THUMBNAIL_SIZE;
            
        }
        else{
            
            size.height += ((NSInteger)((_status.retweeted_status.pic_urls.count+2)/3)) * (SMALL_THUMBNAIL_SIZE+SMALL_THUMBNAIL_SPACING)-SMALL_THUMBNAIL_SPACING;
            
        }
        
        

    }
    
    return size;
    

}


-(NSSize)getStatusViewIntrinsicContentSize{

    NSSize size = self.frame.size;
    NSInteger height = REPOST_STATUS_MARGIN_TOP + [self getRepostedWeiboViewSize].height + STATUS_MARGIN_TOP + self.userAlias.frame.size.height + STATUS_TEXT_MARGIN_TOP + self.weiboTextField.intrinsicContentSize.height + TOOLBAR_MARGIN_TOP + self.toolbar.frame.size.height + TOOLBAR_MARGIN_BOTTOM;
    
    size.height = height;
    
    return size;
    

}

//-(void)resizeWithOldSuperviewSize:(NSSize)oldSize{
//    NSLog(@"width=%f, height=%f", oldSize.width, oldSize.height);
//
//    [super resizeWithOldSuperviewSize:oldSize];
//    [self adjustPosition];
//    return;
//    
//}

-(void)resizeSubviewsWithOldSize:(NSSize)oldSize{
    //[super resizeSubviewsWithOldSize:oldSize];
    [self adjustPosition];
    return;
    
    NSInteger moveHeight = 0;
 
    //Status View
    NSInteger oldStatusViewHeight = self.statusView.frame.size.height;
    [self.statusView setFrameSize:[self getStatusViewIntrinsicContentSize]];
    moveHeight = self.statusView.frame.size.height - oldStatusViewHeight;
    
    [self.statusView setFrameOrigin:NSMakePoint(0, self.bounds.size.height - self.statusView.frame.size.height)];
    
    //Scroll View
//    NSSize scrollViewSize = self.frame.size;
//    scrollViewSize.height = self.frame.size.height - self.statusView.frame.size.height;
//    [scrollView setFrameSize:scrollViewSize];
//    [scrollView setFrameOrigin:NSMakePoint(0, 0)];

    NSInteger moveRepostWeiboHeight = 0;
    if(self.status.retweeted_status){
    
        
        NSRect oldFrame = self.repostedWeiboView.frame;
        
        //Reposted Weibo View
        [self.repostedWeiboView setFrameSize:[self getRepostedWeiboViewSize]];
        [self.repostedWeiboView setFrameOrigin:NSMakePoint(oldFrame.origin.x,oldFrame.origin.y - (self.repostedWeiboView.frame.size.height - oldFrame.size.height))];
        
        NSInteger oldContentHeight = self.repostedWeiboContent.frame.size.height;
        [self.repostedWeiboContent adjustFrame];
        //[self.repostedWeiboContent setFrameSize:self.repostedWeiboContent.intrinsicContentSize];
        
        moveRepostWeiboHeight = self.repostedWeiboContent.frame.size.height - oldContentHeight;
        
        for(NSView *subView in self.repostedWeiboView.subviews){
            //        if(subView == self.repostedWeiboContent){
            //            continue;
            //        }
            NSPoint newOrigin = subView.frame.origin;
            newOrigin.y += moveRepostWeiboHeight;
            [subView setFrameOrigin:newOrigin];
        }
        
    
    }

//    for(NSView * subView in self.statusView.subviews){
//        //跳过转发微博内容和发布日期
//        if(subView == self.repostedWeiboView || subView == self.statusDateField || subView == self.toolbar){
//            continue;
//        }
//        
//        NSPoint newOrigin = subView.frame.origin;
//        newOrigin.y -= moveRepostWeiboHeight;
//        [subView setFrameOrigin:newOrigin];
//        
//    }
    
    
    NSInteger oldContentHeight = self.weiboTextField.frame.size.height;
    [self.weiboTextField adjustFrame];
    NSInteger moveStatusTextHeight = self.weiboTextField.frame.size.height - oldContentHeight;
    
    

    
    
    for(NSView * subView in self.statusView.subviews){
        //跳过转发微博内容和发布日期
        if(subView == self.toolbar ){
            continue;
        }


        NSPoint newOrigin = subView.frame.origin;
        newOrigin.y += (moveRepostWeiboHeight + moveStatusTextHeight);
        [subView setFrameOrigin:newOrigin];
        
    }
    
    //调整其它转发微博内容区之外的控件的位置
    for(NSView * subView in self.statusView.subviews){
        //跳过转发微博内容和发布日期
        if(subView == self.repostedWeiboView || subView == self.statusDateField || subView == self.toolbar){
            continue;
        }

        NSPoint newOrigin = subView.frame.origin;
        newOrigin.y -= moveStatusTextHeight;
        [subView setFrameOrigin:newOrigin];
 
    }

    
//    [self adjustPosition];
    
}

-(IBAction)toolbarClicked:(id)sender{
    
    NSButtonCell *clickedButton = [(NSMatrix *)sender selectedCell];
    switch (clickedButton.tag) {
        case 0:
            //转发
            break;
            
        case 1:
            //评论
            break;
            
        case 2:
            //收藏
            break;
            
        case 3:
            //其它
            break;
            
        default:
            break;
    }
    
    
}



@end
