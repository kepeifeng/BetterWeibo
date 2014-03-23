//
//  AKUserButton.m
//  BetterWeibo
//
//  Created by Kent on 13-12-10.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKUserButton.h"


@interface AKUserButton()

@property (readonly) AKUserButtonCell * userButtonCell;

@end

@implementation AKUserButton{

    NSMutableArray *_observedVisibleItems;
}

//@synthesize avatarURL = _avatarURL;
//@synthesize avatarImage = _avatarImage;
@synthesize userProfile = _userProfile;
@synthesize borderType = _borderType;
//@synthesize image = _userAvatarImage;

-(void)dealloc{
    for (AKUserProfile *userProfile in _observedVisibleItems) {
        [userProfile removeObserver:self forKeyPath:AKUserProfilePropertyNamedProfileImage];
    }
}
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        _defaultAvatarImage = [NSImage imageNamed:@"avatar_default.png"];
        _topLayerImage = [NSImage imageNamed:@"avatar_outline"];
        
        [self setBordered:NO];
        [self setButtonType:NSMomentaryChangeButton];
        [self setImagePosition:NSImageOnly];
        [self setFocusRingType:NSFocusRingTypeNone];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        
        _defaultAvatarImage = [NSImage imageNamed:@"avatar_default.png"];
        _topLayerImage = [NSImage imageNamed:@"avatar_outline"];
        [self setCell:[AKUserButtonCell new]];
        [self setBorderType:[aDecoder decodeIntegerForKey:@"borderType"]];
        [self setBordered:NO];
        [self setButtonType:NSMomentaryChangeButton];
        [self setImagePosition:NSImageOnly];
        [self setFocusRingType:NSFocusRingTypeNone];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    [aCoder encodeInteger:self.borderType forKey:@"borderType"];
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(BOOL)isFlipped{
    return NO;
}
#pragma mark - Properties

//-(NSString *)avatarURL{
//
//    return _avatarURL;
//
//}
//
//-(void)setAvatarURL:(NSString *)avatarURL{
//
//    _avatarURL = avatarURL;
//    if(avatarURL){
//        NSImage *avatarImage = [[NSImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:avatarURL]]];
//        self.avatarImage = avatarImage;
//    }
//    
//    
//}
//
//-(NSImage *)avatarImage{
//
//    return _avatarImage;
//
//}

-(AKUserProfile *)userProfile{
    return _userProfile;
}

-(void)setUserProfile:(AKUserProfile *)userProfile{
    
    _userProfile = userProfile;
    
    if (_observedVisibleItems == nil) {
        _observedVisibleItems = [NSMutableArray new];
    }
    if (![_observedVisibleItems containsObject:userProfile]) {
        [userProfile addObserver:self forKeyPath:AKUserProfilePropertyNamedProfileImage options:0 context:NULL];
        [userProfile loadAvatarImages];
        [_observedVisibleItems addObject:userProfile];
    }
    
    if(userProfile.profileImage){
        self.image = userProfile.profileImage;
    }
    else{
        self.image = [AKUserProfile defaultAvatarImage];
    }

}

//-(NSImage *)image{
//    return _userAvatarImage;
//}
//-(void)setImage:(NSImage *)image{
//    _userAvatarImage = image;
//    [super setImage:[self imageWithBorderFrom:_userAvatarImage]];
//    
//}

//-(NSImage *)imageWithBorderFrom:(NSImage *)image{
//
//    NSImage *_imageWithBorder;
//    
//    switch (self.borderType) {
//        case AKUserButtonBorderTypeNone:
//            _imageWithBorder = image;
//            break;
//            
//        case AKUserButtonBorderTypeGlassOutline:
//            _imageWithBorder = [self getGlassOutlineTypeImageFrom:image];
//            break;
//            
//        case AKUserButtonBorderTypeBezel:
//            _imageWithBorder = [self getBezelTypeImageFrom:image];
//        default:
//            break;
//    }
//    
//    return _imageWithBorder;
//
//}


////带有黑色玻璃边框的图片
//-(NSImage *)getGlassOutlineTypeImageFrom:(NSImage *)image{
//
//    NSImage *avatarWithOutline = [[NSImage alloc] initWithSize:NSMakeSize(48, 49)];
//    
//    [avatarWithOutline lockFocus];
//    NSRect avatarRect = NSMakeRect(6, 6, 36, 36);
//    NSImage *avatarLayer = (image)?image:_defaultAvatarImage;
//    
//    [avatarLayer drawInRect:avatarRect fromRect:NSMakeRect(0, 0, avatarLayer.size.width, avatarLayer.size.height) operation:NSCompositeSourceOver fraction:1];
//    
//    NSRect topLayerRect = NSMakeRect(0, 0, 48, 49);
//    [_topLayerImage drawInRect:topLayerRect];
//    [avatarWithOutline unlockFocus];
//    
//    return avatarWithOutline;
//
//}

