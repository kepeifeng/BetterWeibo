//
//  AKImageViewer.m
//  BetterWeibo
//
//  Created by Kent on 13-12-11.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKImageViewer.h"

@interface AKImageViewer ()

@end

@implementation AKImageViewer
@synthesize image = _image;


-(id)initWithImage:(NSImage *)image{

    self = [super initWithWindowNibName:@"AKImageViewer" owner:self];
    if (self) {
        [self.window orderOut:nil];
        self.image = image;

        // Initialization code here.
    }
    return self;

}


-(void)show{
    
    [self showWindow:self];
//    [self.window makeKeyAndOrderFront:nil];
}

-(NSImage *)image{
    return _image;
}

-(void)setImage:(NSImage *)image{
    _image =image;
    self.imageView.image = image;
}


@end
