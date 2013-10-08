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
        _weiboTextField.autoresizingMask = NSViewMinYMargin | NSViewHeightSizable | NSViewWidthSizable;
        //self.repostedWeiboContent.autoresizingMask =  NSViewWidthSizable | NSViewHeightSizable ;
        //self.repostedWeiboUserAlias.autoresizingMask = NSViewMaxYMargin;
        
        
        
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
    
    if(self.inLiveResize){
    
        
        
               
    
    }
    [self resize];
	
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
    NSLog(@"viewDidEndLiveResize");

//    [_weiboTextField siz]
    [self resize];

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
    
    //return;
    /*
    float cellHeight = 0;
    float repostedWeiboViewHeight = 0;
    float weiboViewHeight = 0;
    
    
    AKWeibo *weibo = self.objectValue;
    if(weibo.repostedWeibo){
    
        if(weibo.repostedWeibo.images){
        
            repostedWeiboViewHeight += 10;
            repostedWeiboViewHeight += (weibo.repostedWeibo.images.count)/3*45;
            
        }
        
        
        [self.repostedWeiboContent setFrameSize:self.repostedWeiboContent.intrinsicContentSize];
        
        
        repostedWeiboViewHeight += 10;
        repostedWeiboViewHeight += self.repostedWeiboContent.frame.size.height;
        repostedWeiboViewHeight += 10;
        
        
        if(self.repostedWeiboUserAlias.frame.origin.y != repostedWeiboViewHeight){

            //update reposted weibo's user alias' origin.
            [self.repostedWeiboUserAlias setFrameOrigin:NSMakePoint(self.repostedWeiboUserAlias.frame.origin.x,
                                                                    repostedWeiboViewHeight)];
            [self.repostedWeiboDateDuration setFrameOrigin:NSMakePoint(self.repostedWeiboDateDuration.frame.origin.x,
                                                                       repostedWeiboViewHeight)];
        
        }
        
        repostedWeiboViewHeight += self.repostedWeiboUserAlias.frame.size.height;
        repostedWeiboViewHeight += 10;
        

    
    }
    
    [self.repostedWeiboView setFrameSize:NSMakeSize(self.repostedWeiboView.frame.size.width, repostedWeiboViewHeight)];
    
    //Bottom Space
    weiboViewHeight += 20;
    
    //Image Matrix
    if(!self.images.isHidden){
        weiboViewHeight += self.images.frame.size.height + 10;
    }

    //Weibo Content
    
    [self.weiboTextField setFrameSize:self.weiboTextField.intrinsicContentSize];

    
    weiboViewHeight += self.weiboTextField.frame.size.height;
    weiboViewHeight += 10;
    
    //User Alias
    
    if(self.userAlias.frame.origin.y != weiboViewHeight){
        
        //update reposted weibo's user alias' origin.
        [self.userAlias setFrameOrigin:NSMakePoint(self.userAlias.frame.origin.x,
                                                   weiboViewHeight)];
        
        [self.dateDuration setFrameOrigin:NSMakePoint(self.dateDuration.frame.origin.x, weiboViewHeight)];
        
        [self.userImage setFrameOrigin:NSMakePoint(self.userImage.frame.origin.x, weiboViewHeight - (self.userImage.frame.size.height - self.userAlias.frame.size.height))];
        
    }
    
    weiboViewHeight += self.userAlias.frame.size.height;
    weiboViewHeight += 10;
    
    //Top Space
    weiboViewHeight += 10;
    
    [self.weiboView setFrameSize:NSMakeSize(self.weiboView.frame.size.width, weiboViewHeight)];
    [self.repostedWeiboView setFrameOrigin:NSMakePoint(0, weiboViewHeight)];
    
    
    cellHeight = repostedWeiboViewHeight + weiboViewHeight + 2;
    //[self setFrameSize:NSMakeSize(self.frame.size.width, cellHeight)];
    */
    
    CGFloat repostedWeiboHeight;
    CGFloat weiboHeight;
    CGFloat repostedWeiboViewHeight;
    CGFloat weiboViewHeight;
    
    AKWeibo *weibo = self.objectValue;
    
    
    CGFloat cellHeight = [AKWeiboTableCellView caculateWeiboCellHeight:weibo forWidth:self.frame.size.width repostedWeiboHeight:&repostedWeiboHeight repostedWeiboViewHeight:&repostedWeiboViewHeight weiboHeight:&weiboHeight weiboViewHeight:&weiboViewHeight];
    
    if(weibo.repostedWeibo){
        
        
        //[self.repostedWeiboContent setFrameSize:self.repostedWeiboContent.intrinsicContentSize];

        [self.repostedWeiboContent setFrameSize:NSMakeSize(self.repostedWeiboContent.frame.size.width, repostedWeiboHeight)];
        
        if(self.repostedWeiboUserAlias.frame.origin.y != repostedWeiboViewHeight){
            
            //update reposted weibo's user alias' origin.
            [self.repostedWeiboUserAlias setFrameOrigin:NSMakePoint(self.repostedWeiboUserAlias.frame.origin.x,
                                                                    repostedWeiboViewHeight - 27)];
            [self.repostedWeiboDateDuration setFrameOrigin:NSMakePoint(self.repostedWeiboDateDuration.frame.origin.x,
                                                                       repostedWeiboViewHeight -27)];
            
        }
        
        
    }
    
    [self.repostedWeiboView setFrameSize:NSMakeSize(self.repostedWeiboView.frame.size.width, repostedWeiboViewHeight)];
    
    

    
    [self.weiboView setFrameSize:NSMakeSize(self.weiboView.frame.size.width, weiboViewHeight)];
    
    //update reposted weibo's user alias' origin.
    [self.userAlias setFrameOrigin:NSMakePoint(self.userAlias.frame.origin.x,
                                               weiboViewHeight - 27)];
    
    [self.dateDuration setFrameOrigin:NSMakePoint(self.dateDuration.frame.origin.x, weiboViewHeight - 27)];
    
    [self.userImage setFrameOrigin:NSMakePoint(self.userImage.frame.origin.x, weiboViewHeight - (self.userImage.frame.size.height - self.userAlias.frame.size.height) - 27)];

        [self.weiboTextField setFrameOrigin:NSMakePoint(self.weiboTextField.frame.origin.x, weiboViewHeight - 27 - 5 - self.weiboTextField.frame.size.height)];
        
    


    
    [self.repostedWeiboView setFrameOrigin:NSMakePoint(0, weiboViewHeight)];
    
    
    [self setFrameSize:NSMakeSize(self.frame.size.width, cellHeight)];

}



+(CGFloat)caculateWeiboHeight:(AKWeibo *)weibo forWidth:(CGFloat)width{

    CGFloat repostedWeiboHeight;
    CGFloat weiboHeight;
    CGFloat repostedWeiboViewHeigt;
    CGFloat weiboViewHeight;
    
    return [AKWeiboTableCellView caculateWeiboCellHeight:weibo forWidth:width repostedWeiboHeight:&repostedWeiboHeight repostedWeiboViewHeight:&repostedWeiboViewHeigt weiboHeight:&weiboHeight weiboViewHeight:&weiboViewHeight];

}


+(CGFloat)caculateWeiboCellHeight:(AKWeibo *)weibo
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
