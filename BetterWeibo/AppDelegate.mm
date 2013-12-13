//
//  AppDelegate.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-28.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AppDelegate.h"
#import "AKMentionViewController.h"
#import "AKMessageViewController.h"
#import "AKBlockViewController.h"
#import "AKUserManager.h"

@implementation AppDelegate{

    
#pragma mark - Private Variable
    NSView *titleBarCustomView;
    AKWeiboManager * weiboManager;
    NSMutableData *receivedData;
    AKUserManager *userManager;
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    //INITIALIZING TITLE BAR
    [self setupTitleBar];
    [self setupTabController];
    
    
    weiboManager = [[AKWeiboManager alloc]initWithClientID:@"1672616342"
                                                 appSecret:@"57663124f7eb21e1207a2ee09fed507b"
                                               redirectURL:@"http://coffeeandsandwich.com/pinwheel/authorize.php"];
    
    userManager = [AKUserManager defaultUserManager];
    
    [weiboManager addMethodActionObserver:self selector:@selector(weiboManagerMethodActionHandler:)];


    //Regist event handler for Login Callback
    NSAppleEventManager *eventManager = [NSAppleEventManager sharedAppleEventManager];
    [eventManager setEventHandler:self andSelector:@selector(getAuthCode:withReplyEvent:) forEventClass:kInternetEventClass andEventID:kAEGetURL];
    [eventManager setEventHandler:self andSelector:@selector(getAuthCode:withReplyEvent:) forEventClass:'WWW!' andEventID:'OURL'];
    

    
    //Set tab view's delegator to this class.
    tabView.delegate = self;
    
    NSArray *userProfileArray = [userManager allAccessTokens];
    
    if(userProfileArray && userProfileArray.count>0){
    
        //Load Users
        [self.loginView setHidden:YES];
        
        //NSArray *userProfileArray = [[AKUserManager defaultUserManager]getAllUserProfile];
        
        for(AKAccessTokenObject *accessToken in userProfileArray){
        
            [tabView addControlGroup:accessToken.userID];
            //[weiboManager addUser:accessToken];
            [weiboManager getUserDetail:accessToken.userID];
        
        }
        
    }
    else{
    
        //Display Login View

        [self.loginView setHidden:NO];

    }
    
    
    
    //NSUserDefault.NSConstraintBasedLayoutVisualizeMutuallyExclusiveConstraints = YES;
    
}

//微博请求处理
-(void)weiboManagerMethodActionHandler:(NSNotification *)notification{

    NSDictionary *userInfoDictionary = notification.userInfo;
    AKMethodAction methodAction = [(AKMethodActionObject *)[userInfoDictionary objectForKey:@"methodOption"] methodAction];
    AKParsingObject *result = (AKParsingObject *)[userInfoDictionary objectForKey:@"result"];
    
    NSString *userID = [userManager getUserIDByAccessToken:result.accessToken];
    
    if(methodAction == AKWBOPT_OAUTH2_ACCESS_TOKEN){
    
        [self.loginView setHidden:YES];
        
        AKAccessTokenObject *accessTokenObject  = [AKWeiboManager getAccessTokenFromParsingObject:result];
        //把AccessToken保存到UserManager和磁盘中
        [userManager updateUserAccessToken:accessTokenObject];

        //在tabView中，建立该用户的UI
        if(![tabView isUserExist:accessTokenObject.userID]){
        
            [tabView addControlGroup:accessTokenObject.userID];
        
        }
        
        //向服务器索要用户的资料
        [weiboManager getUserDetail:accessTokenObject.userID];
        
        

    }
    else if (methodAction == AKWBOPT_GET_USERS_SHOW){
    
        //TODO:update user button icon
        AKUserProfile *userProfile = (AKUserProfile *)[userInfoDictionary objectForKey:@"userProfile"];
        
        //如果拿到资料的这个用户是本程序的用户，则更新到UserManager，并保存到硬盘
        if([userManager isAppUser:userProfile.IDString]){
            [userManager updateUserProfile:userProfile];
            [tabView updateUser:userProfile];
            
        }

    
    }
    else if (methodAction == AKWBOPT_GET_STATUSES_HOME_TIMELINE || methodAction == AKWBOPT_GET_STATUSES_MENTIONS || methodAction == AKWBOPT_GET_STATUSES_PUBLIC_TIMELINE || methodAction == AKWBOPT_GET_FAVORITES){
        
        AKWeiboTimelineType timelineType;
        switch (methodAction) {
            case AKWBOPT_GET_STATUSES_HOME_TIMELINE:
                timelineType = AKFriendsTimeline;
                break;
                
            case AKWBOPT_GET_STATUSES_MENTIONS:
                timelineType = AKMentionTimeline;
                break;
                
            case AKWBOPT_GET_STATUSES_PUBLIC_TIMELINE:
                timelineType = AKPublicTimeline;
                break;
            case AKWBOPT_GET_FAVORITES:
                timelineType = AKFavoriteTimeline;
                break;
                
            default:
                return;
                break;
        }
        
        
        NSArray *statusesArray = [userInfoDictionary objectForKey:@"statuses"];
        [tabView addStatuses:statusesArray timelineType:timelineType forUser:userID];
    
    }
    
}

