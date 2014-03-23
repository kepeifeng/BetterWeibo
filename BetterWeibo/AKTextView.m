//
//  AKTextField.m
//  BetterWeibo
//
//  Created by Kent on 13-10-7.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKTextView.h"
#import "RegexKitLite.h"
#import "AKEmotion.h"

#define DEFAULT_FONT_SIZE 13.0

@implementation AKTextView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        self.minimalHeight = 0;
        self.textContainerInset = NSMakeSize(0, 0);
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.textContainerInset = NSMakeSize(0, 0);
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
	[paragraphStyle setMinimumLineHeight:18];
	[paragraphStyle setMaximumLineHeight:18];
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
									[NSFont systemFontOfSize:DEFAULT_FONT_SIZE], NSFontAttributeName, nil];
	[attributedStatusString addAttributes:fullAttributes range:NSMakeRange(0, [statusString length])];
    
    
	// Generate arrays of our interesting items. Links, usernames, hashtags.
	NSArray *linkMatches = [self scanStringForLinks:statusString];
	NSArray *usernameMatches = [self scanStringForUsernames:statusString];
	NSArray *hashtagMatches = [self scanStringForHashtags:statusString];
    NSArray *emotions = [self scanStringForEmotions:statusString];
	
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
									  [NSFont boldSystemFontOfSize:DEFAULT_FONT_SIZE], NSFontAttributeName,
									  linkMatchedString, @"LinkMatch",
									  nil];
			[attributedStatusString addAttributes:linkAttr range:range];

		}
	}
	
	for (NSString *usernameMatchedString in usernameMatches) {
        
        NSUInteger count = 0, length = [statusString length];
        NSRange range = NSMakeRange(0, length);
        while(range.location != NSNotFound)
        {
            range = [statusString rangeOfString: usernameMatchedString options:0 range:range];
            if(range.location != NSNotFound)
            {

                // Add custom attribute of UsernameMatch to indicate where our usernames are found
                NSDictionary *linkAttr2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                                           [NSColor blackColor], NSForegroundColorAttributeName,
                                           [NSCursor pointingHandCursor], NSCursorAttributeName,
                                           [NSFont boldSystemFontOfSize:DEFAULT_FONT_SIZE], NSFontAttributeName,
                                           usernameMatchedString, @"UsernameMatch",
                                           nil];
                [attributedStatusString addAttributes:linkAttr2 range:range];
                
                
                range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
                count++; 
            }
        }

	}
	
	for (NSString *hashtagMatchedString in hashtagMatches) {
		NSRange range = [statusString rangeOfString:hashtagMatchedString];
		if( range.location != NSNotFound ) {
			// Add custom attribute of HashtagMatch to indicate where our hashtags are found
			NSDictionary *linkAttr3 = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       [NSColor grayColor], NSForegroundColorAttributeName,
                                       [NSCursor pointingHandCursor], NSCursorAttributeName,
                                       [NSFont systemFontOfSize:DEFAULT_FONT_SIZE], NSFontAttributeName,
                                       hashtagMatchedString, @"HashtagMatch",
                                       nil];
			[attributedStatusString addAttributes:linkAttr3 range:range];

		}
	}
    
    for (NSString *emotionCode in emotions) {
        
        AKEmotion *emotion;
        if(!( emotion = [[AKEmotion emotionDictionary]objectForKey:emotionCode])){
        
            continue;
        }
        
		NSUInteger length = [statusString length];
        NSRange range = NSMakeRange(0, length);

        //assert(range.length+range.location<=statusString.length);
        range = [statusString rangeOfString: emotionCode options:0 range:range];
        if( range.location != NSNotFound ) {
            // Add custom attribute of HashtagMatch to indicate where our hashtags are found
            NSTextAttachmentCell *textAttachmentCell = [[NSTextAttachmentCell alloc] initImageCell:emotion.image];
            NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
            [textAttachment setAttachmentCell:textAttachmentCell];
            NSAttributedString *emotionIconString = [NSAttributedString attributedStringWithAttachment:textAttachment];

            assert(range.length+range.location<=attributedStatusString.length);
            [attributedStatusString replaceCharactersInRange:NSMakeRange(range.location, range.length) withAttributedString:emotionIconString];

            statusString = attributedStatusString.string;
        }

	}
    
    [self.textStorage setAttributedString:attributedStatusString];

}


