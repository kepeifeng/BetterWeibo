//
//  AKTextField.h
//  BetterWeibo
//
//  Created by Kent on 13-10-7.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AKTextView : NSTextView
-(void)adjustFrame;

@property NSInteger minimalHeight;

-(void)setStringValue:(NSString *)aString;

@end
