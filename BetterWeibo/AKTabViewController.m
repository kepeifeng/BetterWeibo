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
@synthesize title = _tabTitle;
//@synthesize view = _view;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.

    }
    return self;
}


-(void)tabButtonClicked:(id)sender{
    
    //NSLog(@"%@",self.title);
//    if(self.delegate){
//        [self.delegate tabViewController:self tabButtonClicked:sender];
//    
//    
//    }
    
}

-(NSString *)identifier{

    if(!_identifier)
    {
        _identifier = [NSString stringWithFormat:@"AKTVC%@",[AKTabViewController uuid]];
    }
    
    return _identifier;

}

+ (NSString *)uuid
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    return (__bridge NSString *)uuidStringRef;
}

//-(AKPanelView *)view{
//
//    return _view;
//
//}
//
//-(void)setView:(AKPanelView *)view{
//
//    _view = view;
//    super.view = view;
//    if(_view){
//        _view.title = self.title;
//    }
//
//}

-(NSString *)title{

    return _tabTitle;

}

-(void)setTitle:(NSString *)title{

    _tabTitle = title;
//    if(self.view){
//        self.view.title = title;
//    }
    
    

}


@end
