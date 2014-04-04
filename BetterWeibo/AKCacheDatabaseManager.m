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
        else{
            //Success
            [self cleanDatabase];
        }
        
    }
    return self;
}

-(BOOL)creatDatabase{

    /*
     create table tbl1(one varchar(10), two smallint);
     */
    
    return [cacheDB executeUpdate:@"CREATE TABLE IF NOT EXISTS data(date TEXT, appKey varchar(255), accessToken varchar(255), data TEXT);"];
}

-(BOOL)cleanDatabase{
    
    //移除三天前的数据
    NSString *statement = @"DELETE FROM data WHERE date<date('now','-3 day','localtime')";
    return [cacheDB executeUpdate:statement];
    
}
-(BOOL)insertData:(NSData *)data appKey:(NSString *)appKey accessToken:(NSString *)accessToken{
    
    NSString *insertStatement = @"INSERT INTO data (date, appKey, accessToken, data) VALUES (datetime('now','localtime'),:appKey, :accessToken, :data)";
    NSDictionary *paramDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     appKey,@"appKey",
                                     (accessToken)?accessToken:@"",@"accessToken",
                                     [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding], @"data", nil];
    return [cacheDB executeUpdate:insertStatement withParameterDictionary:paramDictionary];
    

}


-(void)insertStatuses:(NSArray *)statuses withUserID:(NSString *)userID{
    
    


}

@end
