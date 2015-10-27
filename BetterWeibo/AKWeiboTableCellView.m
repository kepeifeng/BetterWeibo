//
//  AKWeiboTableCellView.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-9-30.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKWeiboTableCellView.h"
#import "NS(Attributed)String+Geometrics.h"
#import "AKImageViewer.h"
#import "AKViewConstant.h"
#import "AKImageHelper.h"
#import "INPopoverController.h"
#import "AKPopupStatusEditorViewController.h"
#import "FlippedView.h"
#import "AKImageButtonCell.h"
#import "AKWeiboStatusControlView.h"

@interface AKWeiboTableCellView()

@property (readonly)INPopoverController *popoverStatusEditior;

@end

@implementation AKWeiboTableCellView{

    NSTrackingArea *trackingArea;
    AKImageViewer *_imageViewer;
    
    NSMenu *_shareButtonContextMenu;
    
//    NSView * _weiboView;

}

@synthesize hasRepostedWeibo = _hasRepostedWeibo;
@synthesize weiboTextField = _weiboTextField;
@synthesize status = _status;
@synthesize thumbnailImageURL = _thumbnailImageURL;
static INPopoverController *gPopoverController;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.userImage.borderType = AKUserButtonBorderTypeBezel;
        [self initialSetup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if(self){
        self.userImage.borderType = AKUserButtonBorderTypeBezel;
    }
    return self;
}

-(void)initialSetup{
    
    _repostedWeiboView = [[AKRepostedWeiboView alloc] initWithFrame:self.bounds];
    [self addSubview:_repostedWeiboView];
    
    _weiboView = [[FlippedView alloc] initWithFrame:self.bounds];
    
    [self addSubview:_weiboView];
    
    _userImage = [[AKUserButton alloc] initWithFrame:NSMakeRect(USER_AVATAR_MARGIN_LEFT, 0, USER_AVATAR_SIZE, USER_AVATAR_SIZE)];
    [_weiboView addSubview:_userImage];
    
    _userAlias = [[NSTextField alloc] initWithFrame:NSMakeRect(CGRectGetMaxX(_userImage.frame) + USER_AVATAR_MARGIN_RIGHT, 0, 200, 20)];
    _userAlias.bordered = NO;
    _userAlias.drawsBackground = NO;
    _userAlias.editable = NO;
    [_weiboView addSubview:_userAlias];
    
    AKTextView * textField = [[AKTextView alloc] initWithFrame:NSMakeRect(CGRectGetMaxX(_userImage.frame) + USER_AVATAR_MARGIN_RIGHT,
                                                                          CGRectGetMaxY(_userAlias.frame) + 5,
                                                                          CGRectGetWidth(_weiboView.frame) - (CGRectGetMaxX(_userImage.frame) + USER_AVATAR_MARGIN_RIGHT + STATUS_MARGIN_RIGHT),
                                                                          50)];
    textField.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    textField.drawsBackground = NO;
    self.weiboTextField = textField;
    
    [_weiboView addSubview:textField];
    
    self.userImage.borderType = AKUserButtonBorderTypeBezel;
    [self.weiboTextField setDrawsBackground:NO];
    [self.weiboTextField setEditable:NO];
    [self.weiboTextField setSelectable:YES];
//    self.weiboTextField.bordered = NO;
    self.weiboTextField.font = [NSFont systemFontOfSize:14.0f];
    
    
    _images = [[NSMatrix alloc] initWithFrame:NSMakeRect(0, 0, 140, 140) mode:NSRadioModeMatrix cellClass:[AKImageButtonCell class] numberOfRows:3 numberOfColumns:3];
    _images.hidden = YES;
    [_weiboView addSubview:_images];
    
    
    _toolbar = [[AKWeiboStatusControlView alloc] init];
    _toolbar.target = self;
    _toolbar.action = @selector(toolbarClicked:);
    [self addSubview:_toolbar];
    
    if(!_shareButtonContextMenu){
        _shareButtonContextMenu = [[NSMenu alloc] init];
        
        NSMenuItem *menuItem = [[NSMenuItem alloc]initWithTitle:@"复制微博" action:@selector(copyStatusMenuClicked:) keyEquivalent:@""];
        menuItem.target = self;
        [_shareButtonContextMenu addItem:menuItem];
        
        /*
         menuItem = [[NSMenuItem alloc] initWithTitle:@"在浏览器查看微博" action:@selector(openStatusInBrowser:) keyEquivalent:@""];
         menuItem.target = self;
         [_shareButtonContextMenu addItem:menuItem];
         */
        
        
    }
    
}