-(void)getAvartaForUser:(NSString *)userID URL:(NSURL *)url{

    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    receivedData = [[NSMutableData alloc]init];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    
    if (!connection) {
        receivedData = nil;
    }
    
    

}


-(BOOL)existUsers{

    return [[AKUserManager defaultUserManager] hasUserExisted];
    //return NO;

}

-(void)setupTitleBar{

    
    self.windowControllers = [NSMutableArray array];
    self.window.backgroundColor = [NSColor blackColor];
    // The class of the window has been set in INAppStoreWindow in Interface Builder
    self.window.trafficLightButtonsLeftMargin = 12.0;
    self.window.fullScreenButtonRightMargin = 7.0;
    self.window.centerFullScreenButton = YES;
    self.window.titleBarHeight = 46.0;
    self.window.verticallyCenterTitle = YES;
    self.window.titleTextLeftMargin = 23.0;
    self.window.titleTextColor = [NSColor colorWithCalibratedWhite:0.88 alpha:1];
    self.window.titleBarDrawingBlock = ^(BOOL drawsAsMainWindow, CGRect drawingRect, CGPathRef clippingPath) {
        
        NSImage *windowImage ;
        
        
        CGContextRef ctx = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
        CGContextAddPath(ctx, clippingPath);
        CGContextClip(ctx);
        
        //        NSGradient *gradient = nil;
        if (drawsAsMainWindow) {
            windowImage = [NSImage imageNamed:@"window_normal.png"];
            //gradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedRed:0 green:0.319 blue:1 alpha:1]
            //                                       endingColor:[NSColor colorWithCalibratedRed:0 green:0.627 blue:1 alpha:1]];
            //[[NSColor darkGrayColor] setFill];
        } else {
            
            windowImage = [NSImage imageNamed:@"window_outoffocus.png"];
            // set the default non-main window gradient colors
            //
        }
        
        
        //Drawing Title Bar's Middle Part
        [windowImage drawInRect:drawingRect fromRect:NSMakeRect(82, 42, 82, 46) operation:NSCompositeSourceOver fraction:1];
        
        //Drawing Title Bar's Left Part
        [windowImage drawInRect:NSMakeRect(0, 0, 82, 46) fromRect:NSMakeRect(0, 42, 82, 46) operation:NSCompositeSourceOver fraction:1];
        
        //Drawing Title Bar's Right Part
        [windowImage drawInRect:NSMakeRect(drawingRect.size.width - 7, 0, 7, 46) fromRect:NSMakeRect(165, 42, 7, 46) operation:NSCompositeSourceOver fraction:1];
        
    };
    
    titleBarCustomView = [[NSView alloc]init];
    
    [self.window.titleBarView addSubview:titleBarCustomView];
    [titleBarCustomView setFrame:NSMakeRect(82, 0, (self.window.titleBarView.bounds.size.width - 82), self.window.titleBarView.bounds.size.height)];
    [titleBarCustomView setAutoresizingMask:NSViewWidthSizable];
    
//    NSButton * titleButton = [[NSButton alloc]init];
//    titleButton.title = @"Click";
//    [titleBarCustomView addSubview:titleButton];
//    [titleButton setFrame:NSMakeRect(5, (titleBarCustomView.bounds.size.height - 36)/2, 80, 36)];
//    [titleButton setAutoresizingMask:NSViewMaxXMargin];
    
    
    
    self.window.showsTitle = YES;
    [self setupCloseButton];
    [self setupMinimizeButton];
    [self setupZoomButton];
    

}

-(void)setupTabController{


    
    


}




