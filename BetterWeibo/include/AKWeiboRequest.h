//
//  AKWeiboRequest.h
//  weibosdk
//
//  Created by Kent on 13-12-6.
//
//

#import <Foundation/Foundation.h>
//#import "AKWeiboDef.h"
#import "AKWeiboMethod.h"

@interface AKWeiboRequest : NSMutableURLRequest

@property AKMethodAction option;
@property (readonly) NSString * taskID;
/**
 *  发起此请求的用户ID
 */
@property NSString *accessToken;
@property AKUserTaskInfo * taskInfo;
//@property NSString *URL;
@property NSString *postArgument;
@property NSString *responseBody;
@property NSString *responseHeader;
@property id reqHeader;
@property NSString *postFileField;
@property id uploadTaskDetail;
@property NSDictionary *reqHeaderMap;

-(void)makeUploadTaskDetail:(NSString *)file;


@end
