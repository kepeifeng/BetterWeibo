//
//  AKWeiboTableCellView.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-30.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKWeiboTableCellView.h"
#import "NS(Attributed)String+Geometrics.h"
#import "AKImageViewer.h"
#import "AKViewConstant.h"

@implementation AKWeiboTableCellView{

    NSTrackingArea *trackingArea;
    AKImageViewer *_imageViewer;

}

@synthesize hasRepostedWeibo = _hasRepostedWeibo;
@synthesize weiboTextField = _weiboTextField;
@synthesize status = _status;
@synthesize thumbnailImageURL = _thumbnailImageURL;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
        // Initialization code here.
     
        
        
    }
    return self;
}



- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
    
    if(self.inLiveResize){
    
        
        
               
    
    }

	
    // Drawing code here.
}


-(AKWeiboStatus *)status{

    return _status;
    
}

-(void)setStatus:(AKWeiboStatus *)status{

    _status = status;

    
    

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

-(void)viewDidEndLiveResize{

    [super viewDidEndLiveResize];
   

//    [_weiboTextField siz]
    //[self resize];

}


-(BOOL)hasRepostedWeibo{

    return _hasRepostedWeibo;

}


-(void)setHasRepostedWeibo:(BOOL)hasRepostedWeibo{

    _hasRepostedWeibo = hasRepostedWeibo;
    
    [self.repostedWeiboView setHidden:!hasRepostedWeibo];
    

    //[self resize];

}

-(void)prepareForReuse{

    [super prepareForReuse];
    
    for(NSButtonCell *cell in [self.images cells]){
    
        cell.image = nil;

        
    }
    

}

-(void)resizeSubviewsWithOldSize:(NSSize)oldSize{
    [super resizeSubviewsWithOldSize:oldSize];
    [self resize];
    

}

-(void)resize{
    
    CGFloat repostedWeiboHeight;
    CGFloat weiboHeight;
    CGFloat repostedWeiboViewHeight;
    CGFloat weiboViewHeight;
    
    AKWeiboStatus *weibo = self.objectValue;
    
    assert(weibo);
    CGFloat cellHeight = [AKWeiboTableCellView caculateWeiboCellHeight:weibo forWidth:self.frame.size.width repostedWeiboHeight:&repostedWeiboHeight repostedWeiboViewHeight:&repostedWeiboViewHeight weiboHeight:&weiboHeight weiboViewHeight:&weiboViewHeight];
    
    NSInteger y = weiboViewHeight;
    
    NSInteger repostY = 0;
    NSSize statusViewSize = self.frame.size;
    if(weibo.retweeted_status){
        
        repostY = self.repostedWeiboView.frame.size.height;
        NSSize repostedWeiboViewSize = statusViewSize;
        repostedWeiboViewSize.height = repostedWeiboViewHeight;
        
        [self.repostedWeiboView setFrameSize:repostedWeiboViewSize];
        [self.repostedWeiboView setFrameOrigin:NSMakePoint(0, y)];
        
//        assert(self.repostedWeiboView.frame.size.height == repostedWeiboViewHeight);
    }
    


    
    [self.weiboView setFrameSize:NSMakeSize(self.weiboView.frame.size.width, weiboViewHeight)];
    
    //update reposted weibo's user alias' origin.
    [self.userAlias setFrameOrigin:NSMakePoint(self.userAlias.frame.origin.x,
                                               weiboViewHeight - USER_ALIAS_HEIGHT - STATUS_MARGIN_TOP)];
    
    //Date Duration
    [self.dateDuration setFrameOrigin:NSMakePoint(self.dateDuration.frame.origin.x, weiboViewHeight - USER_ALIAS_HEIGHT - STATUS_MARGIN_TOP)];
    
    //User Avatar
    [self.userImage setFrameOrigin:NSMakePoint(self.userImage.frame.origin.x, weiboViewHeight - (self.userImage.frame.size.height - self.userAlias.frame.size.height) - USER_ALIAS_HEIGHT - STATUS_MARGIN_TOP)];

    //Weibo Text
    [self.weiboTextField setFrameSize:NSMakeSize(self.weiboTextField.frame.size.width, weiboHeight)];
//    [self.weiboTextField adjustFrame];
    [self.weiboTextField setFrameSize:self.weiboTextField.intrinsicContentSize];
    [self.weiboTextField setFrameOrigin:NSMakePoint(self.weiboTextField.frame.origin.x, weiboViewHeight - USER_ALIAS_HEIGHT - STATUS_MARGIN_TOP - STATUS_TEXT_MARGIN_TOP - self.weiboTextField.frame.size.height)];
    

    //Images
    if(weibo.pic_urls && weibo.pic_urls.count>0){
        
        NSSize weiboImageMatrixSize;
        if(weibo.pic_urls.count ==1){
            
            weiboImageMatrixSize = NSMakeSize(LARGE_THUMBNAIL_SIZE, LARGE_THUMBNAIL_SIZE);
            
        }
        else{
            
            weiboImageMatrixSize = NSMakeSize(self.images.numberOfColumns * (SMALL_THUMBNAIL_SIZE+SMALL_THUMBNAIL_SPACING)-SMALL_THUMBNAIL_SPACING,
                                              ((NSInteger)((weibo.pic_urls.count+2)/3)) * (SMALL_THUMBNAIL_SIZE+SMALL_THUMBNAIL_SPACING)-SMALL_THUMBNAIL_SPACING);
            
        }
        
        
        [self.images setFrameSize:weiboImageMatrixSize];
        [self.images setFrameOrigin:NSMakePoint(60, 10)];
    }
    
    //Favorite Mark
    NSPoint favoriteMarkOrigin = NSMakePoint(self.weiboView.frame.size.width - self.favMark.frame.size.width, weiboViewHeight - self.favMark.frame.size.height);;
    if(weibo.retweeted_status){
    
        favoriteMarkOrigin.y += 10;
    
    }
    [self.favMark setFrameOrigin:favoriteMarkOrigin];
    
    

    
    //[self setFrameSize:NSMakeSize(self.frame.size.width, cellHeight)];

}



+(CGFloat)caculateWeiboHeight:(AKWeiboStatus *)weibo forWidth:(CGFloat)width{

    CGFloat repostedWeiboHeight;
    CGFloat weiboHeight;
    CGFloat repostedWeiboViewHeigt;
    CGFloat weiboViewHeight;
    
    return [AKWeiboTableCellView caculateWeiboCellHeight:weibo forWidth:width repostedWeiboHeight:&repostedWeiboHeight repostedWeiboViewHeight:&repostedWeiboViewHeigt weiboHeight:&weiboHeight weiboViewHeight:&weiboViewHeight];

}

/**
 *  计算微博Cell的尺寸
 *
 *  @param weibo                   微博
 *  @param width                   表格宽度
 *  @param repostedWeiboHeight     转发微博微博文本的高度
 *  @param repostedWeiboViewHeight 转发微博框的高度
 *  @param weiboHeight             微博文本的高度
 *  @param weiboViewHeight         微博框的高度
 *
 *  @return Cell的高度
 */
+(CGFloat)caculateWeiboCellHeight:(AKWeiboStatus *)weibo
                         forWidth:(CGFloat)width
              repostedWeiboHeight:(CGFloat *)repostedWeiboHeight
          repostedWeiboViewHeight:(CGFloat *)repostedWeiboViewHeight
                      weiboHeight:(CGFloat *)weiboHeight
                  weiboViewHeight:(CGFloat *)weiboViewHeight
{
    
    
    float cellHeight = 0;
    float _repostedWeiboViewHeight = 0;
    float _weiboViewHeight = 0;
    
    
    if(weibo.retweeted_status){
        
        _repostedWeiboViewHeight += REPOST_STATUS_PADDING_BOTTOM;
        if(weibo.retweeted_status.pic_urls && weibo.retweeted_status.pic_urls.count>0){
            
//            _repostedWeiboViewHeight += 10;
            
            if(weibo.retweeted_status.pic_urls.count==1){

                _repostedWeiboViewHeight += LARGE_THUMBNAIL_SIZE;
            }
            else{
            
                NSInteger numberOfRow = weibo.retweeted_status.pic_urls.count/3;
                if (weibo.retweeted_status.pic_urls.count%3>0) {
                    numberOfRow ++;
                }
                //(numberOfRow - 1)*5是算上每行之间的间距
                _repostedWeiboViewHeight += numberOfRow * SMALL_THUMBNAIL_SIZE + (numberOfRow - 1)*SMALL_THUMBNAIL_SPACING;
                
            }
            
            _repostedWeiboViewHeight += IMAGE_MARGIN_TOP;
        }
        
        //        [self.repostedWeiboContent setFrameSize:self.repostedWeiboContent.intrinsicContentSize];
        AKTextField *textField = [[AKTextField alloc]initWithFrame:NSMakeRect(0, 0, width - REPOST_STATUS_PADDING_LEFT - REPOST_STATUS_PADDING_RIGHT, 1000)];
        
        assert(weibo.retweeted_status.text);
        
        textField.stringValue = weibo.retweeted_status.text;
        *repostedWeiboHeight = textField.intrinsicContentSize.height;
        
        _repostedWeiboViewHeight += *repostedWeiboHeight;
        _repostedWeiboViewHeight += STATUS_TEXT_MARGIN_TOP;
        //UserAlias
        _repostedWeiboViewHeight += USER_ALIAS_HEIGHT;
        _repostedWeiboViewHeight += REPOST_STATUS_PADDING_TOP;
//        _repostedWeiboViewHeight += REPOST_STATUS_MARGIN_TOP;
        
        
//        if(*repostedWeiboHeight > USER_AVATAR_SIZE - 17 - STATUS_TEXT_MARGIN_TOP){
//        
//            _repostedWeiboViewHeight += *repostedWeiboHeight;
//            _repostedWeiboViewHeight += STATUS_TEXT_MARGIN_TOP;
//            _repostedWeiboViewHeight += 17;
//            
//        }
//        else{
//        
//            _repostedWeiboViewHeight += USER_AVATAR_SIZE;
//        
//        }
        
        
        
//        _repostedWeiboViewHeight += 10;

        
    }
    
    *repostedWeiboViewHeight = _repostedWeiboViewHeight;
    
    
    //Bottom Space
    _weiboViewHeight += STATUS_PADDING_BOTTOM;
    
    //Image Matrix
    if(weibo.pic_urls && weibo.pic_urls.count>0){
        
        if(weibo.pic_urls.count == 1){
        
            _weiboViewHeight += LARGE_THUMBNAIL_SIZE;
        }
        else{

            NSInteger numberOfRow = weibo.pic_urls.count/3;
            if (weibo.pic_urls.count%3>0) {
                numberOfRow ++;
            }
            
            _weiboViewHeight += numberOfRow*SMALL_THUMBNAIL_SIZE + (numberOfRow - 1)*SMALL_THUMBNAIL_SPACING ;
        
        }
        
        _weiboViewHeight += IMAGE_MARGIN_TOP;
    }
    
    //Weibo Content
    
    
    
    //[self.weiboTextField setFrameSize:self.weiboTextField.intrinsicContentSize];
    
    AKTextField *weiboTextField = [[AKTextField alloc]initWithFrame:NSMakeRect(0, 0, width - USER_AVATAR_MARGIN_LEFT - USER_AVATAR_SIZE - USER_AVATAR_MARGIN_RIGHT -STATUS_MARGIN_RIGHT, 1000)];
    assert(weibo.text);
    weiboTextField.stringValue = weibo.text;
    
    *weiboHeight = weiboTextField.intrinsicContentSize.height;
    
//    _weiboViewHeight += *weiboHeight;
//    _weiboViewHeight += 5;
    
    
        if(*weiboHeight > USER_AVATAR_SIZE - USER_ALIAS_HEIGHT - STATUS_TEXT_MARGIN_TOP){

            _weiboViewHeight += *weiboHeight;
            _weiboViewHeight += STATUS_TEXT_MARGIN_TOP;
            _weiboViewHeight += USER_ALIAS_HEIGHT;

        }
        else{

            _weiboViewHeight += USER_AVATAR_SIZE;
        
        }

    
    //Top Space
    _weiboViewHeight += STATUS_MARGIN_TOP;
    
    //    [self.weiboView setFrameSize:NSMakeSize(self.weiboView.frame.size.width, _weiboViewHeight)];
    //    [self.repostedWeiboView setFrameOrigin:NSMakePoint(0, _weiboViewHeight)];
    //
    
    *weiboViewHeight = _weiboViewHeight;
    
    cellHeight = _repostedWeiboViewHeight + _weiboViewHeight + 2;
    //[self setFrameSize:NSMakeSize(self.frame.size.width, cellHeight)];
    
    return cellHeight;

}





-(void)mouseEntered:(NSEvent *)theEvent{

    [self.toolbar setHidden:NO];

    
}

-(void)mouseExited:(NSEvent *)theEvent{

    [self.toolbar setHidden:YES];

}

- (void)updateTrackingAreas {
    
    if(trackingArea != nil) {
        [self removeTrackingArea:trackingArea];
    }
    
    int opts = (NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways);
    trackingArea = [ [NSTrackingArea alloc] initWithRect:[self bounds]
                                                 options:opts
                                                   owner:self
                                                userInfo:nil];
    [self addTrackingArea:trackingArea];
    
}

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
        //[imageMatrix addRow];
        for(NSDictionary *url in imageURL){
            
            NSImage *image = [[NSImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[url objectForKey:@"thumbnail_pic"]]]];
            

            NSButtonCell *imageCell = [imageMatrix cellAtRow:(NSInteger)(i/3) column:(i%3)];
            imageCell.tag = i;
            imageCell.image = image;
//            if(i==1 || i==2){
//                //i==1 2的时候，各自添加一列。
//                [imageMatrix addColumn];
//            }
//            else if (i==3 || i == 6){
//                //i==3的时候添加第二行
//                //i==6的时候添加第三行
//                [imageMatrix addRow];
//            }
            
            //[imageMatrix putCell:imageCell atRow:(NSInteger)(i/3) column:(i%3)];

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

-(void)imageCellClicked:(id)sender{

    //NSLog(@"imageCellClicked");
    NSMatrix *imageMatrix = sender;
    NSCell *selectedCell = imageMatrix.selectedCell;
    AKWeiboStatus *status = self.objectValue;
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
