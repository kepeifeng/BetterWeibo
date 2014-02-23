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
    
}
@synthesize hasRepostedWeibo = _hasRepostedWeibo;
@synthesize weiboTextField = _weiboTextField;
@synthesize status = _status;
@synthesize thumbnailImageURL = _thumbnailImageURL;


#pragma mark - Setup


- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

//        self.frame = frame;
        self.weiboTextField.minimalHeight = 32;
        
    }
    return self;
}



- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
    // Drawing code here.
    
    NSRect drawingRect = self.frame;
    
    CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
    NSPoint startPoint = NSMakePoint(0, drawingRect.size.height - REPOST_STATUS_MARGIN_TOP + 0.5);
    NSPoint endPoint = NSMakePoint(drawingRect.size.width, drawingRect.size.height - REPOST_STATUS_MARGIN_TOP + 0.5);
    
    CGContextSetLineWidth(myContext, 1);
    CGContextSetRGBStrokeColor(myContext, 0.5, 0.5, 0.5, 0.5);
    CGContextMoveToPoint(myContext, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(myContext, endPoint.x, endPoint.y);
    CGContextStrokePath(myContext);

}

-(void)awakeFromNib{

//    NSRect insetRect = NSInsetRect([[self.window contentView] bounds], 30, 30);
//    AKTextView *statusView = [[AKTextView alloc] initWithFrame:insetRect];
//	[statusView setBackgroundColor:[NSColor clearColor]];
//    [statusView setAutoresizingMask:NSViewNotSizable];
//	[statusView setTextContainerInset:NSZeroSize];
//	[statusView setEditable:NO];
//	[statusView setSelectable:YES];
//    self.weiboTextField = statusView;
	
	// Add to window and we're done.
//	[self.statusView addSubview:statusView];
    
    self.repostedWeiboView.autoresizingMask = NSViewWidthSizable;
    self.statusDateField.autoresizingMask = NSViewMaxXMargin | NSViewMinXMargin;
    //self.repostedWeiboDateDuration.autoresizingMask = NSViewMinXMargin | NSViewMinYMargin;
    
    scrollView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
}




#pragma mark - Properties

-(AKWeiboStatus *)status{
    
    return _status;
}



-(void)setStatus:(AKWeiboStatus *)status {
    
    
    _status = status;
    [self.userAlias setStringValue:status.user.screen_name];
    [self.weiboTextField setStringValue:status.text];
    
    if(status.retweeted_status){
    
        self.repostedWeiboView.repostedStatus = status.retweeted_status;
        
        
//        
//        [self.repostedWeiboContent setStringValue:status.retweeted_status.text];
//        [self.repostedWeiboUserAlias setStringValue:status.retweeted_status.user.screen_name];
//        
//        if(status.retweeted_status.pic_urls && status.retweeted_status.pic_urls.count>0){
//        
//            [self loadImages:status.retweeted_status.pic_urls isForRepost:YES];
//        
//        }
        
    }else{
    
        [self.repostedWeiboView setHidden:YES];
        [self.repostedWeiboView setFrameSize:NSMakeSize(0, 0)];
        
    }
    
//    AKWeiboStatus * _status = _status;
    
    //如果本条微博或转发的微博中包含有图片，则加载/显示图片
    if(_status.hasImages || (_status.retweeted_status && _status.retweeted_status.hasImages)){
        
        //[self loadImages:status.pic_urls isForRepost:NO];
        [_status addObserver:self forKeyPath:ATEntityPropertyNamedThumbnailImage options:0 context:NULL];
        [_status loadThumbnailImages];
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
    
    [self.tabBar setLabel:[NSString stringWithFormat:@"评论", status.comments_count] forSegment:0 ];
    [self.tabBar setLabel:[NSString stringWithFormat:@"转发", status.reposts_count] forSegment:1];
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:ATEntityPropertyNamedThumbnailImage]) {
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
    
    //Toolbar
    [self.toolbar setFrameOrigin:NSMakePoint((statusViewSize.width - self.toolbar.frame.size.width)/2,  TOOLBAR_MARGIN_BOTTOM)];
    
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

        NSSize repostedWeiboViewSize = self.repostedWeiboView.intrinsicContentSize;
//        repostedWeiboViewSize.height = 1000;
        
        [self.repostedWeiboView setFrameSize:repostedWeiboViewSize];
        [self.repostedWeiboView setFrameOrigin:NSMakePoint(0, y)];
        repostY = self.repostedWeiboView.frame.size.height;
        
        //=====
        
        
        /*
        //For old layout
        NSSize repostedWeiboViewSize = statusViewSize;
        repostedWeiboViewSize.height = 1000;
        
        [self.repostedWeiboView setFrameSize:repostedWeiboViewSize];
        
        [self.repostedWeiboView setFrameOrigin:NSMakePoint(0, y)];
        
        
        repostY += REPOST_STATUS_PADDING_BOTTOM;
        
        //Images
        if(_status.retweeted_status.pic_urls && _status.retweeted_status.pic_urls.count>0)
        {
            NSSize weiboImageMatrixSize;
            if(_status.retweeted_status.pic_urls.count ==1){
                
                weiboImageMatrixSize = NSMakeSize(LARGE_THUMBNAIL_SIZE, LARGE_THUMBNAIL_SIZE);
                
            }
            else{
                
                weiboImageMatrixSize = NSMakeSize(self.repostedWeiboImageMatrix.numberOfColumns * (SMALL_THUMBNAIL_SIZE+SMALL_THUMBNAIL_SPACING)-SMALL_THUMBNAIL_SPACING,
                                                  ((NSInteger)((_status.retweeted_status.pic_urls.count+2)/3)) * (SMALL_THUMBNAIL_SIZE+SMALL_THUMBNAIL_SPACING)-SMALL_THUMBNAIL_SPACING);
                
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
        
        repostY += REPOST_STATUS_PADDING_TOP;
        
        repostedWeiboViewSize = self.repostedWeiboView.frame.size;
        repostedWeiboViewSize.height = repostY;
        
        [self.repostedWeiboView setFrameSize:repostedWeiboViewSize];
        */
        //User Avatar
        //[self.userImage setFrameOrigin:NSMakePoint(USER_AVATAR_MARGIN_LEFT, y-self.userImage.frame.size.height)];
        
    }
    
    y+=repostY;
    
    [self.statusDateField setFrameOrigin:(NSMakePoint((statusViewSize.width-self.statusDateField.frame.size.width)/2, y+(REPOST_STATUS_MARGIN_TOP - self.statusDateField.frame.size.height)/2))];
    
    y += REPOST_STATUS_MARGIN_TOP;
    statusViewSize.height = y;
    
    [self.statusView setFrameSize:statusViewSize];
    [self.statusView setFrameOrigin:NSMakePoint(0, self.bounds.size.height - self.statusView.frame.size.height)];
    
    //Tab Bar
    [self.tabBar setFrameOrigin:NSMakePoint((NSInteger)((statusViewSize.width - self.tabBar.frame.size.width)/2), (NSInteger)(self.statusView.frame.origin.y - TABBAR_MARGIN_TOP - self.tabBar.frame.size.height))];
    
    
    NSSize tabViewSize = self.frame.size;
    tabViewSize.height = self.frame.size.height - self.statusView.frame.size.height - TABBAR_MARGIN_TOP - self.tabBar.frame.size.height - TABBAR_MARGIN_BOTTOM;
    [self.tab setFrameSize:tabViewSize];
    [self.tab setFrameOrigin:NSMakePoint(0, 0)];
    
    for(NSTabViewItem* tabViewItem in self.tab.tabViewItems){
    
        NSView *tabView = tabViewItem.view;
        for(NSView *subView in [tabView subviews]){
        
            [subView setFrame:NSMakeRect(0, 0, tabView.frame.size.width, tabView.frame.size.height)];
//            if([subView isKindOfClass:[NSScrollView class]]){
//            
//                [(NSView *)((NSScrollView *)subView).documentView setFrame:NSMakeRect(0, 0, tabView.frame.size.width, tabView.frame.size.height)];
//            
//            }
            

//            for(NSView *scrollViewInTab in [subView subviews]){
//                
//                [scrollViewInTab setFrame:NSMakeRect(0, 0, tabView.frame.size.width, tabView.frame.size.height)];
//                
//            }
        }
  
        
    }
    
    NSRange visibleRows = [self.commentListView rowsInRect:self.visibleRect];
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0];
    [self.commentListView noteHeightOfRowsWithIndexesChanged:[NSIndexSet indexSetWithIndexesInRange:visibleRows]];
    [NSAnimationContext endGrouping];
    
    
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
    
    [self.repostedWeiboView setHidden:!hasRepostedWeibo];
    
    
    //[self resize];
    
}


