//
//  EQSTRScrollView.h
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

#import <AppKit/AppKit.h>
typedef NS_OPTIONS(NSUInteger, BSRefreshableScrollViewSide) {
    BSRefreshableScrollViewSideNone = 0,
    BSRefreshableScrollViewSideTop = 1,
    BSRefreshableScrollViewSideBottom = 1 << 1,
    // left & right edges are for future expansion but not currently implemented
    BSRefreshableScrollViewSideLeft = 1 << 2,
    BSRefreshableScrollViewSideRight = 1 << 3
};


@interface EQSTRScrollView : NSScrollView
@property (readonly) BOOL isRefreshing;
@property (readonly) BOOL isBottomRefreshing;

@property (readonly) NSView *refreshHeader;
@property (readonly) NSView *refreshFooter;
@property (readonly) NSProgressIndicator *refreshSpinner;
@property (readonly) NSView *refreshArrow;


@property (nonatomic, copy) void (^refreshBlock)(EQSTRScrollView *scrollView);
@property (nonatomic, copy) void (^refreshBottomBlock)(EQSTRScrollView *scrollView);


- (void)startLoading;
- (void)stopLoading;
-(void)startBottomLoading;
-(void)stopBottomLoading;
@end
