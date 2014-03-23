//
//  AKButton.m
//  controlLabs
//
//  Created by Kent on 14-2-25.
//  Copyright (c) 2014年 Kent. All rights reserved.
//

#import "AKButton.h"


@implementation AKButton

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        [self setButtonType:NSMomentaryChangeButton];
        [self setBezelStyle:NSRegularSquareBezelStyle];
        [self setFocusRingType:NSFocusRingTypeNone];
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if(self){
    
        NSString *title = self.title;
        [self setCell:[AKButtonCell new]];
        self.title = title;
        [self setButtonType:NSMomentaryChangeButton];
        [self setBezelStyle:NSRegularSquareBezelStyle];
        [self setFocusRingType:NSFocusRingTypeNone];
    
    }
    return self;

}

-(void)setEnabled:(BOOL)flag{

    [super setEnabled:flag];
    [self setAlphaValue:(flag)?1:0.5];

}

-(AKButtonStyle)buttonStyle{

    return [(AKButtonCell *)self.cell buttonCellStyle];
}

-(void)setButtonStyle:(AKButtonStyle)buttonStyle{

    [(AKButtonCell *)self.cell setButtonCellStyle:buttonStyle];
    
}


- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

+(Class)cellClass{

    return [AKButtonCell class];

}

@end
