//
//  AKTextField.m
//  BetterWeibo
//
//  Created by Kent on 13-10-7.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKTextField.h"

@implementation AKTextField

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        self.minimalHeight = 0;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

-(void)adjustFrame{

    NSRect textFieldFrame = self.frame;
    [self setFrameSize:self.intrinsicContentSize];
    [self setFrameOrigin:NSMakePoint(textFieldFrame.origin.x,textFieldFrame.origin.y - (self.frame.size.height - textFieldFrame.size.height))];

}


-(NSSize)intrinsicContentSize
{
    if ( ![self.cell wraps] ) {
        return [super intrinsicContentSize];
    }
    
    NSRect frame = [self frame];
    
    CGFloat width = frame.size.width;
    
    // Make the frame very high, while keeping the width
    frame.size.height = CGFLOAT_MAX;
    
    // Calculate new height within the frame
    // with practically infinite height.
    CGFloat height = [self.cell cellSizeForBounds: frame].height;
    
    //NSLog(@"(%f, %f) - %@ \n",width,height,self.stringValue);
//    NSLog(@"\n",);
    
    return NSMakeSize(width, (height<self.minimalHeight)?self.minimalHeight:height);
}

@end