-(NSSize)intrinsicContentSize
{
    
    NSTextContainer* textContainer = [self textContainer];
    NSLayoutManager* layoutManager = [self layoutManager];
    [layoutManager ensureLayoutForTextContainer: textContainer];
    return [layoutManager usedRectForTextContainer: textContainer].size;
    
    //return NSMakeSize(width, (height<self.minimalHeight)?self.minimalHeight:height);
}


// We're only subclassing NSTextView so we can grab its mouse down event. Everything
// else will be handled like normal
- (void)mouseDown:(NSEvent *)theEvent {
	// Grab a usable NSPoint value for our mousedown event
	NSPoint point = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	
	// Starting in 10.5, NSTextView provides this nifty function to get the index of
	// the character at a specific NSPoint. It automatically takes into account all the
	// custom drawing attributes of our attributed string including line spacing.
	NSInteger charIndex = [self characterIndexForInsertionAtPoint:point];
	
	// If we actually clicked on a text character

	if (NSLocationInRange(charIndex, NSMakeRange(0, [[self string] length])) == YES ) {
		
		// Grab the attributes of our attributed string at this exact index
		NSDictionary *attributes = [[self attributedString] attributesAtIndex:charIndex effectiveRange:NULL];
		
		// Depending on what they clicked we could open a URL or perhaps pop open a profile HUD
		// if they clicked on a username. For now, we'll just throw it out to the log.
        
        NSString *attribute;
        AKAttributeType attributeType;
		if( [attributes objectForKey:@"LinkMatch"] != nil ) {
			// Remember what object we stashed in this attribute? Oh yeah, it's a URL string. Boo ya!
			NSLog( @"LinkMatch: %@", [attributes objectForKey:@"LinkMatch"] );
            attribute =[attributes objectForKey:@"LinkMatch"];
            attributeType = AKLinkAttribute;
		}else if( [attributes objectForKey:@"UsernameMatch"] != nil ) {
			NSLog( @"UsernameMatch: %@", [attributes objectForKey:@"UsernameMatch"] );
            attribute = [attributes objectForKey:@"UsernameMatch"];
            attributeType = AKUserNameAttribute;
		}else if( [attributes objectForKey:@"HashtagMatch"] != nil ) {
			NSLog( @"HashtagMatch: %@", [attributes objectForKey:@"HashtagMatch"] );
            attribute = [attributes objectForKey:@"HashtagMatch"];
            attributeType = AKHashTagAttribute;
		}
        
        if(self.delegate){
        
            [self.delegate textView:self attributeClicked:attribute ofType:attributeType atIndex:charIndex];
        
        }
        
        
		
	}
	
	[super mouseDown:theEvent];
}

#pragma mark - String parsing

// These regular expressions aren't the greatest. There are much better ones out there to parse URLs, @usernames
// and hashtags out of tweets. Getting the escaping just right is a pain in the ass, so be forewarned.

- (NSArray *)scanStringForLinks:(NSString *)string {
	return [string componentsMatchedByRegex:@"https?://[a-zA-Z0-9\\-.]+(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?"];
    
}

- (NSArray *)scanStringForUsernames:(NSString *)string {
	NSArray *array = [string componentsMatchedByRegex:@"@[\u4e00-\u9fa5a-zA-Z0-9_-]{2,30}"];
    NSMutableArray *copy = [NSMutableArray arrayWithArray:array];
    NSInteger index = [array count] - 1;
    for (id object in [array reverseObjectEnumerator]) {
        if ([copy indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) {
            [copy removeObjectAtIndex:index];
        }
        index--;
    }
    
    return copy;
    
    //	return [string componentsMatchedByRegex:@"@{1}([-A-Za-z0-9_]{2,})"];
}

- (NSArray *)scanStringForHashtags:(NSString *)string {
	return [string componentsMatchedByRegex:@"#[^#]+#"];
    //    return [string componentsMatchedByRegex:@"[\\s]{1,}#{1}([^\\s]{2,})"];
}


- (NSArray *)scanStringForEmotions:(NSString *)string {
	return [string componentsMatchedByRegex:@"\\[[\u4e00-\u9fa5a-zA-Z0-9_-]{1,10}\\]"];
    
}


@end