-(BOOL)isFlipped{
    return YES;
}

-(void)awakeFromNib{


}


- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
    
//    return;
    
    NSRect drawingRect = self.frame;
    
    CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
    
    //Top Line
//    NSPoint startPoint = NSMakePoint(0, drawingRect.size.height - 0.5);
//    NSPoint endPoint = NSMakePoint(drawingRect.size.width, drawingRect.size.height - 0.5);
//    
//    CGContextSetLineWidth(myContext, 1);
//    CGContextSetRGBStrokeColor(myContext, 1, 1, 1, 0.8);
//    CGContextMoveToPoint(myContext, startPoint.x, startPoint.y);
//    CGContextAddLineToPoint(myContext, endPoint.x, endPoint.y);
//    CGContextStrokePath(myContext);
    
    //Bottom Line
    NSPoint startPoint = NSMakePoint(0, 0.5);
    NSPoint endPoint = NSMakePoint(drawingRect.size.width, 0.5);
    
    CGContextSetLineWidth(myContext, 1);
    CGContextSetRGBStrokeColor(myContext, 0.5, 0.5, 0.5, 0.2);
    CGContextMoveToPoint(myContext, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(myContext, endPoint.x, endPoint.y);
    CGContextStrokePath(myContext);
	
    // Drawing code here.
}



-(AKWeiboStatus *)status{

    return _status;
    
}

-(void)setStatus:(AKWeiboStatus *)status{

    _status = status;

}


-(INPopoverController *)popoverStatusEditior{

    [self _makePopupPanelIfNeeded];
    return gPopoverController;
}

-(void)viewDidEndLiveResize{

    [super viewDidEndLiveResize];
   

//    [_weiboTextField siz]
    //[self resize];

}


-(BOOL)hasRepostedWeibo{

    return _hasRepostedWeibo;

}


-(void)setHasRepostedWeibo:(BOOL)hasRepostedWeibo{

    _hasRepostedWeibo = hasRepostedWeibo;
    
    [self.repostedWeiboView setHidden:!hasRepostedWeibo];
    

    //[self resize];

}


//
//-(void)prepareForReuse{
//
//
//    
//    [self.images setHidden:YES];
//    
//    for(NSButtonCell *cell in [self.images cells]){
//    
//        cell.image = nil;
//
//        
//    }
//    [super prepareForReuse];
//
//}



-(void)resizeSubviewsWithOldSize:(NSSize)oldSize{
    [super resizeSubviewsWithOldSize:oldSize];
    [self resize];
    

}

