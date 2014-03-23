//
//  AKTabViewController.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-30.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKTabControl.h"
#import "AKTabViewController.h"
#import "AKButton.h"
#import "INAppStoreWindow.h"
@interface AKTabViewController()

@property (readonly) INAppStoreWindow *window;

@end
@implementation AKTabViewController{

    //这个数组里的每一个Object都是一个数组，每一个数组里的项都是ViewController，每一个数组就是一层View。
    NSMutableArray *viewControllerArray;
    NSView *_titleBarCustomView;


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


-(void)tabDidActived{
//    NSLog(@"tabButtonClicked");
    [self setupTitleBarForViewController:self];
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


-(INAppStoreWindow *)window{
    return (INAppStoreWindow *)self.view.window;
}

-(NSString *)title{

    return _tabTitle;

}

-(void)setTitle:(NSString *)title{

    _tabTitle = title;

}

-(void)goBackButtonClicked:(id)sender{


    //移除当前View Controller和View
    NSViewController *viewController = viewControllerArray.lastObject;
    [viewController.view removeFromSuperview];
    [viewControllerArray removeObject:viewController];

    
    //显示之前的SubView
    if(!viewControllerArray || viewControllerArray.count == 0){
        viewController = self;
        for(NSView* subView in self.view.subviews){
            [subView setHidden:NO];
        }
    }
    else{
        viewController = viewControllerArray.lastObject;
        [viewController.view setHidden:NO];

    }
    
    [self setupTitleBarForViewController:viewController];
    
//    if(self.delegate){
//        [self.delegate tabViewController:self goToNewViewOfController:viewController];
//    }

}

-(void)setupTitleBarForViewController:(NSViewController *)viewController{
    
    if(viewController.title){
        [self.window setTitle:viewController.title];
    }
    
    AKTabViewController *tabViewController = (AKTabViewController *)viewController;
    
    _titleBarCustomView = self.window.titleBarView;
//    if(!_titleBarCustomView){
//        _titleBarCustomView = [[NSView alloc]init];
//        [self.window.titleBarView addSubview:_titleBarCustomView];
//        [_titleBarCustomView setFrame:NSMakeRect(82, 0, (self.window.titleBarView.bounds.size.width - 82), self.window.titleBarView.bounds.size.height)];
//        [_titleBarCustomView setAutoresizingMask:NSViewWidthSizable];
//    }

    //Remove All Sub Views in titlebar
    [[_titleBarCustomView subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];

    
    NSInteger nextLeftMargin = 82+5;
    if(tabViewController.leftControls){
        
        for(NSControl *control in tabViewController.leftControls){
            
            [_titleBarCustomView addSubview:control];
            [control setFrame:NSMakeRect(nextLeftMargin, (_titleBarCustomView.bounds.size.height - control.frame.size.height)/2, control.frame.size.width, control.frame.size.height)];
            
            [control setAutoresizingMask:NSViewMaxXMargin];
            NSLog(@"%@",[(NSButton *)control title]);
            nextLeftMargin += control.frame.size.width + 5;
            
        }
        
    }
    
    NSInteger nextRightControlMargin = 5;
    if(tabViewController.rightControls){
        
        for(NSControl *control in tabViewController.rightControls){
            
            [_titleBarCustomView addSubview:control];
            [control setFrame:NSMakeRect(_titleBarCustomView.frame.size.width - nextRightControlMargin - control.frame.size.width, (_titleBarCustomView.bounds.size.height - 36)/2, control.frame.size.width, 36)];
            
            [control setAutoresizingMask:NSViewMinXMargin];
            
            nextRightControlMargin += control.frame.size.width + 5;
            
        }
        
    }
    
    
}

-(void)goToViewOfController:(NSViewController *)viewController{

    //把新加的View记录下来
    if(!viewControllerArray){
        viewControllerArray =[NSMutableArray new];
    }
    
    //隐藏之前的SubView
    if(viewControllerArray.count == 0){
    
        for(NSView* subView in self.view.subviews){
            [subView setHidden:YES];
        }
        
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
        
        AKButton *goBackButton = [[AKButton alloc] initWithFrame:NSMakeRect(0, 0, 60, 28)];
        goBackButton.buttonStyle = AKButtonStyleNavBackButton;
        goBackButton.target = self;
        goBackButton.action = @selector(goBackButtonClicked:);
        goBackButton.title = @"Back";


        [leftControls insertObject:goBackButton atIndex:0];
        
        tabViewController.leftControls = leftControls;
    
    }
    
    //设置新加进来的View的尺寸和位置
    viewController.view.frame = self.view.bounds;
    //设置View的宽度和高度为自动调整
    [viewController.view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    //把新的View添加到当前的View中
    [self.view addSubview:viewController.view];
    

    [viewControllerArray addObject:viewController];
    
//    NSArray *newViewControllerArray = [[NSArray alloc] initWithObjects:viewController, nil];
//    [viewArray addObject:newViewControllerArray];
    
    [self setupTitleBarForViewController:viewController];
    
    //告诉Delegate有转到新的View了
    if(self.delegate){
        [self.delegate tabViewController:self goToNewViewOfController:viewController];
    }

    if([viewController isKindOfClass:[AKTabViewController class]]){
        AKTabViewController *tabViewController = (AKTabViewController *)viewController;
        [tabViewController tabDidActived];

    }
    //NSLog(@"YA, I AM GOING TO THE NEW VIEW OF %@",viewController.className);

}


@end
