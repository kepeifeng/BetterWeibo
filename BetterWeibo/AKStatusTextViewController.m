//
//  AKStatusTextViewController.m
//  controlLabs
//
//  Created by Kent on 14-1-12.
//  Copyright (c) 2014年 Kent. All rights reserved.
//

#import "AKStatusTextViewController.h"
#import "AKNameSenceViewController.h"

@interface AKStatusTextViewController ()

@end

@implementation AKStatusTextViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}


-(void)atKeyPressed:(id)textView position:(NSRect)atPosition{

    
    [[AKNameSenceViewController sharedInstance] displayNameSenceForView:textView relativeToRect:atPosition];
//    [self _makePopoverIfNeeded];
    

}


@end
