//
//  AKWeiboTableCellView.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-30.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKWeiboTableCellView.h"
#import "NS(Attributed)String+Geometrics.h"

//#import "NSString+Size.h"

@implementation AKWeiboTableCellView

@synthesize hasRepostedWeibo = _hasRepostedWeibo;
@synthesize weiboTextField = _weiboTextField;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        //_weiboTextField.autoresizingMask = NSViewMinYMargin
        
//        
//        self.images.autoresizingMask = NSViewMinYMargin;
//        self.userAlias.autoresizingMask = NSViewMinYMargin | NSViewWidthSizable;
//        self.dateDuration.autoresizingMask = NSViewMinYMargin | NSViewMinXMargin;
//        self.weiboTextField.autoresizingMask = NSViewHeightSizable | NSViewWidthSizable;
//        self.toolbar.autoresizingMask = NSViewMinXMargin | NSViewMaxYMargin;
//        self.favMark.autoresizingMask = NSViewMinXMargin | NSViewMinYMargin;
//        
//        self.repostedWeiboContent.autoresizingMask =  NSViewWidthSizable | NSViewHeightSizable ;
//        self.repostedWeiboUserAlias.autoresizingMask = NSViewMaxYMargin;
//        self.repostedWeiboUserAlias.autoresizingMask = NSViewMinXMargin | NSViewMinYMargin;

        
        
        
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
    
    if(self.objectValue.repostedWeibo){
    
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



//
//-(void)viewWillStartLiveResize{
//    
//    
//    NSLog(@"viewWillStartLiveResize");
//
//}
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
    
    if(weibo.repostedWeibo){
        
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
     
        

        
    }
    


    
    [self.weiboView setFrameSize:NSMakeSize(self.weiboView.frame.size.width, weiboViewHeight)];
    
    //update reposted weibo's user alias' origin.
    [self.userAlias setFrameOrigin:NSMakePoint(self.userAlias.frame.origin.x,
                                               weiboViewHeight - 27)];
    
    [self.dateDuration setFrameOrigin:NSMakePoint(self.dateDuration.frame.origin.x, weiboViewHeight - 27)];
    
    [self.userImage setFrameOrigin:NSMakePoint(self.userImage.frame.origin.x, weiboViewHeight - (self.userImage.frame.size.height - self.userAlias.frame.size.height) - 27)];


    [self.weiboTextField setFrameSize:NSMakeSize(self.weiboTextField.frame.size.width, weiboHeight)];
        [self.weiboTextField setFrameOrigin:NSMakePoint(self.weiboTextField.frame.origin.x, weiboViewHeight - 27 - 5 - self.weiboTextField.frame.size.height)];
    


    

    
    //[self setFrameSize:NSMakeSize(self.frame.size.width, cellHeight)];

}



+(CGFloat)caculateWeiboHeight:(AKWeiboStatus *)weibo forWidth:(CGFloat)width{

    CGFloat repostedWeiboHeight;
    CGFloat weiboHeight;
    CGFloat repostedWeiboViewHeigt;
    CGFloat weiboViewHeight;
    
    return [AKWeiboTableCellView caculateWeiboCellHeight:weibo forWidth:width repostedWeiboHeight:&repostedWeiboHeight repostedWeiboViewHeight:&repostedWeiboViewHeigt weiboHeight:&weiboHeight weiboViewHeight:&weiboViewHeight];

}


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
    
    
    if(weibo.repostedWeibo){
        
        _repostedWeiboViewHeight += 20;
        if(weibo.repostedWeibo.images){
            
            _repostedWeiboViewHeight += 10;
            _repostedWeiboViewHeight += (weibo.repostedWeibo.images.count)/3*45;
            
        }
        
        //        [self.repostedWeiboContent setFrameSize:self.repostedWeiboContent.intrinsicContentSize];
        AKTextField *textField = [[AKTextField alloc]initWithFrame:NSMakeRect(0, 0, width - 40, 100)];
        
        
        textField.stringValue = weibo.repostedWeibo.weiboContent;
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
    if(weibo.images){
        _weiboViewHeight += roundf((weibo.images.count / 3))*45 + 10;
    }
    
    //Weibo Content
    
    
    
    //[self.weiboTextField setFrameSize:self.weiboTextField.intrinsicContentSize];
    
    AKTextField *weiboTextField = [[AKTextField alloc]initWithFrame:NSMakeRect(0, 0, width - 84, 100)];
    weiboTextField.stringValue = weibo.weiboContent;
    
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

-(void)loadImages:(NSArray *)imageURL{
    
    if(imageURL){
    
        
    
    }

    else{
    
        [self.images setHidden:YES];

    
    }


}

@end