-(void)resize{
    
//    return;
    
    CGFloat repostedWeiboHeight;
    CGFloat weiboHeight;
    CGFloat repostedWeiboViewHeight;
    CGFloat weiboViewHeight;
    
    AKWeiboStatus *weibo = self.objectValue;
    
    assert(weibo);
    CGFloat cellHeight = [AKWeiboTableCellView caculateWeiboCellHeight:weibo forWidth:self.frame.size.width
                                                   repostedWeiboHeight:&repostedWeiboHeight
                                               repostedWeiboViewHeight:&repostedWeiboViewHeight
                                                           weiboHeight:&weiboHeight
                                                       weiboViewHeight:&weiboViewHeight];
    
    NSInteger y = weiboViewHeight;
    
    NSInteger repostY = 0;
    NSSize statusViewSize = self.frame.size;
    if(weibo.retweeted_status){
        
        repostY = self.repostedWeiboView.frame.size.height;
        NSSize repostedWeiboViewSize = statusViewSize;
        repostedWeiboViewSize.height = repostedWeiboViewHeight;
        
//        for(NSLayoutConstraint *constraint in self.repostedWeiboView.constraints){
//            if(constraint.firstAttribute == NSLayoutAttributeHeight){
//                constraint.constant = repostedWeiboViewHeight;
//            }
//        }
        
        [self.repostedWeiboView setFrameSize:repostedWeiboViewSize];
        [self.repostedWeiboView setFrameOrigin:NSMakePoint(0, 0)];
        
//        assert(self.repostedWeiboView.frame.size.height == repostedWeiboViewHeight);
    }
    
 

//    for(NSLayoutConstraint *constraint in self.weiboView.constraints){
//        if(constraint.firstAttribute == NSLayoutAttributeHeight){
//            constraint.constant = weiboViewHeight;
//        }
//    }
    
    //Favorite Mark
    NSPoint favoriteMarkOrigin = NSMakePoint(self.weiboView.frame.size.width - self.favMark.frame.size.width, weiboViewHeight - self.favMark.frame.size.height);;
    if(weibo.retweeted_status){
        
        favoriteMarkOrigin.y += 10;
        
    }
    [self.favMark setFrameOrigin:favoriteMarkOrigin];
    
    
    [self.weiboView setFrame:NSMakeRect(0, repostedWeiboViewHeight+10, self.frame.size.width, weiboViewHeight )];
    
    //update reposted weibo's user alias' origin.
//    [self.userAlias setFrameOrigin:NSMakePoint(self.userAlias.frame.origin.x,
//                                               weiboViewHeight - USER_ALIAS_HEIGHT - STATUS_MARGIN_TOP)];
    
    //Date Duration
//    [self.dateDuration setFrameOrigin:NSMakePoint(self.weiboView.frame.size.width - self.dateDuration.frame.size.width - STATUS_MARGIN_RIGHT, weiboViewHeight - USER_ALIAS_HEIGHT - STATUS_MARGIN_TOP)];
    
    //User Avatar
//    [self.userImage setFrameOrigin:NSMakePoint(self.userImage.frame.origin.x, weiboViewHeight - (self.userImage.frame.size.height - self.userAlias.frame.size.height) - USER_ALIAS_HEIGHT - STATUS_MARGIN_TOP)];
    


    
    //Weibo Text
    NSRect weiboTextFrame = self.weiboTextField.frame;
    weiboTextFrame.size.width = self.frame.size.width - USER_AVATAR_MARGIN_LEFT - USER_AVATAR_SIZE - USER_AVATAR_MARGIN_RIGHT - STATUS_MARGIN_RIGHT;
    weiboTextFrame.size.height = weiboHeight;
    self.weiboTextField.frame = weiboTextFrame;
//    for (NSLayoutConstraint *constraint in self.weiboTextField.constraints) {
////        NSLog(@"%@", constraint);
//        if(constraint.firstAttribute == NSLayoutAttributeHeight){
//            constraint.constant = weiboHeight;
//        }else if (constraint.firstAttribute == NSLayoutAttributeWidth){
//            constraint.constant = self.frame.size.width - USER_AVATAR_MARGIN_LEFT - USER_AVATAR_SIZE - USER_AVATAR_MARGIN_RIGHT - STATUS_MARGIN_RIGHT;
//        }else if(constraint.firstAttribute == NSLayoutAttributeBottom){
////            constraint.constant = weiboViewHeight - USER_ALIAS_HEIGHT - STATUS_MARGIN_TOP - STATUS_TEXT_MARGIN_TOP - self.weiboTextField.frame.size.height;
//        }
//    }
    
//    [self.weiboTextField setFrameSize:NSMakeSize(self.frame.size.width - USER_AVATAR_MARGIN_LEFT - USER_AVATAR_SIZE - USER_AVATAR_MARGIN_RIGHT - STATUS_MARGIN_RIGHT, weiboHeight)];
//    [self.weiboTextField adjustFrame];
//    [self.weiboTextField setFrameSize:self.weiboTextField.intrinsicContentSize];
    
    
//    [self.weiboTextField setFrameOrigin:NSMakePoint(self.weiboTextField.frame.origin.x, weiboViewHeight - USER_ALIAS_HEIGHT - STATUS_MARGIN_TOP - STATUS_TEXT_MARGIN_TOP - self.weiboTextField.frame.size.height)];
    

    //Images
    if(weibo.pic_urls && weibo.pic_urls.count>0){
        
        
        
        NSSize weiboImageMatrixSize;
        if(weibo.pic_urls.count ==1){
            
            weiboImageMatrixSize = NSMakeSize(LARGE_THUMBNAIL_SIZE, LARGE_THUMBNAIL_SIZE);
            
        }
        else{
            
            weiboImageMatrixSize = NSMakeSize(self.images.numberOfColumns * (SMALL_THUMBNAIL_SIZE+SMALL_THUMBNAIL_SPACING)-SMALL_THUMBNAIL_SPACING,
                                              ((NSInteger)((weibo.pic_urls.count+2)/3)) * (SMALL_THUMBNAIL_SIZE+SMALL_THUMBNAIL_SPACING)-SMALL_THUMBNAIL_SPACING);
            
        }
        
//        for (NSLayoutConstraint *constraint in self.images.constraints) {
//            if(constraint.firstAttribute == NSLayoutAttributeHeight){
//                constraint.constant = weiboImageMatrixSize.height;
//            }else if (constraint.firstAttribute == NSLayoutAttributeWidth){
//                constraint.constant = weiboImageMatrixSize.width;
//            }
//        }
        [self.images setFrameSize:weiboImageMatrixSize];
        [self.images setFrameOrigin:NSMakePoint(CGRectGetMaxX(self.userImage.frame) + USER_AVATAR_MARGIN_RIGHT, CGRectGetMaxY(weiboTextFrame)+10)];
    }
    

    [self.toolbar setFrameOrigin:NSMakePoint(self.weiboView.frame.size.width - self.toolbar.frame.size.width - 5, 5)];
    
}



