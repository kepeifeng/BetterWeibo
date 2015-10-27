//
//  AKTextField.h
//  BetterWeibo
//
//  Created by Kent on 13-10-7.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSUInteger, AKAttributeType){

    AKUserNameAttribute,
    AKLinkAttribute,
    AKHashTagAttribute
};

@protocol AKTextViewDelegate;

@interface AKTextView : NSTextView
-(void)adjustFrame;

@property (nullable, assign) id<AKTextViewDelegate, NSTextViewDelegate> delegate;
@property NSInteger minimalHeight;

-(void)setStringValue:(NSString *)aString;

@end

@protocol AKTextViewDelegate <NSTextViewDelegate>

@optional
-(void)textView:(AKTextView *)textView attributeClicked:(NSString *)attribute ofType:(AKAttributeType)attributeType atIndex:(NSUInteger)index;

@end
