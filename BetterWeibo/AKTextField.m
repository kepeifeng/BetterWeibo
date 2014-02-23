//
//  AKTextField.m
//  BetterWeibo
//
//  Created by Kent on 13-10-7.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKTextField.h"
#import "RegexKitLite.h"

@implementation AKTextField

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        self.minimalHeight = 0;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

-(void)adjustFrame{

    NSRect textFieldFrame = self.frame;
    [self setFrameSize:self.intrinsicContentSize];
    [self setFrameOrigin:NSMakePoint(textFieldFrame.origin.x,textFieldFrame.origin.y - (self.frame.size.height - textFieldFrame.size.height))];

}

-(void)setStringValue:(NSString *)aString{

    //[super setStringValue:aString];
    
    NSString *statusString = aString;
	

	// Building up our attributed string
	NSMutableAttributedString *attributedStatusString = [[NSMutableAttributedString alloc] initWithString:statusString];
	
	// Defining our paragraph style for the tweet text. Starting with the shadow to make the text
	// appear inset against the gray background.
	NSShadow *textShadow = [[NSShadow alloc] init];
	[textShadow setShadowColor:[NSColor colorWithDeviceWhite:1 alpha:.8]];
	[textShadow setShadowBlurRadius:0];
	[textShadow setShadowOffset:NSMakeSize(0, -1)];
    
	NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
	[paragraphStyle setMinimumLineHeight:22];
	[paragraphStyle setMaximumLineHeight:22];
	[paragraphStyle setParagraphSpacing:0];
	[paragraphStyle setParagraphSpacingBefore:0];
	[paragraphStyle setTighteningFactorForTruncation:4];
	[paragraphStyle setAlignment:NSNaturalTextAlignment];
	[paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
	
	// Our initial set of attributes that are applied to the full string length
	NSDictionary *fullAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
									[NSColor colorWithDeviceHue:.53 saturation:.13 brightness:.26 alpha:1], NSForegroundColorAttributeName,
									textShadow, NSShadowAttributeName,
									[NSCursor arrowCursor], NSCursorAttributeName,
									[NSNumber numberWithFloat:0.0], NSKernAttributeName,
									[NSNumber numberWithInt:0], NSLigatureAttributeName,
									paragraphStyle, NSParagraphStyleAttributeName,
									[NSFont systemFontOfSize:14.0], NSFontAttributeName, nil];
	[attributedStatusString addAttributes:fullAttributes range:NSMakeRange(0, [statusString length])];
    
    
	// Generate arrays of our interesting items. Links, usernames, hashtags.
	NSArray *linkMatches = [self scanStringForLinks:statusString];
	NSArray *usernameMatches = [self scanStringForUsernames:statusString];
	NSArray *hashtagMatches = [self scanStringForHashtags:statusString];
	
	// Iterate across the string matches from our regular expressions, find the range
	// of each match, add new attributes to that range
	for (NSString *linkMatchedString in linkMatches) {
		NSRange range = [statusString rangeOfString:linkMatchedString];
		if( range.location != NSNotFound ) {
			// Add custom attribute of LinkMatch to indicate where our URLs are found. Could be blue
			// or any other color.
			NSDictionary *linkAttr = [[NSDictionary alloc] initWithObjectsAndKeys:
									  [NSCursor pointingHandCursor], NSCursorAttributeName,
									  [NSColor blueColor], NSForegroundColorAttributeName,
									  [NSFont boldSystemFontOfSize:14.0], NSFontAttributeName,
									  linkMatchedString, @"LinkMatch",
									  nil];
			[attributedStatusString addAttributes:linkAttr range:range];

		}
	}
	
	for (NSString *usernameMatchedString in usernameMatches) {
		NSRange range = [statusString rangeOfString:usernameMatchedString];
		if( range.location != NSNotFound ) {
			// Add custom attribute of UsernameMatch to indicate where our usernames are found
			NSDictionary *linkAttr2 = [[NSDictionary alloc] initWithObjectsAndKeys:
									   [NSColor blackColor], NSForegroundColorAttributeName,
									   [NSCursor pointingHandCursor], NSCursorAttributeName,
									   [NSFont boldSystemFontOfSize:14.0], NSFontAttributeName,
									   usernameMatchedString, @"UsernameMatch",
									   nil];
			[attributedStatusString addAttributes:linkAttr2 range:range];

		}
	}
	
	for (NSString *hashtagMatchedString in hashtagMatches) {
		NSRange range = [statusString rangeOfString:hashtagMatchedString];
		if( range.location != NSNotFound ) {
			// Add custom attribute of HashtagMatch to indicate where our hashtags are found
			NSDictionary *linkAttr3 = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       [NSColor grayColor], NSForegroundColorAttributeName,
                                       [NSCursor pointingHandCursor], NSCursorAttributeName,
                                       [NSFont systemFontOfSize:14.0], NSFontAttributeName,
                                       hashtagMatchedString, @"HashtagMatch",
                                       nil];
			[attributedStatusString addAttributes:linkAttr3 range:range];

		}
	}
    
    [self setAttributedStringValue:attributedStatusString];

}