+(CGFloat)caculateWeiboHeight:(AKWeiboStatus *)weibo forWidth:(CGFloat)width{

    CGFloat repostedWeiboHeight;
    CGFloat weiboHeight;
    CGFloat repostedWeiboViewHeigt;
    CGFloat weiboViewHeight;
    
    return [AKWeiboTableCellView caculateWeiboCellHeight:weibo forWidth:width repostedWeiboHeight:&repostedWeiboHeight repostedWeiboViewHeight:&repostedWeiboViewHeigt weiboHeight:&weiboHeight weiboViewHeight:&weiboViewHeight];

}

/**
 *  计算微博Cell的尺寸
 *
 *  @param weibo                   微博
 *  @param width                   表格宽度
 *  @param repostedWeiboHeight     转发微博微博文本的高度
 *  @param repostedWeiboViewHeight 转发微博框的高度
 *  @param weiboHeight             微博文本的高度
 *  @param weiboViewHeight         微博框的高度
 *
 *  @return Cell的高度
 */
+(CGFloat)caculateWeiboCellHeight:(AKWeiboStatus *)weibo
                         forWidth:(CGFloat)width
              repostedWeiboHeight:(CGFloat *)repostedWeiboHeight
          repostedWeiboViewHeight:(CGFloat *)repostedWeiboViewHeight
                      weiboHeight:(CGFloat *)weiboHeight
                  weiboViewHeight:(CGFloat *)weiboViewHeight
{
    
    
    float cellHeight = 0;
    float _repostedWeiboViewHeight = 0;
    float _weiboViewHeight = 0;
    
//    static AKTextView *_textField;
//    if(!_textField){
//        _textField = [[AKTextView alloc]initWithFrame:NSMakeRect(0, 0, width - REPOST_STATUS_PADDING_LEFT - REPOST_STATUS_PADDING_RIGHT, 1000)];
//    }
    
    if(weibo.retweeted_status){
        
        if(!weibo.retweeted_status.user){
        
            _repostedWeiboViewHeight = REPOST_STATUS_MESSAGE_BLOCK_HEIGH;
            
        }else{
        
        
        
        _repostedWeiboViewHeight += REPOST_STATUS_PADDING_BOTTOM;
        if(weibo.retweeted_status.pic_urls && weibo.retweeted_status.pic_urls.count>0){
            
//            _repostedWeiboViewHeight += 10;
            
            if(weibo.retweeted_status.pic_urls.count==1){

                _repostedWeiboViewHeight += LARGE_THUMBNAIL_SIZE;
            }
            else{
            
                NSInteger numberOfRow = weibo.retweeted_status.pic_urls.count/3;
                if (weibo.retweeted_status.pic_urls.count%3>0) {
                    numberOfRow ++;
                }
                //(numberOfRow - 1)*5是算上每行之间的间距
                _repostedWeiboViewHeight += numberOfRow * SMALL_THUMBNAIL_SIZE + (numberOfRow - 1)*SMALL_THUMBNAIL_SPACING;
                
            }
            
            _repostedWeiboViewHeight += IMAGE_MARGIN_TOP;
        }
        
        //        [self.repostedWeiboContent setFrameSize:self.repostedWeiboContent.intrinsicContentSize];

        
        assert(weibo.retweeted_status.text);

//        [_textField setFrameSize:NSMakeSize(width - REPOST_STATUS_PADDING_LEFT - REPOST_STATUS_PADDING_RIGHT, 1000)];
////        [_textField setStringValue:weibo.retweeted_status.text];
//        [_textField.textStorage setAttributedString:weibo.retweeted_status.attributedText];
            
        CGRect retweetedStatusTextRect = [weibo.retweeted_status.attributedText boundingRectWithSize:NSMakeSize(width - REPOST_STATUS_PADDING_LEFT - REPOST_STATUS_PADDING_RIGHT, 1000) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)];
        *repostedWeiboHeight = retweetedStatusTextRect.size.height;
        
        _repostedWeiboViewHeight += *repostedWeiboHeight;
        _repostedWeiboViewHeight += STATUS_TEXT_MARGIN_TOP;
        //UserAlias
        _repostedWeiboViewHeight += USER_ALIAS_HEIGHT;
        _repostedWeiboViewHeight += REPOST_STATUS_PADDING_TOP;

        }
    }
    
    *repostedWeiboViewHeight = _repostedWeiboViewHeight;
    
    
    //Bottom Space
    _weiboViewHeight += STATUS_PADDING_BOTTOM;
    
    //Image Matrix
    if(weibo.pic_urls && weibo.pic_urls.count>0){
        
        if(weibo.pic_urls.count == 1){
        
            _weiboViewHeight += LARGE_THUMBNAIL_SIZE;
        }
        else{

            NSInteger numberOfRow = weibo.pic_urls.count/3;
            if (weibo.pic_urls.count%3>0) {
                numberOfRow ++;
            }
            
            _weiboViewHeight += numberOfRow*SMALL_THUMBNAIL_SIZE + (numberOfRow - 1)*SMALL_THUMBNAIL_SPACING ;
        
        }
        
        _weiboViewHeight += IMAGE_MARGIN_TOP;
    }
    
    //Weibo Content
    
    
    CGRect weiboTextRect = [weibo.attributedText boundingRectWithSize:NSMakeSize(width - USER_AVATAR_MARGIN_LEFT - USER_AVATAR_SIZE - USER_AVATAR_MARGIN_RIGHT -STATUS_MARGIN_RIGHT, 1000) options:(NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin)];
    assert(weibo.text);
    
    *weiboHeight = CGRectGetHeight(weiboTextRect);