- (void)setupCloseButton {
    INWindowButton *closeButton = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
    closeButton.activeImage = [NSImage imageNamed:@"close-active-color.tiff"];
    closeButton.activeNotKeyWindowImage = [NSImage imageNamed:@"close-activenokey-color.tiff"];
    closeButton.inactiveImage = [NSImage imageNamed:@"close-inactive-disabled-color.tiff"];
    closeButton.pressedImage = [NSImage imageNamed:@"close-pd-color.tiff"];
    closeButton.rolloverImage = [NSImage imageNamed:@"close-rollover-color.tiff"];
    self.window.closeButton = closeButton;
}

- (void)setupMinimizeButton {
    INWindowButton *button = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
    button.activeImage = [NSImage imageNamed:@"minimize-active-color.tiff"];
    button.activeNotKeyWindowImage = [NSImage imageNamed:@"minimize-activenokey-color.tiff"];
    button.inactiveImage = [NSImage imageNamed:@"minimize-inactive-disabled-color.tiff"];
    button.pressedImage = [NSImage imageNamed:@"minimize-pd-color.tiff"];
    button.rolloverImage = [NSImage imageNamed:@"minimize-rollover-color.tiff"];
    self.window.minimizeButton = button;
}

- (void)setupZoomButton {
    INWindowButton *button = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
    button.activeImage = [NSImage imageNamed:@"zoom-active-color.tiff"];
    button.activeNotKeyWindowImage = [NSImage imageNamed:@"zoom-activenokey-color.tiff"];
    button.inactiveImage = [NSImage imageNamed:@"zoom-inactive-disabled-color.tiff"];
    button.pressedImage = [NSImage imageNamed:@"zoom-pd-color.tiff"];
    button.rolloverImage = [NSImage imageNamed:@"zoom-rollover-color.tiff"];
    self.window.zoomButton = button;
}

-(void)getAuthCode:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent{

    NSString *url = [[event paramDescriptorForKeyword:keyDirectObject]stringValue];
    NSString *code = [url substringFromIndex:[@"pinwheel://" length]];
    
    //Verfy Code Here.
    
    //Get access token.
    [weiboManager setOauth2Code:code];
    
    
    
    //NSLog(@"Code = %@",code);

}



- (IBAction)loginButtonClicked:(id)sender {
    

    [weiboManager startOauthLogin];
}

- (IBAction)addAccountClicked:(id)sender {
    
    [weiboManager startOauthLogin];
    
    
}

#pragma mark - Connection Delegate

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse object.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    [receivedData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didreceivedData:(NSData *)data{
    // Append the new data to receivedData.
    [receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    // Release the connection and the data object
    // by setting the properties (declared elsewhere)
    // to nil.  Note that a real-world app usually
    // requires the delegate to manage more than one
    // connection at a time, so these lines would
    // typically be replaced by code to iterate through
    // whatever data structures you are using.
    connection = nil;
    receivedData = nil;
    
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);

}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{

    // do something with the data

    
    NSLog(@"Succeeded! Received %lu bytes of data",(unsigned long)[receivedData length]);
    
    // Release the connection and the data object
    // by setting the properties (declared elsewhere)
    // to nil.  Note that a real-world app usually
    // requires the delegate to manage more than one
    // connection at a time, so these lines would
    // typically be replaced by code to iterate through
    // whatever data structures you are using.
    connection = nil;
    receivedData = nil;
    
}

#pragma mark - Tab Control

-(void)WeiboViewRequestForStatuses:(AKWeiboViewController *)weiboViewController forUser:(NSString *)userID sinceWeiboID:(NSString *)sinceWeiboID maxWeiboID:(NSString *)maxWeiboID count:(int)count page:(int)page baseApp:(BOOL)baseApp feature:(int)feature trimUser:(int)trimUser{

    [weiboManager getStatusForUser:userID sinceWeiboID:sinceWeiboID maxWeiboID:maxWeiboID count:count page:page baseApp:baseApp feature:feature trimUser:trimUser timelineType:weiboViewController.timelineType];


}

-(void)WeiboViewRequestForGroupStatuses:(AKWeiboViewController *)weiboViewController listID:(NSString *)listID sinceWeiboID:(NSString *)sinceWeiboID maxWeiboID:(NSString *)maxWeiboID count:(int)count page:(int)page baseApp:(BOOL)baseApp feature:(int)feature trimUser:(int)trimUser{


}

-(void)viewDidSelected:(AKTabViewController *)viewController{

    if(viewController.title){
    
        [self.window setTitle:viewController.title];
        
    }

}

// connection:didReceiveResponse:, connection:didreceivedData:, connection:didFailWithError:, and connectionDidFinishLoading:

@end
