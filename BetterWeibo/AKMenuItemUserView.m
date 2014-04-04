//
//  AKMenuItemUserView.m
//  Wukong
//
//  Created by Kent on 14-4-1.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKMenuItemUserView.h"
#import "AKView.h"

@implementation AKMenuItemUserView{
    NSImage *_backgroundImage;
    
    NSTextField *_titleField;
    NSImageView *_imageView;
    
    
}

//@synthesize title = _title;
@synthesize image = _image;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        
        
        
        NSSize titleFieldSize = NSMakeSize(90, 20);
        _titleField = [[NSTextField alloc] initWithFrame:NSMakeRect(10,
                                                                    (NSInteger)((frame.size.height-titleFieldSize.height)/2), 90, 20)];
        [_titleField setEditable:NO];
        [_titleField setBordered:NO];
        [_titleField setDrawsBackground:NO];
        [_titleField setFont:[NSFont boldSystemFontOfSize:14.0]];
        
        [self addSubview:_titleField];
        
        NSSize imageViewSize = NSMakeSize(30, 30);
        _imageView = [[NSImageView alloc] initWithFrame:NSMakeRect(frame.size.width - imageViewSize.width - 10,
                                                                   (NSInteger)((frame.size.height - imageViewSize.height)/2),
                                                                   imageViewSize.width,
                                                                   imageViewSize.height)];
        
        [_imageView setImageFrameStyle:NSImageFrameGroove];
//        [_imageView.cell setBordered:YES];
//        [_imageView.cell setBorderType:NSGrooveBorder];
        
        [self addSubview:_imageView];

        
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
//    if(!_backgroundImage)
//        _backgroundImage = [NSImage imageNamed:@"status_item_header_background"];
//    
////    [_backgroundImage drawInRect:self.bounds];
//    [_backgroundImage drawInRect:self.bounds fromRect:NSMakeRect(0, 0, _backgroundImage.size.width, _backgroundImage.size.height) operation:NSCompositeCopy fraction:1];
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}


-(void)setTitle:(NSString *)title{
    _titleField.stringValue = title;
}
-(NSString *)title{
    return _titleField.stringValue;
}

-(void)setImage:(NSImage *)image{
    _imageView.image = image;
}

-(NSImage *)image{
    return _imageView.image;
}


@end