//    if([weibo.text rangeOfString:@"民航局长李家祥"].location != NSNotFound){
//    
//        NSLog(@"width = %f, height = %f (calculate) ",width, *weiboHeight);
//    }
    
//    _weiboViewHeight += *weiboHeight;
//    _weiboViewHeight += 5;
    
    
        if(*weiboHeight > USER_AVATAR_SIZE - USER_ALIAS_HEIGHT - STATUS_TEXT_MARGIN_TOP){

            _weiboViewHeight += *weiboHeight;
            _weiboViewHeight += STATUS_TEXT_MARGIN_TOP;
            _weiboViewHeight += USER_ALIAS_HEIGHT;

        }
        else{

            _weiboViewHeight += USER_AVATAR_SIZE;
        
        }

    
    //Top Space
    _weiboViewHeight += STATUS_MARGIN_TOP;
    
    //    [self.weiboView setFrameSize:NSMakeSize(self.weiboView.frame.size.width, _weiboViewHeight)];
    //    [self.repostedWeiboView setFrameOrigin:NSMakePoint(0, _weiboViewHeight)];
    //
    
    *weiboViewHeight = _weiboViewHeight;
    
    cellHeight = _repostedWeiboViewHeight + _weiboViewHeight;
    //[self setFrameSize:NSMakeSize(self.frame.size.width, cellHeight)];
    
    return (int)cellHeight;

}





