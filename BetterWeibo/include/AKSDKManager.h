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
@interface AKSDKManager : NSObject <AKWeibo,AKMethodDelegate>{

    struct AKSDKManagerOpaque * _sdkManagerOpaque;
    
}

/**
 *  App Key, use setConsumer to set value.
 */
@property NSString *key;
/**
 *  App Secret, user setConsumer to set value;
 */
@property NSString *secret;
@property NSString *accessToken;






@end
