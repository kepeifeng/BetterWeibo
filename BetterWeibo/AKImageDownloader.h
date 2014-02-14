//
//  AKImageDownloader.h
//  BetterWeibo
//
//  Created by Kent on 14-1-3.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AKDownloaderSource

-(void)getDownloadURLs;
-(void *)setDownloadData:(NSArray *)data;


@end

@interface AKDownloader : NSObject

+(AKDownloader *)defaultDownloader;

-(void)addTask:(id<AKDownloaderSource>)source;





@end
