//
//  AKWeiboTableCellView.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-30.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKWeiboTableCellView.h"
#import "NS(Attributed)String+Geometrics.h"

@implementation AKWeiboTableCellView

@synthesize hasRepostedWeibo = _hasRepostedWeibo;
@synthesize weiboTextField = _weiboTextField;

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
	
    // Drawing code here.
}


-(BOOL)hasRepostedWeibo{

    return _hasRepostedWeibo;

}


-(void)setHasRepostedWeibo:(BOOL)hasRepostedWeibo{

    _hasRepostedWeibo = hasRepostedWeibo;
    
    [self.repostedWeiboView setHidden:!hasRepostedWeibo];
    
    if(hasRepostedWeibo){
        
    
    
    }else{
    
        [self.repostedWeiboView setFrameSize:NSMakeSize(self.repostedWeiboView.frame.size.width , 0)];
        [self display];
    
    }

}


-(void)resize{
    
    //NSLog(@"(%f,%f)",self.weiboTextField.intrinsicContentSize.width, self.weiboTextField.intrinsicContentSize.height);
    
    float height = [_weiboTextField.stringValue heightForWidth:_weiboTextField.frame.size.width font:_weiboTextField.font];
    
    NSLog(@"%f",height);
    
    [_weiboTextField setFrameSize:NSMakeSize(self.weiboTextField.frame.size.width, height)];
    [_weiboTextField setNeedsDisplay:YES];

    NSLog(@"%f",_weiboTextField.frame.size.height);

}

@end
