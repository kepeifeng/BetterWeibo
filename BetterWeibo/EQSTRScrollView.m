//
//  EQSTRScrollView.m
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

#import "EQSTRScrollView.h"
#import "EQSTRClipView.h"
#import <QuartzCore/QuartzCore.h>
#import "AKView.h"


#define REFRESH_HEADER_HEIGHT 42.0f

// code modeled from https://github.com/leah/PullToRefresh/blob/master/Classes/PullRefreshTableViewController.m

@interface EQSTRScrollView ()
@property (nonatomic, assign) BOOL _overRefreshView;
@property (nonatomic, assign) BOOL _overBottomRefreshView;
@property (nonatomic, retain) CALayer *_arrowLayer;
@property (nonatomic,strong) NSProgressIndicator* bottomProgressIndicator;

- (BOOL)overRefreshView;
- (void)createHeaderView;
//- (void)viewBoundsChanged:(NSNotification*)note;

- (CGFloat)minimumScroll;

@end

@implementation EQSTRScrollView{



} 

#pragma mark - Private Properties

@synthesize _overRefreshView;
@synthesize _arrowLayer;
@synthesize _overBottomRefreshView;

#pragma mark - Public Properties

@synthesize isRefreshing   = _isRefreshing;
@synthesize refreshHeader  = _refreshHeader; 
@synthesize refreshSpinner = _refreshSpinner;
@synthesize refreshArrow   = _refreshArrow;
@synthesize refreshBlock   = _refreshBlock;
@synthesize refreshBottomBlock = _refreshBottomBlock;
@synthesize refreshFooter = _refreshFooter;
@synthesize isBottomRefreshing = _isBottomRefreshing;

#pragma mark - Dealloc
- (void)dealloc {
	self.refreshBlock = nil;
	self._arrowLayer  = nil;
//	[super dealloc];
}

#pragma mark - Create Header View

- (void)viewDidMoveToWindow {
	[self createHeaderView];
    [self createFooterView];
    if(self.isRefreshing){
        [self.contentView scrollToPoint:NSMakePoint(0, -REFRESH_HEADER_HEIGHT)];
    }
}



- (NSClipView *)contentView {
	NSClipView *superClipView = [super contentView];
	if (![superClipView isKindOfClass:[EQSTRClipView class]]) {
		
		// create new clipview
		NSView *documentView     = superClipView.documentView;
		
		EQSTRClipView *clipView  = [[EQSTRClipView alloc] initWithFrame:superClipView.frame];
		clipView.documentView    = documentView;
		clipView.copiesOnScroll  = NO;
		clipView.drawsBackground = NO;
		
		[self setContentView:clipView];
//		[clipView release];
		
		superClipView            = [super contentView];
		
	}
	return superClipView;
}

- (void)createHeaderView {
	// delete old stuff if any
	if (self.refreshHeader) {
        return;
//		[_refreshHeader removeFromSuperview];
////		[_refreshHeader release];
//		_refreshHeader = nil;
	}
	
//	[self setVerticalScrollElasticity:NSScrollElasticityAllowed];
	
	(void)self.contentView; // create new content view
	
	[self.contentView setPostsFrameChangedNotifications:YES];
	[self.contentView setPostsBoundsChangedNotifications:YES];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(viewBoundsChanged:)
												 name:NSViewBoundsDidChangeNotification 
											   object:self.contentView];
	
	// add header view to clipview
	NSRect contentRect = [self.contentView.documentView frame];
	_refreshHeader = [[AKView alloc] initWithFrame:NSMakeRect(0,
															  0 - REFRESH_HEADER_HEIGHT,
															  contentRect.size.width, 
															  REFRESH_HEADER_HEIGHT)];
    _refreshHeader.backgroundType = AKViewLightGrayGraient;

	
	// Create Arrow
	NSImage *arrowImage = [NSImage imageNamed:@"arrow"];
	_refreshArrow       = [[NSView alloc] initWithFrame:NSMakeRect(floor(NSMidX(self.refreshHeader.bounds) - arrowImage.size.width / 2), 
																   floor(NSMidY(self.refreshHeader.bounds) - arrowImage.size.height / 2), 
																   arrowImage.size.width,
																   arrowImage.size.height)];
	self.refreshArrow.wantsLayer = YES;
	
	self._arrowLayer = [CALayer layer];
	self._arrowLayer.contents = (id)[arrowImage CGImageForProposedRect:NULL
															   context:nil
																 hints:nil];
	
	self._arrowLayer.frame    = NSRectToCGRect(_refreshArrow.bounds);
	_refreshArrow.layer.frame = NSRectToCGRect(_refreshArrow.bounds);
	
	[self.refreshArrow.layer addSublayer:self._arrowLayer];
	
	// Create spinner
    NSSize spinnerSize = NSMakeSize(30, 30);
	_refreshSpinner = [[NSProgressIndicator alloc] initWithFrame:NSMakeRect(floor(NSMidX(self.refreshHeader.bounds) - spinnerSize.width/2),
																			floor(NSMidY(self.refreshHeader.bounds) - spinnerSize.height/2),
																			spinnerSize.width,
																			spinnerSize.height)];
	self.refreshSpinner.style                 = NSProgressIndicatorSpinningStyle;
	self.refreshSpinner.displayedWhenStopped  = NO;
	self.refreshSpinner.usesThreadedAnimation = YES;
	self.refreshSpinner.indeterminate         = YES;
	self.refreshSpinner.bezeled               = NO;
	[self.refreshSpinner sizeToFit];
	
	// Center the spinner in the header
	[self.refreshSpinner setFrame:NSMakeRect(floor(NSMidX(self.refreshHeader.bounds) - self.refreshSpinner.frame.size.width / 2),
											 floor(NSMidY(self.refreshHeader.bounds) - self.refreshSpinner.frame.size.height / 2), 
											 self.refreshSpinner.frame.size.width, 
											 self.refreshSpinner.frame.size.height)];
	
	// set autoresizing masks
	self.refreshSpinner.autoresizingMask = NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin; // center
	self.refreshArrow.autoresizingMask   = NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin; // center
	self.refreshHeader.autoresizingMask  = NSViewWidthSizable | NSViewMinXMargin | NSViewMaxXMargin; // stretch/center
	
	// Put everything in place
	[self.refreshHeader addSubview:self.refreshArrow];
	[self.refreshHeader addSubview:self.refreshSpinner];
	
	[self.contentView addSubview:self.refreshHeader];	
	
