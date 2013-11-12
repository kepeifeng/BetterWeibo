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

        cacheDB = [FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@cache.db",applicationSupportDiretory]];
        
        if(![cacheDB open]){
        
            NSLog(@"DB not open.");
        
        
        }
    }
    return self;
}


-(void)insertStatuses:(NSArray *)statuses withUserID:(NSString *)userID{
    
    


}

@end
