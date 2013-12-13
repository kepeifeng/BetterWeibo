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

//#import "NSString+Size.h"

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
    
    NSImage *repostedWeiboViewBackground = [NSImage imageNamed:@"repost-background-frame"];
    
    //NSLog(@"(%f, %f, %f, %f", repostedWeiboDrawingRect.origin.x, repostedWeiboDrawingRect.origin.y
    //      , repostedWeiboDrawingRect.size.width, repostedWeiboDrawingRect.size.height);
    
    //Top
    
    [self resize];
    
    if(self.objectValue.retweeted_status){
    
        NSRect repostedWeiboDrawingRect =self.repostedWeiboView.frame;
        
        //Top
        [repostedWeiboViewBackground drawInRect:NSMakeRect(0, repostedWeiboDrawingRect.origin.y + repostedWeiboDrawingRect.size.height - 8, repostedWeiboDrawingRect.size.width, 8) fromRect:NSMakeRect(0, 49, 81, 8) operation:NSCompositeSourceOver fraction:1];
        //Middle Part
        [repostedWeiboViewBackground drawInRect:NSMakeRect(0, repostedWeiboDrawingRect.origin.y + 14, repostedWeiboDrawingRect.size.width, repostedWeiboDrawingRect.size.height - 8 - 14) fromRect:NSMakeRect(0, 14, 81, 34) operation:NSCompositeSourceOver fraction:1];
        //Bottom Part - Arrow
        [repostedWeiboViewBackground drawInRect:NSMakeRect(0, repostedWeiboDrawingRect.origin.y, 50, 14) fromRect:NSMakeRect(0, 0, 50, 14) operation:NSCompositeSourceOver fraction:1];
        //Bottom Right Part
        [repostedWeiboViewBackground drawInRect:NSMakeRect(50, repostedWeiboDrawingRect.origin.y, repostedWeiboDrawingRect.size.width - 50, 14) fromRect:NSMakeRect(50, 0, 31, 14) operation:NSCompositeSourceOver fraction:1];
        
    }
    
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


-(void)resize{
    
    CGFloat repostedWeiboHeight;
    CGFloat weiboHeight;
    CGFloat repostedWeiboViewHeight;
    CGFloat weiboViewHeight;
    
    AKWeiboStatus *weibo = self.objectValue;
    
    
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
    


    
    [self.weiboView setFrameSize:NSMakeSize(self.weiboView.frame.size.width, weiboViewHeight)];
    
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
        
        _repostedWeiboViewHeight += 20;
        if(weibo.retweeted_status.pic_urls && weibo.retweeted_status.pic_urls.count>0){
            
            _repostedWeiboViewHeight += 10;
            
            if(weibo.retweeted_status.pic_urls.count==1){

                _repostedWeiboViewHeight += 90;
            }
            else{
            
                NSInteger numberOfRow = weibo.retweeted_status.pic_urls.count/3;
                if (weibo.retweeted_status.pic_urls.count%3>0) {
                    numberOfRow ++;
                }
                //(numberOfRow - 1)*5是算上每行之间的间距
                _repostedWeiboViewHeight += numberOfRow * 45 + (numberOfRow - 1)*5;
                
            }
        }
        
        //        [self.repostedWeiboContent setFrameSize:self.repostedWeiboContent.intrinsicContentSize];
        AKTextField *textField = [[AKTextField alloc]initWithFrame:NSMakeRect(0, 0, width - 40, 1000)];
        
        
        textField.stringValue = weibo.retweeted_status.text;
        *repostedWeiboHeight = textField.intrinsicContentSize.height;
        
        
        
        _repostedWeiboViewHeight += 10;
        _repostedWeiboViewHeight += *repostedWeiboHeight;
        _repostedWeiboViewHeight += 5;
        
        
        //UserAlias
        _repostedWeiboViewHeight += 17;
        _repostedWeiboViewHeight += 10;
        
    }
    
    *repostedWeiboViewHeight = _repostedWeiboViewHeight;
    
    
    //Bottom Space
    _weiboViewHeight += 20;
    
    //Image Matrix
    if(weibo.pic_urls && weibo.pic_urls.count>0){
        
        if(weibo.pic_urls.count == 1){
        
            _weiboViewHeight += 90 + 10;
        }
        else{

            NSInteger numberOfRow = weibo.pic_urls.count/3;
            if (weibo.pic_urls.count%3>0) {
                numberOfRow ++;
            }
            
            _weiboViewHeight += numberOfRow*45 + (numberOfRow - 1)*5 +  10;
        
        }
    }
    
    //Weibo Content
    
    
    
    //[self.weiboTextField setFrameSize:self.weiboTextField.intrinsicContentSize];
    
    AKTextField *weiboTextField = [[AKTextField alloc]initWithFrame:NSMakeRect(0, 0, width - 84, 1000)];
    weiboTextField.stringValue = weibo.text;
    
    *weiboHeight = weiboTextField.intrinsicContentSize.height;
    
    _weiboViewHeight += *weiboHeight;
    _weiboViewHeight += 5;
    
    //User Alias
    
    _weiboViewHeight += 17;
    //_weiboViewHeight += 10;
    
    //Top Space
    _weiboViewHeight += 10;
    
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

@end
