//
//  AKUserButton.m
//  BetterWeibo
//
//  Created by Kent on 13-12-10.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKUserButton.h"

@implementation AKUserButton
@synthesize avatarURL = _avatarURL;
@synthesize avatarImage = _avatarImage;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        _defaultAvatarImage = [NSImage imageNamed:@"avatar_default.png"];
        _topLayerImage = [NSImage imageNamed:@"avatar_outline"];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	//[super drawRect:dirtyRect];
    
    NSRect avatarRect = NSMakeRect(6, 6, 36, 36);
    NSImage *avatarLayer = (_avatarImage)?_avatarImage:_defaultAvatarImage;
    
    [avatarLayer drawInRect:avatarRect];
    
    NSRect topLayerRect = NSMakeRect(0, 0, 48, 49);
    [_topLayerImage drawInRect:topLayerRect];
	
    // Drawing code here.
}

-(NSString *)avatarURL{

    return _avatarURL;

}

-(void)setAvatarURL:(NSString *)avatarURL{

    _avatarURL = avatarURL;
    if(avatarURL){
        self.avatarImage = [[NSImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:avatarURL]]];
    }
}

-(NSImage *)avatarImage{

    return _avatarImage;

}


-(void)setAvatarImage:(NSImage *)avatarImage{

    _avatarImage = avatarImage;

}

@end
