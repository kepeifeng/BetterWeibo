//
//  AKTabViewController.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-30.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKTabControl.h"
#import "AKTabViewController.h"

@implementation AKTabViewController{

    //这个数组里的每一个Object都是一个数组，每一个数组里的项都是ViewController，每一个数组就是一层View。
    NSMutableArray *viewArray;

}

@synthesize identifier = _identifier;
@synthesize title = _tabTitle;
//@synthesize view = _view;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        self.backgroundImage = [NSImage imageNamed:@"app_content_background"];
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

}

-(void)goBackButtonClicked:(id)sender{

    if(!viewArray || viewArray.count == 0){
        return;
    }
    
    //NSArray *viewControllerArray = viewArray.lastObject;
    for (NSViewController *viewController in viewArray) {
        [viewController.view removeFromSuperview];
        [viewArray removeObject:viewController];
    }
    
    //显示之前的SubView
    for(NSView* subView in self.view.subviews){
        [subView setHidden:NO];
    }
    
    if(self.delegate){
        [self.delegate tabViewController:self goToNewViewOfController:self];
    }

}

-(void)goToViewOfController:(NSViewController *)viewController{

    //隐藏之前的SubView
    for(NSView* subView in self.view.subviews){
        [subView setHidden:YES];
    }
    
    if([viewController isKindOfClass:[AKTabViewController class]]){
    
        AKTabViewController *tabViewController = (AKTabViewController *)viewController;
        NSMutableArray *leftControls;
        if([tabViewController.leftControls isKindOfClass:[NSMutableArray class] ]){
            leftControls = (NSMutableArray *)tabViewController.leftControls;
        }
        else{
            leftControls = [[NSMutableArray alloc]initWithArray:tabViewController.leftControls];
            
        }
        
        //添加一个GoBack按钮
        NSButton *goBackButton = [NSButton new];
        goBackButton.frame = NSMakeRect(0, 0, 48, 36);
        goBackButton.image = [NSImage imageNamed:@"navbar_back_button"];
        goBackButton.alternateImage = [NSImage imageNamed:@"navbar_back_highlighted_button"];
        goBackButton.title = @"Back";
        goBackButton.target = self;
        goBackButton.action = @selector(goBackButtonClicked:);

        [leftControls insertObject:goBackButton atIndex:0];
        
        tabViewController.leftControls = leftControls;
    
    }
    
    //设置新加进来的View的尺寸和位置
    viewController.view.frame = self.view.bounds;
    //设置View的宽度和高度为自动调整
    [viewController.view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    //把新的View添加到当前的View中
    [self.view addSubview:viewController.view];
    
    //把新加的View记录下来
    if(!viewArray){
        viewArray =[NSMutableArray new];
    }
    [viewArray addObject:viewController];
    
//    NSArray *newViewControllerArray = [[NSArray alloc] initWithObjects:viewController, nil];
//    [viewArray addObject:newViewControllerArray];
    
    
    //告诉Delegate有转到新的View了
    if(self.delegate){
        [self.delegate tabViewController:self goToNewViewOfController:viewController];
    }

    
    //NSLog(@"YA, I AM GOING TO THE NEW VIEW OF %@",viewController.className);

}


@end
