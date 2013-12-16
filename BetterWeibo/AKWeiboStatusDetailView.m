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

@implementation AKWeiboStatusDetailView{
    AKImageViewer *_imageViewer;

//    NSTrackingArea *trackingArea;
    
}

#define REPOST_STATUS_MARGIN_TOP 38
#define REPOST_STATUS_PADDING_TOP 20
#define REPOST_STATUS_PADDING_BOTTOM 20
#define REPOST_STATUS_PADDING_LEFT 20
#define REPOST_STATUS_PADDING_RIGHT 20

#define STATUS_MARGIN_TOP 20
#define USER_AVATAR_MARGIN_LEFT 10
#define USER_AVATAR_MARGIN_RIGHT 10
#define STATUS_MARGIN_RIGHT 20
#define STATUS_TEXT_MARGIN_TOP 5

#define IMAGE_MARGIN_TOP 10

#define TOOLBAR_MARGIN_TOP 10
#define TOOLBAR_MARGIN_BOTTOM 10

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
    
//    NSImage *repostedWeiboViewBackground = [NSImage imageNamed:@"repost-background-frame"];
    
    //NSLog(@"(%f, %f, %f, %f", repostedWeiboDrawingRect.origin.x, repostedWeiboDrawingRect.origin.y
    //      , repostedWeiboDrawingRect.size.width, repostedWeiboDrawingRect.size.height);
    
    //Top
    
    //[self resize];
    
//    if(self.status && self.status.retweeted_status){
//        if(YES){
//        
//        NSRect repostedWeiboDrawingRect =self.repostedWeiboView.frame;
//        
//        //Top
//        [repostedWeiboViewBackground drawInRect:NSMakeRect(0, repostedWeiboDrawingRect.origin.y + repostedWeiboDrawingRect.size.height - 8, repostedWeiboDrawingRect.size.width, 8) fromRect:NSMakeRect(0, 49, 81, 8) operation:NSCompositeSourceOver fraction:1];
//        //Middle Part
//        [repostedWeiboViewBackground drawInRect:NSMakeRect(0, repostedWeiboDrawingRect.origin.y + 14, repostedWeiboDrawingRect.size.width, repostedWeiboDrawingRect.size.height - 8 - 14) fromRect:NSMakeRect(0, 14, 81, 34) operation:NSCompositeSourceOver fraction:1];
//        //Bottom Part - Arrow
//        [repostedWeiboViewBackground drawInRect:NSMakeRect(0, repostedWeiboDrawingRect.origin.y, 50, 14) fromRect:NSMakeRect(0, 0, 50, 14) operation:NSCompositeSourceOver fraction:1];
//        //Bottom Right Part
//        [repostedWeiboViewBackground drawInRect:NSMakeRect(50, repostedWeiboDrawingRect.origin.y, repostedWeiboDrawingRect.size.width - 50, 14) fromRect:NSMakeRect(50, 0, 31, 14) operation:NSCompositeSourceOver fraction:1];
//        
//    }
    
    // Drawing code here.
}

-(void)awakeFromNib{

    if(_status){
        
        [self.userAlias setStringValue:_status.user.screen_name];
        [self.weiboTextField setStringValue:_status.text];
    }
    
//    self.repostedWeiboView.wantsLayer = YES;
//    self.repostedWeiboView.layer.backgroundColor = CGColorCreateGenericRGB(0.8, 0.8, 0.8 , 1);
    self.repostedWeiboView.autoresizingMask = NSViewWidthSizable;
    self.statusDateField.autoresizingMask = NSViewMaxXMargin | NSViewMinXMargin;
    self.repostedWeiboDateDuration.autoresizingMask = NSViewMinXMargin | NSViewMinYMargin;
    
    self.statusView.wantsLayer = YES;
    self.statusView.layer.backgroundColor = CGColorCreateGenericRGB(0.9, 0.7, 0.8, 1);
    
//    self.repostedWeiboUserAlias.autoresizingMask = NSViewMinYMargin;
//    self.repostedWeiboView.autoresizingMask = NSViewMinYMargin;
}

#pragma mark - Properties

