//
//  AKImageViewer.m
//  BetterWeibo
//
//  Created by Kent on 13-12-11.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKImageViewer.h"
#import "AKImageHelper.h"

@implementation AKImageViewer{

    NSMutableDictionary *_imagesDictionary;
    NSMutableDictionary *_connectionDictionary;
    NSMutableDictionary *_dataDictionary;
    NSMapTable *_connectionDataMap;
    
    

}
@synthesize image = _image;
@synthesize images = _images;
@synthesize index = _index;

-(id)initWithImage:(NSImage *)image{


    
    self = [super initWithWindowNibName:@"AKImageViewer" owner:self];
    if (self) {
        [self.window orderOut:nil];
//        _imagesDictionary = [NSMutableDictionary new];
//        [_imagesDictionary setObject:image forKey:[NSNumber numberWithInteger:0]];
        
        self.image = image;

        // Initialization code here.
    }
    return self;

}

-(id)initWithArray:(NSArray *)imageArray{
    return [self initWithArray:imageArray startAtIndex:0];
}


-(id)initWithArray:(NSArray *)imageArray startAtIndex:(NSInteger)index{
    
    self = [super initWithWindowNibName:@"AKImageViewer" owner:self];
    if (self) {
        [self.window orderOut:nil];
        
        
        //Initialize dictionaries before setting index.
        _connectionDictionary = [NSMutableDictionary new];
        _dataDictionary = [NSMutableDictionary new];
        _connectionDataMap = [NSMapTable new];
        
        self.images = imageArray;
        self.index = index;

        // Initialization code here.
    }
    return self;
    
}


-(void)show{
    
    [self showWindow:self];
//    [self.window makeKeyAndOrderFront:nil];
}

#pragma mark - Properties

-(NSImage *)image{
    return _image;
}

-(void)setImage:(NSImage *)image{
    _image =image;
    self.imageView.image = image;
    
}


-(NSArray *)images{
    return _images;
}

-(void)setImages:(NSArray *)images{

    if(_images == images){
        return;
    }
    
    _images = images;
    
    _imagesDictionary = [NSMutableDictionary new];
    self.index = 0;

}

-(NSInteger)index{

    return _index;

}

-(void)setIndex:(NSInteger)index{

    _index = index;
    NSImage *image;
    
    [self.previousButton setEnabled:(index>0)];
    [self.nextButton setEnabled:(index<_images.count-1)];
    [self.messageView setHidden:YES];
    
    if(index<_images.count){
    
        if(!(image = [_imagesDictionary objectForKey:[NSNumber numberWithInteger:index]])){
            
            NSString *urlString = [(NSDictionary *)[_images objectAtIndex:index] objectForKey:@"thumbnail_pic"];
            //"thumbnail_pic": "http://ww1.sinaimg.cn/thumbnail/d3976c6ejw1ebbzpeeadwj20d107b74e.jpg"
            //"bmiddle_pic": "http://ww1.sinaimg.cn/bmiddle/d3976c6ejw1ebbzpeeadwj20d107b74e.jpg"
            //"original_pic": "http://ww1.sinaimg.cn/large/d3976c6ejw1ebbzpeeadwj20d107b74e.jpg"
            urlString = [urlString stringByReplacingOccurrencesOfString:@"/thumbnail/" withString:@"/bmiddle/"];
            
            self.imageView.image = nil;
            [self startLoadingImageFromURL:[NSURL URLWithString:urlString] forIndex:index];
            [_progressIndicator startAnimation:self];
            return;
            
            
        }
        
        self.imageView.image = image;
        [_progressIndicator stopAnimation:self];
        
    
    }
    else{
        self.imageView.image = nil;
    }

}

-(void)startLoadingImageFromURL:(NSURL *)url forIndex:(NSInteger)index{
    
    if([_connectionDictionary objectForKey:[NSNumber numberWithInteger:index]]){
        return;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if(connection){
    
        NSMutableData *data = [NSMutableData new];
        [_connectionDataMap setObject:data forKey:connection];
        [_connectionDictionary setObject:connection forKey:[NSNumber numberWithInteger:index]];
        
    }
    


}

//传送完成
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSNumber *index;
    for (NSNumber *number in _connectionDictionary.allKeys) {
        if([_connectionDictionary objectForKey:number] == connection){
            index = number;
            break;
        }
    }
    
    NSMutableData *_data = [_connectionDataMap objectForKey:connection];
    
    NSImage *image = [AKImageHelper getImageFromData:_data];
    
    [_imagesDictionary setObject:image forKey:index];
    
    if([index integerValue] == self.index){
        
        [_progressIndicator stopAnimation:self];
        self.imageView.image = image;
    
    }
    
    [_connectionDataMap removeObjectForKey:connection];
    [_connectionDictionary removeObjectForKey:index];


}



//
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{

    NSMutableData *_data = [_connectionDataMap objectForKey:connection];
    [_data appendData:data];

}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

    [self.messageField setStringValue:@"网络错误，图片无法加载。"];
    [self.messageView setHidden:NO];
    
    
    
    
}

// 無論如何回傳 YES
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace{
    return YES;
}

// 不管那一種 challenge 都相信
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    NSLog(@"received authen challenge");
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}




- (IBAction)retryButtonClicked:(id)sender {
    
    self.index = self.index;
}

- (IBAction)previousButtonClicked:(id)sender {

    self.index--;

}

- (IBAction)nextButtonClicked:(id)sender {
    
    self.index++;
}

- (IBAction)sizeSwitchButtonClicked:(id)sender {
}

- (IBAction)saveButtonClicked:(id)sender {
}
@end
