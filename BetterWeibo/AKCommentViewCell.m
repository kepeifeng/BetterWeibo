//
//  AKCommentViewCell.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-12-13.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKCommentViewCell.h"

@implementation AKCommentViewCell

@synthesize userAliasField;
@synthesize commentField;

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self.commentField setEditable:NO];
        [self.commentField setDrawsBackground:NO];
        [self.userAvatar setBorderType:AKUserButtonBorderTypeBezel];
    }
    return self;
}

-(id)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    if(self){
        [self.commentField setEditable:NO];
        [self.commentField setDrawsBackground:NO];
        [self.userAvatar setBorderType:AKUserButtonBorderTypeBezel];
    }
    return self;
}

-(void)awakeFromNib{
    [self.commentField setEditable:NO];
    [self.commentField setDrawsBackground:NO];
}
#pragma mark Drawing

- (void)drawRect:(NSRect)dirtyRect
{

	[super drawRect:dirtyRect];
    
    NSRect drawingRect = self.frame;
    
    CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
    
    //Top Line
    NSPoint startPoint = NSMakePoint(0, drawingRect.size.height - 0.5);
    NSPoint endPoint = NSMakePoint(drawingRect.size.width, drawingRect.size.height - 0.5);
    
    CGContextSetLineWidth(myContext, 1);
    CGContextSetRGBStrokeColor(myContext, 1, 1, 1, 0.8);
    CGContextMoveToPoint(myContext, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(myContext, endPoint.x, endPoint.y);
    CGContextStrokePath(myContext);
    
    //Bottom Line
    startPoint = NSMakePoint(0, 0.5);
    endPoint = NSMakePoint(drawingRect.size.width, 0.5);
    
    CGContextSetLineWidth(myContext, 1);
    CGContextSetRGBStrokeColor(myContext, 0.5, 0.5, 0.5, 0.5);
    CGContextMoveToPoint(myContext, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(myContext, endPoint.x, endPoint.y);
    CGContextStrokePath(myContext);
	
}


#pragma mark - Accessibility

- (NSArray*)accessibilityAttributeNames
{
	NSMutableArray*	attribs = [[super accessibilityAttributeNames] mutableCopy];
	
	[attribs addObject: NSAccessibilityRoleAttribute];
	[attribs addObject: NSAccessibilityDescriptionAttribute];
	[attribs addObject: NSAccessibilityTitleAttribute];
	[attribs addObject: NSAccessibilityEnabledAttribute];
	
	return attribs;
}

- (BOOL)accessibilityIsAttributeSettable:(NSString *)attribute
{
	if( [attribute isEqualToString: NSAccessibilityRoleAttribute]
       || [attribute isEqualToString: NSAccessibilityDescriptionAttribute]
       || [attribute isEqualToString: NSAccessibilityTitleAttribute]
       || [attribute isEqualToString: NSAccessibilityEnabledAttribute] )
	{
		return NO;
	}
	else
		return [super accessibilityIsAttributeSettable: attribute];
}

- (id)accessibilityAttributeValue:(NSString*)attribute
{
	if([attribute isEqualToString:NSAccessibilityRoleAttribute])
	{
		return NSAccessibilityButtonRole;
	}
    if([attribute isEqualToString:NSAccessibilityTitleAttribute]){
    
        return [self.userAliasField stringValue];
    
    }
	
    if([attribute isEqualToString:NSAccessibilityDescriptionAttribute])
	{
		return [self.commentField string];
	}
    
	if([attribute isEqualToString:NSAccessibilityEnabledAttribute])
	{
		return [NSNumber numberWithBool:YES];
	}
    
    return [super accessibilityAttributeValue:attribute];
}



- (void)prepareForReuse
{
//	[self.userAliasField setStringValue:@""];
//    [self.commentField setStringValue:@""];
}

-(void)setBackgroundStyle:(NSBackgroundStyle)backgroundStyle{
    [super setBackgroundStyle:NSBackgroundStyleLight];
}

-(void)resizeSubviewsWithOldSize:(NSSize)oldSize{

    [super resizeSubviewsWithOldSize:oldSize];
    
    
    
    NSInteger oldHeight = self.commentField.frame.size.height;
    [self.commentField setFrameSize:NSMakeSize(oldSize.width - 10 - 48 - 10 - 10, self.commentField.frame.size.height)];
    [self.commentField adjustFrame];
    NSInteger newHeight = self.commentField.frame.size.height;
    
    NSInteger y = (self.commentField.frame.size.height <=20 )?16:10;
    
    
    [self.commentField setFrameOrigin:NSMakePoint(10 + 48 + 10, y)];
    y += self.commentField.frame.size.height;
    
    y += 2;
    [self.userAliasField setFrameOrigin:NSMakePoint(self.commentField.frame.origin.x, y)];
    y += self.userAliasField.frame.size.height;
    
    [self.userAvatar setFrameOrigin:NSMakePoint(10, y - self.userAvatar.frame.size.height)];
    
//    NSInteger moveDistance = newHeight - oldHeight;
//    if(moveDistance!=0){
//        for (NSView *subView in self.subviews) {
//            NSPoint origin = subView.frame.origin;
//            origin.y += moveDistance;
//            [subView setFrameOrigin:origin];
//        }
//        
//    }
    
    

}

































@end
