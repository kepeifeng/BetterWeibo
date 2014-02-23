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


#pragma mark Drawing

- (void)drawRect:(NSRect)dirtyRect
{

    [super drawRect:dirtyRect];
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
		return [self.commentField stringValue];
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

-(void)resizeSubviewsWithOldSize:(NSSize)oldSize{

    [super resizeSubviewsWithOldSize:oldSize];
    
    
    
    NSInteger oldHeight = self.commentField.frame.size.height;
    [self.commentField setFrameSize:NSMakeSize(oldSize.width - 10 - 42 - 10 - 10, self.commentField.frame.size.height)];
    [self.commentField adjustFrame];
    NSInteger newHeight = self.commentField.frame.size.height;
    
    NSInteger y = (self.commentField.frame.size.height <=20 )?16:10;
    
    [self.commentField setFrameOrigin:NSMakePoint(10 + 42 + 10, y)];
    y += self.commentField.frame.size.height;
    
    y += 5;
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
