//
//  EQSTRClipView.m
//  ScrollToRefresh
//
// Copyright (C) 2011 by Alex Zielenski.

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import "EQSTRClipView.h"
#import "EQSTRScrollView.h"

@interface EQSTRScrollView (Private)
- (CGFloat)minimumScroll;
@end

@interface EQSTRClipView ()
- (BOOL)isRefreshing;
- (NSView *)headerView;
- (CGFloat)minimumScroll;

@end

@implementation EQSTRClipView
- (NSPoint)constrainScrollPoint:(NSPoint)proposedNewOrigin { // this method determines the "elastic" of the scroll view or how high it can scroll without resistence. 	
	NSPoint constrained = [super constrainScrollPoint:proposedNewOrigin];
	CGFloat scrollValue = proposedNewOrigin.y; // this is the y value where the top of the document view is
	BOOL over           = scrollValue <= self.minimumScroll;
    const NSRect clipViewBounds = self.bounds;
    NSView* const documentView = self.documentView;
    const NSRect documentFrame = documentView.frame;

    
	
	if (self.isRefreshing && scrollValue <= 0) { // if we are refreshing
		if (over) // and if we are scrolled above the refresh view
			proposedNewOrigin.y = 0 - self.headerView.frame.size.height; // constrain us to the refresh view
		
		return NSMakePoint(constrained.x, proposedNewOrigin.y);
	}
    
    const NSRect footerFrame = [self footerView].frame;
    if (self.isBottomRefreshing && proposedNewOrigin.y >  documentFrame.size.height - clipViewBounds.size.height) {
        const CGFloat maxHeight = documentFrame.size.height - clipViewBounds.size.height + footerFrame.size.height + 1;
        constrained.y = MIN(maxHeight, proposedNewOrigin.y);
    }
    
	return constrained;
}

- (BOOL)isFlipped {
	return YES; 
}

- (NSRect)documentRect { //this is to make scrolling feel more normal so that the spinner is within the scrolled area
	NSRect documentRect = [super documentRect];
	if (self.isRefreshing) {
		documentRect.size.height += self.headerView.frame.size.height;
		documentRect.origin.y    -= self.headerView.frame.size.height;
	}
    
    if(self.isBottomRefreshing){
    
        const NSRect footerFrame = [self footerView].frame;
        documentRect.size.height += footerFrame.size.height;
        
    }
    
	return documentRect;
}

- (BOOL)isRefreshing {
	return [(EQSTRScrollView *)self.superview isRefreshing];
}


-(BOOL)isBottomRefreshing{

    return [(EQSTRScrollView *)self.superview isBottomRefreshing];
}

- (NSView *)headerView {
	return [(EQSTRScrollView *)self.superview refreshHeader];
}

-(NSView *)footerView{

    return [(EQSTRScrollView *)self.superview refreshFooter];

}

- (CGFloat)minimumScroll {
	return [(EQSTRScrollView *)self.superview minimumScroll];
}

@end