//
//-(void)mouseEntered:(NSEvent *)theEvent{
//    
//    [self.toolbar setHidden:NO];
//    
//    
//}
//
//-(void)mouseExited:(NSEvent *)theEvent{
//    
//    [self.toolbar setHidden:YES];
//    
//}

//- (void)updateTrackingAreas {
//    
//    if(trackingArea != nil) {
//        [self removeTrackingArea:trackingArea];
//    }
//    
//    int opts = (NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways);
//    trackingArea = [ [NSTrackingArea alloc] initWithRect:[self bounds]
//                                                 options:opts
//                                                   owner:self
//                                                userInfo:nil];
//    [self addTrackingArea:trackingArea];
//    
//}


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
//    
//    if(imageURL && imageURL.count >0){
//        
//        //        [imageMatrix ]
//        
//        NSInteger i = 0;
//        //第一行 第一列
//        //[imageMatrix addRow];
//        for(NSDictionary *url in imageURL){
//            
//            NSImage *image = [[NSImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[url objectForKey:@"thumbnail_pic"]]]];
//            
//            
//            NSButtonCell *imageCell = [imageMatrix cellAtRow:(NSInteger)(i/3) column:(i%3)];
//            imageCell.tag = i;
//            imageCell.image = image;
//            i++;
//            
//        }
//        
//        assert(i<=9);
//        
//        if(imageURL.count == 1){
//            
//            imageMatrix.cellSize = NSMakeSize(LARGE_THUMBNAIL_SIZE, LARGE_THUMBNAIL_SIZE);
//        }else{
//            
//            imageMatrix.cellSize = NSMakeSize(SMALL_THUMBNAIL_SIZE, SMALL_THUMBNAIL_SIZE);
//        }
//        
//        [imageMatrix setTarget:self];
//        [imageMatrix setAction:@selector(imageCellClicked:)];
//        [imageMatrix setHidden:NO];
//        
//    }
//    
//    else{
//        
//        [imageMatrix setHidden:YES];
//    }
}

-(void)imageCellClicked:(id)sender{
    
    //NSLog(@"imageCellClicked");
    NSMatrix *imageMatrix = sender;
    NSCell *selectedCell = imageMatrix.selectedCell;
    AKWeiboStatus *status = self.status;
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
