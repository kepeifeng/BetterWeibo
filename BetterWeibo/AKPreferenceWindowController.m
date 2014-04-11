//
//  AKPreferenceWindowController.m
//  BetterWeibo
//
//  Created by Kent on 14-3-24.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKPreferenceWindowController.h"

#import "AKWeiboManager.h"
#import "MASShortcutView+UserDefaults.h"
#import "MASShortcut+UserDefaults.h"
#import "MASShortcut+Monitoring.h"

NSString *const AKPreferenceKeyShortcutNewStatus = @"keyShortcutNewStatus";

@interface AKPreferenceWindowController ()

@property (readonly) AKUserManager *userManager;

@end

@implementation AKPreferenceWindowController{

    NSMutableArray *_observedObjects;
    

}

@synthesize statusShortcutView = _statusShortcutView;
//@dynamic window;

- (instancetype)init
{
    self = [super initWithWindowNibName:@"AKPreferenceWindowController" owner:self];
    if (self) {
        [self.userManager addListener:self];
    }
    return self;
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    self.statusShortcutView.associatedUserDefaultsKey = AKPreferenceKeyShortcutNewStatus;
    //[self setupTitleBar];
//    self.tabView.toolbar.displayMode = NSToolbarDisplayModeIconOnly;
}

-(void)awakeFromNib{
    
//    self.tabView.layout = DASelectableToolbarLayoutCentered;
    
}
//
//-(void)setupTitleBar{
//    
//    
//    self.windowControllers = [NSMutableArray array];
//    self.window.backgroundColor = [NSColor blackColor];
//    // The class of the window has been set in INAppStoreWindow in Interface Builder
//    self.window.trafficLightButtonsLeftMargin = 12.0;
//    self.window.fullScreenButtonRightMargin = 7.0;
//    self.window.centerFullScreenButton = YES;
//    self.window.titleBarHeight = 78.0;
//    self.window.verticallyCenterTitle = NO;
//    self.window.verticalTrafficLightButtons = NO;
//    self.window.titleTextLeftMargin = 23.0;
//    self.window.titleTextColor = [NSColor colorWithCalibratedWhite:0.88 alpha:1];
//    NSShadow *shadow = [[NSShadow alloc] init];
//    shadow.shadowBlurRadius = 0;
//    shadow.shadowColor = [NSColor blackColor];
//    shadow.shadowOffset = NSMakeSize(-1, 1);
//    self.window.titleTextShadow = shadow;
//    self.window.titleBarDrawingBlock = ^(BOOL drawsAsMainWindow, CGRect drawingRect, CGPathRef clippingPath) {
//        
//        NSImage *windowImage ;
//        
//        
//        CGContextRef ctx = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
//        CGContextAddPath(ctx, clippingPath);
//        CGContextClip(ctx);
//        
//        //        NSGradient *gradient = nil;
//        if (drawsAsMainWindow) {
//            windowImage = [NSImage imageNamed:@"pref-window.png"];
//
//        } else {
//            
//            windowImage = [NSImage imageNamed:@"pref-window-deactive.png"];
//
//        }
//        
//        
//        NSInteger y = windowImage.size.height - self.window.titleBarHeight;
//        
//        //Drawing Title Bar's Middle Part
//        [windowImage drawInRect:drawingRect fromRect:NSMakeRect(82, y, 83, self.window.titleBarHeight) operation:NSCompositeSourceOver fraction:1];
//        
//        //Drawing Title Bar's Left Part
//        [windowImage drawInRect:NSMakeRect(0, 0, 80, self.window.titleBarHeight) fromRect:NSMakeRect(0, y, 80, self.window.titleBarHeight) operation:NSCompositeSourceOver fraction:1];
//        
//        //Drawing Title Bar's Right Part
//        [windowImage drawInRect:NSMakeRect(drawingRect.size.width - 7, 0, 7, self.window.titleBarHeight) fromRect:NSMakeRect(165, y, 7, self.window.titleBarHeight) operation:NSCompositeSourceOver fraction:1];
//        
//    };
//    
//    self.window.showsTitle = YES;
//    [self setupCloseButton];
//    [self setupMinimizeButton];
//    [self setupZoomButton];
//    
//    
//}
//
//
//- (void)setupCloseButton {
//    INWindowButton *closeButton = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
//    closeButton.activeImage = [NSImage imageNamed:@"close-active-color.tiff"];
//    closeButton.activeNotKeyWindowImage = [NSImage imageNamed:@"close-activenokey-color.tiff"];
//    closeButton.inactiveImage = [NSImage imageNamed:@"close-inactive-disabled-color.tiff"];
//    closeButton.pressedImage = [NSImage imageNamed:@"close-pd-color.tiff"];
//    closeButton.rolloverImage = [NSImage imageNamed:@"close-rollover-color.tiff"];
//    
//    self.window.closeButton = closeButton;
//    //
//    //    closeButton.target = self;
//    //    closeButton.action = @selector(closeButtonClicked:);
//}
//- (void)setupMinimizeButton {
//    INWindowButton *button = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
//    button.activeImage = [NSImage imageNamed:@"minimize-active-color.tiff"];
//    button.activeNotKeyWindowImage = [NSImage imageNamed:@"minimize-activenokey-color.tiff"];
//    button.inactiveImage = [NSImage imageNamed:@"minimize-inactive-disabled-color.tiff"];
//    button.pressedImage = [NSImage imageNamed:@"minimize-pd-color.tiff"];
//    button.rolloverImage = [NSImage imageNamed:@"minimize-rollover-color.tiff"];
//    self.window.minimizeButton = button;
//}
//
//- (void)setupZoomButton {
//    INWindowButton *button = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
//    button.activeImage = [NSImage imageNamed:@"zoom-active-color.tiff"];
//    button.activeNotKeyWindowImage = [NSImage imageNamed:@"zoom-activenokey-color.tiff"];
//    button.inactiveImage = [NSImage imageNamed:@"zoom-inactive-disabled-color.tiff"];
//    button.pressedImage = [NSImage imageNamed:@"zoom-pd-color.tiff"];
//    button.rolloverImage = [NSImage imageNamed:@"zoom-rollover-color.tiff"];
//    self.window.zoomButton = button;
//}


