//
//  AKCacheDatabaseManager.m
//  BetterWeibo
//
//  Created by Kent on 13-11-2.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKCacheDatabaseManager.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "NSFileManager+DirectoryLocations.h"

@implementation AKCacheDatabaseManager{

    FMDatabase *cacheDB;

}


- (id)init
{
    self = [super init];
    if (self) {
        
        NSString *applicationSupportDiretory = [[NSFileManager defaultManager]applicationSupportDirectory];

        cacheDB = [FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@/cache.db",applicationSupportDiretory]];
        
        if(![cacheDB open]){
            NSLog(@"DB not open.");
        }
        else if(![self creatDatabase]){
            NSLog(@"Create database failed.");
        }
    }
    return self;
}

-(BOOL)creatDatabase{

    /*
     create table tbl1(one varchar(10), two smallint);
     */
    
    return [cacheDB executeUpdate:@"CREATE TABLE IF NOT EXISTS data(appKey varchar(255), accessToken varchar(255), data TEXT);"];
}

-(BOOL)insertData:(NSData *)data appKey:(NSString *)appKey accessToken:(NSString *)accessToken{
    
    NSString *insertStatement = @"INSERT INTO data (appKey, accessToken, data) VALUES (:appKey, :accessToken, :data)";
    NSDictionary *paramDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     appKey,@"appKey",
                                     accessToken,@"accessToken",
                                     [NSString stringWithUTF8String:(const char*)[data bytes]], @"data", nil];
    return [cacheDB executeUpdate:insertStatement withParameterDictionary:paramDictionary];
    

}


-(void)insertStatuses:(NSArray *)statuses withUserID:(NSString *)userID{
    
    


}

@end