-(AKWeiboStatus *)status{
    
    return _status;
}

-(void)setStatus:(AKWeiboStatus *)status {
    
    
    _status = status;
    [self.userAlias setStringValue:status.user.screen_name];
    [self.weiboTextField setStringValue:status.text];
    
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


-(void)resize{
    
    CGFloat repostedWeiboHeight;
    CGFloat weiboHeight;
    CGFloat repostedWeiboViewHeight;
    CGFloat weiboViewHeight;
    
    AKWeiboStatus *weibo = self.status;
    
    
    CGFloat cellHeight = [AKWeiboTableCellView caculateWeiboCellHeight:weibo forWidth:self.frame.size.width repostedWeiboHeight:&repostedWeiboHeight repostedWeiboViewHeight:&repostedWeiboViewHeight weiboHeight:&weiboHeight weiboViewHeight:&weiboViewHeight];
    
    if(weibo.retweeted_status){
        
        [self.repostedWeiboView setFrameSize:NSMakeSize(self.repostedWeiboView.frame.size.width, repostedWeiboViewHeight)];
        
        [self.repostedWeiboView setFrameOrigin:NSMakePoint(0, weiboViewHeight)];
        
        //[self.repostedWeiboContent setFrameSize:self.repostedWeiboContent.intrinsicContentSize];
        
        [self.repostedWeiboContent setFrameSize:NSMakeSize(self.repostedWeiboContent.frame.size.width, repostedWeiboHeight)];
        [self.repostedWeiboContent setFrameOrigin:NSMakePoint(self.repostedWeiboContent.frame.origin.x, repostedWeiboViewHeight - 27 - 5 - self.repostedWeiboContent.frame.size.height)];
        
        
        //update reposted weibo's user alias' origin.
        [self.repostedWeiboUserAlias setFrameOrigin:NSMakePoint(self.repostedWeiboUserAlias.frame.origin.x,
                                                                repostedWeiboViewHeight - 27)];
        [self.repostedWeiboDateDuration setFrameOrigin:NSMakePoint(self.repostedWeiboDateDuration.frame.origin.x,
                                                                   repostedWeiboViewHeight -27)];
        
        if(weibo.retweeted_status.pic_urls && weibo.retweeted_status.pic_urls.count>0){
            
            NSSize repostedWeiboImageMatrixSize;
            if(weibo.retweeted_status.pic_urls.count ==1){
                
                repostedWeiboImageMatrixSize = NSMakeSize(90, 90);
                
            }
            else{
                
                repostedWeiboImageMatrixSize = NSMakeSize(self.repostedWeiboImageMatrix.numberOfColumns * 45, self.repostedWeiboImageMatrix.numberOfRows * 45);
                
            }
            [self.repostedWeiboImageMatrix setFrameSize:repostedWeiboImageMatrixSize];
            [self .repostedWeiboImageMatrix setFrameOrigin:NSMakePoint(60, 25)];
            
        }
        
        
        
    }
    
    
    
    
    //[self.weiboView setFrameSize:NSMakeSize(self.weiboView.frame.size.width, weiboViewHeight)];
    
    //update reposted weibo's user alias' origin.
    [self.userAlias setFrameOrigin:NSMakePoint(self.userAlias.frame.origin.x,
                                               weiboViewHeight - 27)];
    
    //Date Duration
    [self.dateDuration setFrameOrigin:NSMakePoint(self.dateDuration.frame.origin.x, weiboViewHeight - 27)];
    
    //User Avatar
    [self.userImage setFrameOrigin:NSMakePoint(self.userImage.frame.origin.x, weiboViewHeight - (self.userImage.frame.size.height - self.userAlias.frame.size.height) - 27)];
    
    //Weibo Text
    [self.weiboTextField setFrameSize:NSMakeSize(self.weiboTextField.frame.size.width, weiboHeight)];
    [self.weiboTextField setFrameOrigin:NSMakePoint(self.weiboTextField.frame.origin.x, weiboViewHeight - 27 - 5 - self.weiboTextField.frame.size.height)];
    
    
    //Images
    if(weibo.pic_urls && weibo.pic_urls.count>0){
        
        NSSize weiboImageMatrixSize;
        if(weibo.pic_urls.count ==1){
            
            weiboImageMatrixSize = NSMakeSize(90, 90);
            
        }
        else{
            
            weiboImageMatrixSize = NSMakeSize(self.images.numberOfColumns * 45, self.images.numberOfRows * 45);
            
        }
        
        
        [self.images setFrameSize:weiboImageMatrixSize];
        [self .images setFrameOrigin:NSMakePoint(60, 10)];
    }
    
    //Favorite Mark
//    NSPoint favoriteMarkOrigin = NSMakePoint(self.weiboView.frame.size.width - self.favMark.frame.size.width, weiboViewHeight - self.favMark.frame.size.height);;
//    if(weibo.retweeted_status){
//        
//        favoriteMarkOrigin.y += 10;
//        
//    }
//    [self.favMark setFrameOrigin:favoriteMarkOrigin];
    
    
    
    
    //[self setFrameSize:NSMakeSize(self.frame.size.width, cellHeight)];
    
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

-(void)loadImages:(NSArray *)imageURL{
    
    [self loadImages:imageURL isForRepost:NO];
    
    
}


-(void)loadImages:(NSArray *)imageURL isForRepost:(BOOL)isForRepost{
    
    //assert(self.images.numberOfRows == 0);
    //    NSLog(@"COUNT = ",cell.weiboTextField.stringValue);
    
    NSMatrix *imageMatrix;
    if(isForRepost){
        imageMatrix = self.repostedWeiboImageMatrix;
    }
    else{
        imageMatrix = self.images;
    }
    
    if(imageURL && imageURL.count >0){
        
        //        [imageMatrix ]
        
        NSInteger i = 0;
        //第一行 第一列
        [imageMatrix addRow];
        for(NSDictionary *url in imageURL){
            
            NSImage *image = [[NSImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[url objectForKey:@"thumbnail_pic"]]]];
            
            
            NSButtonCell *imageCell = [[NSButtonCell alloc]init];
            imageCell.tag = i;
            imageCell.image = image;
            if(i==1 || i==2){
                //i==1 2的时候，各自添加一列。
                [imageMatrix addColumn];
            }
            else if (i==3 || i == 6){
                //i==3的时候添加第二行
                //i==6的时候添加第三行
                [imageMatrix addRow];
            }
            
            [imageMatrix putCell:imageCell atRow:(NSInteger)(i/3) column:(i%3)];
            //[imageMatrix setCell:imageCell];
            i++;
            
        }
        
        assert(i<=9);
        
        if(imageURL.count == 1){
            
            imageMatrix.cellSize = NSMakeSize(90, 90);
        }else{
            
            imageMatrix.cellSize = NSMakeSize(45, 45);
        }
        
        [imageMatrix setTarget:self];
        [imageMatrix setAction:@selector(imageCellClicked:)];
        [imageMatrix setHidden:NO];
        
    }
    
    else{
        
        [imageMatrix setHidden:YES];
    }
}

-(void)imageCellClicked:(id)sender{
    
    //NSLog(@"imageCellClicked");
    NSMatrix *imageMatrix = sender;
    NSCell *selectedCell = imageMatrix.selectedCell;
    AKWeiboStatus *status = self.status;
    NSArray *imageURLArray = (status.pic_urls && status.pic_urls.count>0)?status.pic_urls:status.retweeted_status.pic_urls;
    NSString *url = [(NSDictionary *)[imageURLArray objectAtIndex:selectedCell.tag] objectForKey:@"thumbnail_pic"];
    //"thumbnail_pic": "http://ww1.sinaimg.cn/thumbnail/d3976c6ejw1ebbzpeeadwj20d107b74e.jpg"
    //"bmiddle_pic": "http://ww1.sinaimg.cn/bmiddle/d3976c6ejw1ebbzpeeadwj20d107b74e.jpg"
    //"original_pic": "http://ww1.sinaimg.cn/large/d3976c6ejw1ebbzpeeadwj20d107b74e.jpg"
    url = [url stringByReplacingOccurrencesOfString:@"/thumbnail/" withString:@"/bmiddle/"];
    NSImage *image = [[NSImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    
    if(!_imageViewer){
        _imageViewer = [[AKImageViewer alloc] initWithImage:image];
    }
    else{
        _imageViewer.image = image;
    }
    
    [_imageViewer show];
    
}

-(void)viewDidEndLiveResize{

    
//    NSRect oldFrame = self.repostedWeiboView.frame;
//    [self.repostedWeiboView setFrameSize:[self getRepostedWeiboViewSize]];
//    [self.repostedWeiboView setFrameOrigin:NSMakePoint(oldFrame.origin.x,oldFrame.origin.y - (self.repostedWeiboView.frame.size.height - oldFrame.size.height))];
//    
//    NSInteger oldContentHeight = self.repostedWeiboContent.frame.size.height;
//    [self.repostedWeiboContent setFrameSize:self.repostedWeiboContent.intrinsicContentSize];
//    
//    NSInteger moveHeight = self.repostedWeiboContent.frame.size.height - oldContentHeight;
//    
//    NSPoint newOrigin = self.repostedWeiboUserAlias.frame.origin;
//    newOrigin.y += moveHeight;
//    
//    [self.repostedWeiboUserAlias setFrameOrigin:newOrigin];
    
    //[self.repostedWeiboContent adjustFrame];
    //[self.weiboTextField adjustFrame];

}

-(NSSize)getRepostedWeiboViewSize{

    NSSize size = self.repostedWeiboView.frame.size;
    
    size.height = REPOST_STATUS_PADDING_TOP + self.repostedWeiboUserAlias.frame.size.height + STATUS_TEXT_MARGIN_TOP + self.repostedWeiboContent.intrinsicContentSize.height + REPOST_STATUS_PADDING_BOTTOM;
    
    return size;
    

}


-(NSSize)getStatusViewIntrinsicContentSize{

    NSSize size = self.frame.size;
    NSInteger height = REPOST_STATUS_MARGIN_TOP + [self getRepostedWeiboViewSize].height + STATUS_MARGIN_TOP + self.userAlias.frame.size.height + STATUS_TEXT_MARGIN_TOP + self.weiboTextField.intrinsicContentSize.height + TOOLBAR_MARGIN_TOP + self.toolbar.frame.size.height + TOOLBAR_MARGIN_BOTTOM;
    
    size.height = height;
    
    return size;
    

}

-(void)resizeSubviewsWithOldSize:(NSSize)oldSize{
    [super resizeSubviewsWithOldSize:oldSize];
    
    NSInteger moveHeight = 0;
 
    NSInteger oldStatusViewHeight = self.statusView.frame.size.height;
    [self.statusView setFrameSize:[self getStatusViewIntrinsicContentSize]];
    moveHeight = self.statusView.frame.size.height - oldStatusViewHeight;
    
    [self.statusView setFrameOrigin:NSMakePoint(0, self.bounds.size.height - self.statusView.frame.size.height)];
    

    NSRect oldFrame = self.repostedWeiboView.frame;
    
    [self.repostedWeiboView setFrameSize:[self getRepostedWeiboViewSize]];
    [self.repostedWeiboView setFrameOrigin:NSMakePoint(oldFrame.origin.x,oldFrame.origin.y - (self.repostedWeiboView.frame.size.height - oldFrame.size.height))];
    
    NSInteger oldContentHeight = self.repostedWeiboContent.frame.size.height;
    [self.repostedWeiboContent adjustFrame];
    //[self.repostedWeiboContent setFrameSize:self.repostedWeiboContent.intrinsicContentSize];
    
    NSInteger moveRepostWeiboHeight = self.repostedWeiboContent.frame.size.height - oldContentHeight;
    
    for(NSView *subView in self.repostedWeiboView.subviews){
//        if(subView == self.repostedWeiboContent){
//            continue;
//        }
        NSPoint newOrigin = subView.frame.origin;
        newOrigin.y += moveRepostWeiboHeight;
        [subView setFrameOrigin:newOrigin];
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
    
    
    oldContentHeight = self.weiboTextField.frame.size.height;
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
