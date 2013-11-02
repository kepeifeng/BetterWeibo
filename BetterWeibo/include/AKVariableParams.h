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

@property long since_id;
@property long long max_id;
@property int count;
@property int page;
@property int base_app;
@property int feature;
@property int is_encoded;
@property int sort;
@property int cursor; //first page is -1,if next_cursor == 0, page end.

// variable for statuses
@property int filter_by_source;
@property int filter_by_author;
@property int filter_by_type;
@property int trim_user;
@property int trim_status;
@property NSString *simplify;

@end
