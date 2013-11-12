//
//  AKTabViewController.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-30.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKTabControl.h"
#import "AKTabViewController.h"

@interface AKTabViewController ()

@end

@implementation AKTabViewController
@synthesize identifier = _identifier;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        _identifier = [NSString stringWithFormat:@"AKTVC%@",[AKTabViewController uuid]];
    }
    return self;
}


-(void)tabButtonClicked:(id)sender{
    
    //NSLog(@"%@",self.title);
    if(self.delegate){
        [self.delegate tabViewController:self tabButtonClicked:sender];
    
    
    }
    
}

-(NSString *)identifier{

    return _identifier;

}

+ (NSString *)uuid
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    return (__bridge NSString *)uuidStringRef;
}

@end
