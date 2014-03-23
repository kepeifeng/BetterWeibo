//
//  AKButton.h
//  controlLabs
//
//  Created by Kent on 14-2-24.
//  Copyright (c) 2014年 Kent. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSInteger, AKButtonStyle){

    AKButtonStyleDarkButton,
    AKButtonStyleBlueButton,
    AKButtonStyleRedButton,
    AKButtonStyleGrayButton,
    AKButtonStyleNavBackButton
    

};

@interface AKButtonCell : NSButtonCell

@property (nonatomic) AKButtonStyle buttonCellStyle;

@end
