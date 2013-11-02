//
//  AKID.h
//  weibosdk
//
//  Created by Kent Peifeng Ke on 13-10-17.
//
//

#import <Foundation/Foundation.h>
#import "AKWeiboDef.h"

typedef NS_ENUM(NSInteger, AKIDType){
    
    IDT_ID,
    IDT_SCREENNAME
    
};


struct AKIDOpaque;
@interface AKID : NSObject<AKObjCWrapper>{

    struct AKIDOpaque *idOpaque;
    AKIDType idType;
    NSString *id;
    NSString *key;

}


-(id)initWithIdType:(AKIDType)type text:(NSString *) text key:(NSString *)key;

@property (readonly) BOOL isEmpty;


@end