//	[_refreshArrow release];
//	[_refreshSpinner release];
	
	// Scroll to top
	[self.contentView scrollToPoint:NSMakePoint(contentRect.origin.x, 0)];
	[self reflectScrolledClipView:self.contentView];
}

-(NSView*) newEdgeViewForSide:(BSRefreshableScrollViewSide) edgeSide progressIndicator:(NSProgressIndicator*) indicatorView
{
    NSView* const contentView = self.contentView;
    NSView* const documentView = self.documentView;
    const NSRect indicatorViewBounds = indicatorView.bounds;
    
    
    AKView* edgeView = [[AKView alloc] initWithFrame:NSZeroRect];
    edgeView.backgroundType = AKViewLightGrayGraient;
    [edgeView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [edgeView setWantsLayer:YES];
    
    [edgeView addSubview:indicatorView];
    
    // vertically centered
    [edgeView addConstraint:[NSLayoutConstraint constraintWithItem:indicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:edgeView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    // horizontally centered
    [edgeView addConstraint:[NSLayoutConstraint constraintWithItem:indicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:edgeView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    [contentView addSubview:edgeView];
    
    
    if (edgeSide  &  (BSRefreshableScrollViewSideTop | BSRefreshableScrollViewSideBottom) ) {
        // span horizontally
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:edgeView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:edgeView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        
        
        // set height
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:edgeView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:REFRESH_HEADER_HEIGHT]];
        
        if (edgeSide & BSRefreshableScrollViewSideTop) {
            // above the content view top
            [contentView addConstraint:[NSLayoutConstraint constraintWithItem:edgeView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:documentView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        } else if(edgeSide & BSRefreshableScrollViewSideBottom) {
            [contentView addConstraint:[NSLayoutConstraint constraintWithItem:edgeView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:documentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        }
    }
    
    return edgeView;
}

@synthesize bottomProgressIndicator = _bottomProgressIndicator;

-(NSProgressIndicator *)bottomProgressIndicator
{
    if (!_bottomProgressIndicator) {
        _bottomProgressIndicator = [NSProgressIndicator new];
        [_bottomProgressIndicator setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_bottomProgressIndicator setIndeterminate:YES];
        [_bottomProgressIndicator setStyle:NSProgressIndicatorSpinningStyle];
        [_bottomProgressIndicator setControlSize: NSRegularControlSize];
        [_bottomProgressIndicator setDisplayedWhenStopped:NO];
        [_bottomProgressIndicator setAlphaValue:1];
        [_bottomProgressIndicator sizeToFit];
    }
    return _bottomProgressIndicator;
}

- (void)createFooterView {
	// delete old stuff if any
	if (_refreshFooter) {
        
        return;
		[_refreshFooter removeFromSuperview];
        //		[_refreshHeader release];
		_refreshFooter = nil;
	}
	
	
	// add header view to clipview
	//NSRect contentRect = [self.contentView.documentView frame];
	_refreshFooter = [self newEdgeViewForSide:BSRefreshableScrollViewSideBottom progressIndicator:self.bottomProgressIndicator];
    
    _refreshFooter.wantsLayer = YES;
    _refreshFooter.layer.backgroundColor = CGColorCreateGenericRGB(0.8, 0.8, 0.8, 1);

	//[self.contentView addSubview:_refreshFooter];
    
    
    //	[_refreshArrow release];
    //	[_refreshSpinner release];
	
}


#pragma mark - Detecting Scroll

- (void)scrollWheel:(NSEvent *)event {
	if (event.phase == NSEventPhaseEnded) {
		if (self._overRefreshView && ! self.isRefreshing) {
			[self startLoading];
		}
        else if(self._overBottomRefreshView && !self.isBottomRefreshing && !self.isRefreshing){
            [self startBottomLoading];
        }
	}
	
	[super scrollWheel:event];
}

- (void)viewBoundsChanged:(NSNotification *)note {
	if (self.isRefreshing || self.isBottomRefreshing)
		return;
	
	BOOL start = [self overRefreshView];
	if (start) {
		
		// point arrow up
		self._arrowLayer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
		self._overRefreshView = YES;
		
	} else {
		
        BOOL bottomReadyToRefresh = [self overBottomRefreshView];
        if(bottomReadyToRefresh){
            self._overBottomRefreshView = YES;
        }
        else{
            self._overBottomRefreshView = NO;
        }
        
		// point arrow down
		self._arrowLayer.transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
		self._overRefreshView = NO;
		
	}
    
    
    
    
	
}

- (BOOL)overRefreshView {
	NSClipView *clipView  = self.contentView;
	NSRect bounds         = clipView.bounds;
	
	CGFloat scrollValue   = bounds.origin.y;
	CGFloat minimumScroll = self.minimumScroll;
	
	return (scrollValue <= minimumScroll);
}

-(BOOL)overBottomRefreshView{
    
    NSView* const documentView = self.documentView;
    const NSRect documentFrame = documentView.frame;
    
	NSClipView *clipView  = self.contentView;
	NSRect bounds         = clipView.bounds;
	
	CGFloat scrollValue   = bounds.origin.y;
	CGFloat minimumScroll = self.minimumScroll;
	
	return (bounds.origin.y + bounds.size.height - documentFrame.size.height > minimumScroll);
    

}

- (CGFloat)minimumScroll {
	return 0 - self.refreshHeader.frame.size.height;
}

#pragma mark - Refresh
- (void)startBottomLoading{

    [self willChangeValueForKey:@"isBottomRefreshing"];
	_isBottomRefreshing = YES;
	[self didChangeValueForKey:@"isBottomRefreshing"];
	
	//self.refreshArrow.hidden = YES;
	[self.bottomProgressIndicator startAnimation:self];
	
	if (self.refreshBottomBlock) {
		self.refreshBottomBlock(self);
	}
    
}

-(void)stopBottomLoading{


	[self.bottomProgressIndicator stopAnimation:self];
	
	// now fake an event of scrolling for a natural look
	
	[self willChangeValueForKey:@"isBottomRefreshing"];
	_isBottomRefreshing = NO;
	[self didChangeValueForKey:@"isBottomRefreshing"];
	
	CGEventRef cgEvent   = CGEventCreateScrollWheelEvent(NULL,
														 kCGScrollEventUnitLine,
														 2,
														 1,
														 0);
	
	NSEvent *scrollEvent = [NSEvent eventWithCGEvent:cgEvent];
	[self scrollWheel:scrollEvent];
	CFRelease(cgEvent);
    

}

- (void)startLoading {
	[self willChangeValueForKey:@"isRefreshing"];
	_isRefreshing            = YES;
	[self didChangeValueForKey:@"isRefreshing"];
	
	self.refreshArrow.hidden = YES;
	[self.refreshSpinner startAnimation:self];
	
	if (self.refreshBlock) {
		self.refreshBlock(self);
	}
}

- (void)stopLoading {	
	self.refreshArrow.hidden            = NO;	
	
	[self.refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
	[self.refreshSpinner stopAnimation:self];
	
	// now fake an event of scrolling for a natural look
	
	[self willChangeValueForKey:@"isRefreshing"];
	_isRefreshing = NO;
	[self didChangeValueForKey:@"isRefreshing"];
	
	CGEventRef cgEvent   = CGEventCreateScrollWheelEvent(NULL,
														 kCGScrollEventUnitLine,
														 2,
														 1,
														 0);
	
	NSEvent *scrollEvent = [NSEvent eventWithCGEvent:cgEvent];
	[self scrollWheel:scrollEvent];
	CFRelease(cgEvent);
}

@end
