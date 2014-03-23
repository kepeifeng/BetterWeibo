//
//  AKVariableParams.h
//  weibosdk
//
//  Created by Kent Peifeng Ke on 13-10-17.
//
//

#import <Foundation/Foundation.h>
#import "AKWeiboDef.h"

struct AKVariableParamsOpaque;
@interface AKVariableParams : NSObject<AKObjCWrapper>{

    struct AKVariableParamsOpaque *variableParamsOpaque;
    
}

/**
 *  若指定此参数则在发送请求时使用这个参数作为Access Token
 */
@property NSString *accessToken;

/**
 *  若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 */
@property long long since_id;
/**
 *  若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 */
@property long long max_id;
/**
 *  单页返回的记录条数，最大不超过100，默认为20。
 */
@property int count;
/**
 *  返回结果的页码，默认为1。
 */
@property int page;
/**
 *  是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 */
@property int base_app;
/**
 *  过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
 */
@property int feature;
@property int is_encoded;
@property int sort;
@property int cursor; //first page is -1,if next_cursor == 0, page end.

// variable for statuses
@property int filter_by_source;
@property int filter_by_author;
@property int filter_by_type;
/**
 *  返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0。
 */
@property int trim_user;
@property int trim_status;
@property NSString *simplify;


-(NSDictionary *)getDictionary;

@end
