//
//  AKSDKManager.h
//  weibosdk
//
//  Created by Kent Peifeng Ke on 13-10-21.
//
//

#import <Foundation/Foundation.h>
#import "AKWeibo.h"


struct AKSDKManagerOpaque;

/**
 *  A Objectice C Wrapper for SDKManager Class.
 */
@interface AKSDKManager : NSObject <AKWeibo>{

    struct AKSDKManagerOpaque * _sdkManagerOpaque;
    id<AKWeiboMethodProtocol> _weiboMethod;
}







@end