-(void)mouseEntered:(NSEvent *)theEvent{

//    [self.toolbar setAlphaValue:0];
//    [self.toolbar setHidden:NO];
    [self.toolbar.animator setAlphaValue:1];

    
}

-(void)mouseExited:(NSEvent *)theEvent{

    if(self.popoverStatusEditior.popoverIsVisible){
        return;
    }
//    [self.toolbar setHidden:YES];
    [self.toolbar.animator setAlphaValue:0];

}

- (void) createTrackingArea
{
    int opts = (NSTrackingMouseEnteredAndExited | NSTrackingActiveInActiveApp);
    trackingArea = [ [NSTrackingArea alloc] initWithRect:[self bounds]
                                                 options:opts
                                                   owner:self
                                                userInfo:nil];
    [self addTrackingArea:trackingArea];
    
    NSPoint mouseLocation = [[self window] mouseLocationOutsideOfEventStream];
    mouseLocation = [self convertPoint: mouseLocation
                              fromView: nil];
    
    if (NSPointInRect(mouseLocation, [self bounds]))
    {
        [self mouseEntered: nil];
    }
    else
    {
        [self mouseExited: nil];
    }
}
        
- (void)updateTrackingAreas {
    
    if(trackingArea != nil) {
        [self removeTrackingArea:trackingArea];
    }

    [self createTrackingArea];
    [super updateTrackingAreas];
}

-(void)loadImages:(NSArray *)images{
    
    [self loadImages:images isForRepost:NO];
    

}


-(void)loadImages:(NSArray *)images isForRepost:(BOOL)isForRepost{
    

    NSMatrix *imageMatrix;
    if(isForRepost){
        return;
        imageMatrix = self.repostedWeiboView.repostedWeiboImageMatrix;
        [self.images setHidden:YES];
    }
    else{
        imageMatrix = self.images;
        //[self.repostedWeiboView.repostedWeiboImageMatrix setHidden:YES];
    }
    
    
    [AKImageHelper putImages:images inMatrix:self.images target:self action:@selector(imageCellClicked:)];

}

-(void)imageCellClicked:(id)sender{

    NSMatrix *imageMatrix = sender;
    NSCell *selectedCell = imageMatrix.selectedCell;
    AKWeiboStatus *status = self.objectValue;
    NSArray *imageURLArray = (status.pic_urls && status.pic_urls.count>0)?status.pic_urls:status.retweeted_status.pic_urls;

    _imageViewer = [AKImageViewer sharedInstance];
    _imageViewer.images = imageURLArray;
    _imageViewer.index = selectedCell.tag;
    [_imageViewer show];
    
    return;

}


