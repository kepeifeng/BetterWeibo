//
//  AKImageViewerWindow.m
//  BetterWeibo
//
//  Created by Kent on 14-3-8.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKImageViewerWindow.h"

@implementation AKImageViewerWindow{
    NSPoint initialLocation;
}

@synthesize delegate = _viewerDelegate;

-(void)keyDown:(NSEvent *)theEvent{

    if(self.delegate){
        [self.delegate windowReceivedKeyDown:self keyDown:theEvent];
    }
}

-(BOOL)canBecomeKeyView{
    return YES;
}

-(void)mouseDown:(NSEvent *)theEvent {
    NSRect  windowFrame = [[self window] frame];
    
    initialLocation = [NSEvent mouseLocation];
    
    initialLocation.x -= windowFrame.origin.x;
    initialLocation.y -= windowFrame.origin.y;
}

- (void)mouseDragged:(NSEvent *)theEvent {
    NSPoint currentLocation;
    NSPoint newOrigin;
    
    NSRect  screenFrame = [[NSScreen mainScreen] frame];
    NSRect  windowFrame = [self frame];
    
    currentLocation = [NSEvent mouseLocation];
    newOrigin.x = currentLocation.x - initialLocation.x;
    newOrigin.y = currentLocation.y - initialLocation.y;
    
    // Don't let window get dragged up under the menu bar
    if( (newOrigin.y+windowFrame.size.height) > (screenFrame.origin.y+screenFrame.size.height) ){
        newOrigin.y=screenFrame.origin.y + (screenFrame.size.height-windowFrame.size.height);
    }
    
    //go ahead and move the window to the new location
    [[self window] setFrameOrigin:newOrigin];
}

@end
