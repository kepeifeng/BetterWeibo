//
//  AKCommentViewCell.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-12-13.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKCommentViewCell.h"

@implementation AKCommentViewCell

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (id)initWithReusableIdentifier: (NSString*)identifier
{
	if((self = [super initWithReusableIdentifier:identifier]))
	{
	}
	
	return self;
}

#pragma mark Drawing

- (void)drawRect:(NSRect)dirtyRect
{
	if([self isSelected]) {
		[[NSColor selectedControlColor] set];
	}
	else {
		[[NSColor whiteColor] set];
    }
//    
//    //Draw the border and background
//	NSBezierPath *roundedRect = [NSBezierPath bezierPathWithRoundedRect:[self bounds] xRadius:6.0 yRadius:6.0];
//	[roundedRect fill];
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
	[self.userAliasField setStringValue:@""];
    [self.commentField setStringValue:@""];
}


@end
