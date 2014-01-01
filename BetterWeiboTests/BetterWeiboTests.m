//
//  BetterWeiboTests.m
//  BetterWeiboTests
//
//  Created by Kent Peifeng Ke on 13-9-28.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AKWeiboManager.h"
#import "AKCacheDatabaseManager.h"

@interface BetterWeiboTests : XCTestCase

@end

@implementation BetterWeiboTests{

    AKWeiboManager *weiboManager;

}

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    weiboManager = [[AKWeiboManager alloc]initWithClientID:@"1672616342"
                                                 appSecret:@"57663124f7eb21e1207a2ee09fed507b"
                                               redirectURL:@"http://coffeeandsandwich.com/pinwheel/authorize.php"];
    AKUserProfile *userProfile = [[AKUserProfile alloc]init];
    userProfile.IDString = @"2128178903";
    userProfile.accessToken = @"2.00LYcB1CwuHMpB49be915aaf0Cmenf";
    userProfile.accessTokenExpiresIn = @"125901";
    

    
    [weiboManager addMethodActionObserver:self selector:@selector(weiboManagerMethodActionHandler:)];
    
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    
    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

-(void)weiboManagerMethodActionHandler:(NSNotification *)notification{

    NSLog(@"Get Notification");

}

- (void)testGetUserProfileTest{


    [weiboManager getUserDetail:@"2128178903"];
    
    [NSThread sleepForTimeInterval:5];
    
}


- (void)testGetStatus{
    

    [weiboManager getStatus];
    
    [NSThread sleepForTimeInterval:5];
    
}

-(void)testAKVariablePramas{

    AKVariableParams *vp = [[AKVariableParams alloc]init];
    vp.since_id = [@"12344" longLongValue];
    assert(vp.since_id == 12344ll);

}


@end
