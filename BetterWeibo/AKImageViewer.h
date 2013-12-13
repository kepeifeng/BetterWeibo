//
//  AKImageViewer.h
//  BetterWeibo
//
//  Created by Kent on 13-12-11.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AKImageViewer : NSWindowController{



}

-(id)initWithImage:(NSImage *)image;

-(void)show;
@property NSImage *image;
//@property (strong) IBOutlet NSPanel *window;
@property (weak) IBOutlet NSImageView *imageView;

@end