//
//-(NSImage *)getBezelTypeImageFrom:(NSImage *)image{
//
//    NSSize imageSize = image.size;
//    NSInteger roundedConnerRadius = imageSize.width / 10;
//    NSImage *bezelTypeImage = [[NSImage alloc] initWithSize:imageSize];
//    
//    NSRect drawingRect = NSMakeRect(0, 0, imageSize.width, imageSize.height);
//    
//    NSInteger shadowInsetWidth = 5;
//    NSRect shadowRect = NSInsetRect(drawingRect, -shadowInsetWidth, -shadowInsetWidth);
//    ;    [bezelTypeImage lockFocus];
//    NSColor *strokeColor = [NSColor colorWithCalibratedWhite:0.6 alpha:1];
//    
//    NSBezierPath *roundedRect = [NSBezierPath bezierPathWithRoundedRect:drawingRect xRadius:roundedConnerRadius yRadius:roundedConnerRadius];
//    NSBezierPath *roundedShadowRect = [NSBezierPath bezierPathWithRoundedRect:shadowRect xRadius:roundedConnerRadius+shadowInsetWidth yRadius:roundedConnerRadius+shadowInsetWidth];
//    
//    [NSGraphicsContext saveGraphicsState];
//    
//    [roundedRect setClip];
//    [image drawInRect:drawingRect];
//    [strokeColor setStroke];
//    NSShadow * shadow = [[NSShadow alloc] init];
//    [shadow setShadowColor:[NSColor colorWithCalibratedWhite:0 alpha:0.5]];
//    [shadow setShadowBlurRadius:shadowInsetWidth];
//    [shadow setShadowOffset:NSMakeSize(shadowInsetWidth+1,-shadowInsetWidth-1)];
//    [shadow set];
//    [roundedShadowRect setLineWidth:shadowInsetWidth*2];
//    [roundedShadowRect stroke];
//    
//    [NSGraphicsContext restoreGraphicsState];
//    
//    [strokeColor setStroke];
//    [roundedRect setLineWidth:1];
//    [roundedRect stroke];
//    
//    [bezelTypeImage unlockFocus];
//    
//    return bezelTypeImage;
//    
//
//}
//-(void)setAvatarImage:(NSImage *)avatarImage{
//
//    _avatarImage = avatarImage;
//    NSImage *avatarWithOutline = [[NSImage alloc] initWithSize:NSMakeSize(48, 49)];
//    
//    [avatarWithOutline lockFocus];
//    NSRect avatarRect = NSMakeRect(6, 6, 36, 36);
//    NSImage *avatarLayer = (_avatarImage)?_avatarImage:_defaultAvatarImage;
//    
//    [avatarLayer drawInRect:avatarRect fromRect:NSMakeRect(0, 0, avatarLayer.size.width, avatarLayer.size.height) operation:NSCompositeSourceOver fraction:1];
//    
//    NSRect topLayerRect = NSMakeRect(0, 0, 48, 49);
//    [_topLayerImage drawInRect:topLayerRect];
//    [avatarWithOutline unlockFocus];
//    
//    [super setImage:avatarWithOutline];
//    
//
//}

-(AKUserButtonCell *)userButtonCell{
    return (AKUserButtonCell *)self.cell;
}

-(AKUserButtonBorderType)borderType{
    return self.userButtonCell.borderType;
}

-(void)setBorderType:(AKUserButtonBorderType)borderType{
//    _borderType = borderType;
    [self.userButtonCell setBorderType:borderType];
    
}




- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:AKUserProfilePropertyNamedProfileImage]) {
        // Find the row and reload it.
        // Note that KVO notifications may be sent from a background thread (in this case, we know they will be)
        // We should only update the UI on the main thread, and in addition, we use NSRunLoopCommonModes to make sure the UI updates when a modal window is up.
        [self performSelectorOnMainThread:@selector(_reloadImage:) withObject:object waitUntilDone:NO modes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    }
}

-(void)_reloadImage:(id)object{
    AKUserProfile *userProfile = object;
    if(self.userProfile == userProfile){
        self.image = userProfile.profileImage;
    }
}

+(Class)cellClass{
    
    return [AKUserButtonCell class];
    
}


@end