-(NSSize)intrinsicContentSize
{
    if ( ![self.cell wraps] ) {
        return [super intrinsicContentSize];
        
    }
    
    NSRect frame = [self frame];
    
    CGFloat width = frame.size.width;
    
    // Make the frame very high, while keeping the width
    frame.size.height = CGFLOAT_MAX;
    
    // Calculate new height within the frame
    // with practically infinite height.
    CGFloat height = [self.cell cellSizeForBounds: frame].height;
    
    //NSLog(@"(%f, %f) - %@ \n",width,height,self.stringValue);
//    NSLog(@"\n",);
    
    return NSMakeSize(width, (height<self.minimalHeight)?self.minimalHeight:height);
}


// We're only subclassing NSTextView so we can grab its mouse down event. Everything
// else will be handled like normal
- (void)mouseDown:(NSEvent *)theEvent {
	// Grab a usable NSPoint value for our mousedown event
	NSPoint point = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	
	// Starting in 10.5, NSTextView provides this nifty function to get the index of
	// the character at a specific NSPoint. It automatically takes into account all the
	// custom drawing attributes of our attributed string including line spacing.
	NSInteger charIndex = [self.cell characterIndexForInsertionAtPoint:point];
	
	// If we actually clicked on a text character

	if (NSLocationInRange(charIndex, NSMakeRange(0, [[self stringValue] length])) == YES ) {
		
		// Grab the attributes of our attributed string at this exact index
		NSDictionary *attributes = [[self attributedStringValue] attributesAtIndex:charIndex effectiveRange:NULL];
		
		// Depending on what they clicked we could open a URL or perhaps pop open a profile HUD
		// if they clicked on a username. For now, we'll just throw it out to the log.
		if( [attributes objectForKey:@"LinkMatch"] != nil ) {
			// Remember what object we stashed in this attribute? Oh yeah, it's a URL string. Boo ya!
			NSLog( @"LinkMatch: %@", [attributes objectForKey:@"LinkMatch"] );
		}
		
		if( [attributes objectForKey:@"UsernameMatch"] != nil ) {
			NSLog( @"UsernameMatch: %@", [attributes objectForKey:@"UsernameMatch"] );
		}
		
		if( [attributes objectForKey:@"HashtagMatch"] != nil ) {
			NSLog( @"HashtagMatch: %@", [attributes objectForKey:@"HashtagMatch"] );
		}
		
	}
	
	[super mouseDown:theEvent];
}

#pragma mark - String parsing

// These regular expressions aren't the greatest. There are much better ones out there to parse URLs, @usernames
// and hashtags out of tweets. Getting the escaping just right is a pain in the ass, so be forewarned.

- (NSArray *)scanStringForLinks:(NSString *)string {
	return [string componentsMatchedByRegex:@"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))"];
    
}

- (NSArray *)scanStringForUsernames:(NSString *)string {
	return [string componentsMatchedByRegex:@"@[\u4e00-\u9fa5a-zA-Z0-9_-]{2,30}"];
    //	return [string componentsMatchedByRegex:@"@{1}([-A-Za-z0-9_]{2,})"];
}

- (NSArray *)scanStringForHashtags:(NSString *)string {
	return [string componentsMatchedByRegex:@"#[^#]+#"];
    //    return [string componentsMatchedByRegex:@"[\\s]{1,}#{1}([^\\s]{2,})"];
}



@end
