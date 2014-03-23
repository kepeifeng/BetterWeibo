//
//  AKEmotion.h
//  BetterWeibo
//
//  Created by Kent on 14-1-11.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKEmotion : NSObject

@property NSString *code;
@property NSURL *URL;
@property NSImage *image;
@property NSString *categoryName;

-(id)initWithCode:(NSString *)code URL:(NSURL *)url image:(NSImage *)image categoryName:(NSString *)category;

+(NSArray *)allEmotions;
+(NSDictionary *)allEmotionsByCategory;
+(NSDictionary *)emotionDictionary;

@end
