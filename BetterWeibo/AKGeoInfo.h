//
//  AKGeoInfo.h
//  BetterWeibo
//
//  Created by Kent on 13-12-4.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKGeoInfo : NSObject

/**
 *经度坐标
 */
@property NSString * longitude;
/**
 *维度坐标
 */
@property NSString * latitude;
/**
 *所在城市的城市代码
 */
@property NSString * city;
/**
 *所在省份的省份代码
 */
@property NSString * province;
/**
 *所在城市的城市名称
 */
@property NSString * city_name;
/**
 *所在省份的省份名称
 */
@property NSString * province_name;
/**
 *所在的实际地址，可以为空
 */
@property NSString * address;
/**
 *地址的汉语拼音，不是所有情况都会返回该字段
 */
@property NSString * pinyin;
/**
 *更多信息，不是所有情况都会返回该字段
 */
@property NSString * more;

@end
