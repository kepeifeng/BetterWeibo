//
//  AKStatusTextView.m
//  controlLabs
//
//  Created by Kent on 14-1-12.
//  Copyright (c) 2014年 Kent. All rights reserved.
//

#import "AKStatusTextView.h"

@implementation AKStatusTextView

@dynamic delegate;

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


-(void)doCommandBySelector:(SEL)aSelector{
    [super doCommandBySelector:aSelector];
    [self.delegate textView:self doCommandBySelector:aSelector];
}



-(void)keyDown:(NSEvent *)theEvent{

    [super keyDown:theEvent];
    
    if ([theEvent.charactersIgnoringModifiers isEqualToString:@"@"]) {
        
        if(self.delegate){
        
            NSRect rect = [self firstRectForCharacterRange:[self selectedRange]]; //screen coordinates
            rect.size.width = 1;
            // Convert the NSAdvancedTextView bounds rect to screen coordinates
            NSRect textViewBounds = [self convertRectToBase:[self bounds]];
            textViewBounds.origin = [[self window] convertBaseToScreen:textViewBounds.origin];
            
            rect.origin.x -= textViewBounds.origin.x;
            rect.origin.y -= textViewBounds.origin.y;
            rect.origin.y = textViewBounds.size.height - rect.origin.y - 10; //this 10 is tricky, if without, my control shows a little below the text, which makes it ugly.

            [self.delegate atKeyPressed:self position:rect];
        
            
        }
        
    }
    


}



@end
