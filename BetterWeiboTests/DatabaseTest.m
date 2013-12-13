//
//  DatabaseTest.m
//  BetterWeibo
//
//  Created by Kent on 13-12-10.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AKCacheDatabaseManager.h"

@interface DatabaseTest : XCTestCase

@end

@implementation DatabaseTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}


-(void)testInsertData{


    AKCacheDatabaseManager *cacheManager = [[AKCacheDatabaseManager alloc]init];
    NSString *string = @"{\"statuses\":\"what?\"}";
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *appKey = @"This a App Key.";
    NSString *accessToken = @"2.0This is an Access Token";
    BOOL result = [cacheManager insertData:data appKey:appKey accessToken:accessToken];
    assert(result);
}
@end
