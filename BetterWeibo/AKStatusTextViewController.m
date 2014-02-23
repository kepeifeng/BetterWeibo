//
//  AKStatusTextViewController.m
//  controlLabs
//
//  Created by Kent on 14-1-12.
//  Copyright (c) 2014年 Kent. All rights reserved.
//

#import "AKStatusTextViewController.h"


@interface AKStatusTextViewController ()

@end

@implementation AKStatusTextViewController
{
    
    AKNameSenceViewController *_nameSenceViewController;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

-(void)awakeFromNib{
    
    _nameSenceViewController = [[AKNameSenceViewController alloc] init];
    _nameSenceViewController.delegate = self;
}

-(void)nameSenceViewController:(AKNameSenceViewController *)nameSenceViewController userDidSelected:(NSString *)user{
    
    
    [[(NSTextView *)self.view textStorage] appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ",user]]];
    [_nameSenceViewController closeNameSence];
    
    
}

-(void)atKeyPressed:(id)textView position:(NSRect)atPosition{
    
    [_nameSenceViewController displayNameSenceForView:textView relativeToRect:atPosition];
    
    //[[AKNameSenceViewController sharedInstance] displayNameSenceForView:textView relativeToRect:atPosition];
    //    [self _makePopoverIfNeeded];
    
    
}


@end
