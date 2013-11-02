//
//  AKParsingHandle.h
//  weibosdk
//
//  Created by Kent Peifeng Ke on 13-10-18.
//
//

#import <Foundation/Foundation.h>


struct JsonValue;

struct ParsingHandleOpaque;
@interface AKParsingHandle : NSObject{

    struct ParsingHandleOpaque *_cpp;
}


-(id)initWithJsonValue:(struct JsonValue *)val isOwner:(BOOL)isOwner;
-(void)dealloc;

//-(BOOL)parse:(NSString *)source;
//-(void)resetWithJsonValue:(struct JsonValue *)val isOwner:(BOOL)isOwner;
//-(NSString *)getErrorMessage;
//-(NSString *)getSource;
//-(struct JsonValue *)getValue;




@end