-(void)_makePopupPanelIfNeeded{

    if(!gPopoverController){
        AKPopupStatusEditorViewController *popupStatusEditorController = [[AKPopupStatusEditorViewController alloc] init];
        gPopoverController = [[INPopoverController alloc] initWithContentViewController:popupStatusEditorController];
        gPopoverController.borderColor = [NSColor colorWithWhite:0.1 alpha:1];
        gPopoverController.color = [NSColor colorWithWhite:0.2 alpha:1];
        gPopoverController.topHighlightColor = [NSColor colorWithWhite:0.5 alpha:1];
        popupStatusEditorController.popoverController = gPopoverController;
        
    }


}

-(void)repostButtonClicked:(id)sender{
    
    //NSMatrix *toolbar = sender;
    
    NSButtonCell *selectedButtonCell = (NSButtonCell *)[(NSMatrix *)sender selectedCell];
    NSRect buttonCellBounds = NSMakeRect(0, 0, selectedButtonCell.cellSize.width, selectedButtonCell.cellSize.height);

    if (self.popoverStatusEditior.popoverIsVisible) {
        [self.popoverStatusEditior closePopover:nil];
    } else {
        [(AKPopupStatusEditorViewController *)self.popoverStatusEditior.contentViewController repostStatus:self.objectValue];
        [self.popoverStatusEditior presentPopoverFromRect:buttonCellBounds
                                                   inView:sender
                                  preferredArrowDirection:INPopoverArrowDirectionUp
                                    anchorsToPositionView:YES];
    }
    
}
-(void)commentButtonClicked:(id)sender{
    
    //NSMatrix *toolbar = sender;
    
    NSButtonCell *selectedButtonCell = (NSButtonCell *)[(NSMatrix *)sender selectedCell];
    NSRect buttonCellBounds = NSMakeRect(selectedButtonCell.cellSize.width, 0, selectedButtonCell.cellSize.width, selectedButtonCell.cellSize.height);
    
    if (self.popoverStatusEditior.popoverIsVisible) {
        [self.popoverStatusEditior closePopover:nil];
    } else {
        
        [(AKPopupStatusEditorViewController *)self.popoverStatusEditior.contentViewController commentOnStatus:self.objectValue];
        [self.popoverStatusEditior presentPopoverFromRect:buttonCellBounds
                                                   inView:sender
                                  preferredArrowDirection:INPopoverArrowDirectionUp
                                    anchorsToPositionView:YES];
    }
    
}

-(void)favButtonClicked:(id)sender{

    

}

-(void)shareButtonClicked:(id)sender{
    
    NSMatrix *toolbarMatrix = sender;
//    NSMenu *menu = [(NSButtonCell *)toolbarMatrix.selectedCell menu];
    [_shareButtonContextMenu popUpMenuPositioningItem:nil atLocation:NSMakePoint(toolbarMatrix.frame.size.width, 0) inView:toolbarMatrix];
}


-(void)copyStatusMenuClicked:(id)sender{
    
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard clearContents];
    [pasteboard setString:self.objectValue.text forType:NSStringPboardType];
    
}

-(void)openStatusInBrowser:(id)sender{
    
    NSString *urlString = @"";
    [[NSWorkspace sharedWorkspace]openURL:[NSURL URLWithString:urlString]];
    
}


-(IBAction)toolbarClicked:(id)sender{
    
    NSButtonCell *clickedButton = [(NSMatrix *)sender selectedCell];
    switch (clickedButton.tag) {
        case 0:
            //转发
            [self repostButtonClicked:sender];
            break;
            
        case 1:
            //评论
            [self commentButtonClicked:sender];
            break;
            
        case 2:
            //收藏
            [self favButtonClicked:sender];
            break;
            
        case 3:
            //其它
            [self shareButtonClicked:sender];
            break;
            
        default:
            break;
    }


}
@end