-(AKUserManager *)userManager{
    return [AKUserManager defaultUserManager];
}


- (IBAction)toolbarItemClicked:(id)sender {
    //NSLog(@"toolbarItemClicked");
    NSToolbarItem *toolbarItem = sender;
    [self.tabView selectTabViewItemAtIndex:toolbarItem.tag];
    
}

#pragma mark - Table View Delegate

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return self.userManager.allUserProfiles.count;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    NSTableCellView *cell = [self.userTableView makeViewWithIdentifier:@"userItem" owner:self];
    
    AKUserProfile *userProfile = [self.userManager userAtIndex:row];
    cell.textField.stringValue = (userProfile.screen_name)?userProfile.screen_name:@"(空)";
    
    if(!_observedObjects){
        _observedObjects = [NSMutableArray new];
        
    }
    
    if(![_observedObjects containsObject:userProfile]){
        [userProfile addObserver:self forKeyPath:AKUserProfilePropertyNamedProfileImage options:0 context:NULL];
        [userProfile addObserver:self forKeyPath:AKUserProfilePropertyNamedScreenName options:0 context:NULL];
        [_observedObjects addObject: userProfile];
    }
    
    cell.imageView.image = userProfile.profileImage;
    
    
    
    
    return cell;
}

- (IBAction)userModifyControlClicked:(id)sender {
    
    NSSegmentedControl *control = sender;
//    NSSegmentedCell *clickedCell = control.selectedCell;
    NSInteger selectedCellIndex = control.selectedSegment;
    if(selectedCellIndex == 0){
        //Add User
        [[AKWeiboManager currentManager] startOauthLogin];
        
    }
    else if (selectedCellIndex == 1){
    
        //Remove User
        NSInteger selectedUserIndex = self.userTableView.selectedRow;
        [self.userManager removeUserAtIndex:selectedUserIndex];
        
//        [self.userTableView reloadData];
    }
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if([keyPath isEqualToString:AKUserProfilePropertyNamedProfileImage]){
        [self performSelectorOnMainThread:@selector(_reloadRowForEntity:) withObject:object waitUntilDone:NO];
        
    }else if([keyPath isEqualToString:AKUserProfilePropertyNamedScreenName]){
        [self performSelectorOnMainThread:@selector(_reloadRowForEntity:) withObject:object waitUntilDone:NO];
    }
}

- (void)_reloadRowForEntity:(id)object {
    NSInteger row = [self.userManager indexOfUserProfile:object];
    if (row != NSNotFound) {
        AKUserProfile *entity = object;
        NSTableCellView *cellView = [self.userTableView viewAtColumn:0 row:row makeIfNecessary:NO];
        if (cellView && cellView.objectValue == object) {
            
            cellView.imageView.image = entity.profileImage;
            cellView.textField.stringValue = (entity.screen_name)?entity.screen_name:@"(空)";
        }
    }
}


#pragma mark - User Manager Listener

-(void)userProfileDidInserted:(AKUserProfile *)userProfile atIndex:(NSInteger)index{
    
    [self.userTableView reloadData];
}

-(void)userProfileDidRemoved:(AKUserProfile *)userProfile atIndex:(NSInteger)index{

    [self.userTableView reloadData];
}

-(void)userProfileDidUpdated:(AKUserProfile *)userProfile atIndex:(NSInteger)index{
    
    [self.userTableView reloadData];
    
}

@end
