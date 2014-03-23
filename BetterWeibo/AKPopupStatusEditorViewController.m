//
//  AKPopupStatusEditorViewController.m
//  BetterWeibo
//
//  Created by Kent on 14-3-6.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKPopupStatusEditorViewController.h"
#import "AKNameSenceViewController.h"

@interface AKPopupStatusEditorViewController ()

@end

@implementation AKPopupStatusEditorViewController{
    AKEmotionTableController *_emotionController;
    BOOL _freezingFlag;
}

@synthesize statusType = _statusType;
@synthesize progressIndicator = _progressIndicator;
@synthesize status = _status;

- (id)init
{
    self = [super initWithNibName:@"AKPopupStatusEditorView" bundle:[NSBundle bundleForClass:[self class]]];
    if (self) {
        
    }
    return self;
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
    self.postButton.buttonStyle = AKButtonStyleBlueButton;
    
    NSShadow *textShadow = [[NSShadow alloc] init];
    textShadow.shadowBlurRadius = 0;
    textShadow.shadowColor = [NSColor whiteColor];
    textShadow.shadowOffset = NSMakeSize(1, -1);
    self.countField.shadow = textShadow;
}

-(void)setTitleText:(NSString *)title{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSCenterTextAlignment];
    
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowBlurRadius = 0;
    shadow.shadowColor = [NSColor blackColor];
    shadow.shadowOffset = NSMakeSize(-1, 1);
    
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:title
                                                                           attributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                                       paragraphStyle, NSParagraphStyleAttributeName,
                                                                                       shadow, NSShadowAttributeName, nil]];
    self.titleTextField.attributedStringValue = attributedString;
}

#pragma mark - Properties
//-(AKWeiboStatus *)targetStatus{
//    return _targetStatus;
//}
//
//-(void)setTargetStatus:(AKWeiboStatus *)targetStatus{
//    
//    _targetStatus = targetStatus;
//    
//    
//}

-(AKWeiboStatus *)status{
    return _status;
}

-(AKStatusType)statusType{
    return _statusType;
}

#pragma Methods

-(void)commentOnStatus:(AKWeiboStatus *)status{
    
    _status = status;
    _statusType = AKStatusTypeComment;
    self.statusTextView.string = @"";
    [self textDidChange:nil];
//    self.titleTextField.stringValue = @"评 论";
    [self setTitleText:@"评 论"];
    self.additionActionButton.title = @"同时转发到我的微博";
    [[self.statusTextView window] makeFirstResponder:self.statusTextView];

}

-(void)repostStatus:(AKWeiboStatus *)status{
    _status = status;
    _statusType = AKStatusTypeRepost;
//    self.titleTextField.stringValue = @"转 发";
    [self setTitleText:@"转 发"];
    if(status.retweeted_status){
        self.statusTextView.string = [NSString stringWithFormat:@"//@%@:%@", _status.user.screen_name, _status.text];
    }
    else{
        self.statusTextView.string = @"";
    }
    self.additionActionButton.title = @"同时留下评论";
    [[self.statusTextView window] makeFirstResponder:self.statusTextView];
    [self.statusTextView setSelectedRange:NSMakeRange(0, 0)];
    [self textDidChange:nil];
    
}


- (IBAction)cancelButtonClicked:(id)sender {
    [self.popoverController closePopover:self];
}

- (IBAction)postButtonClicked:(id)sender {
    
    BOOL commentAndRepost = self.additionActionButton.state;
    if (self.statusType == AKStatusTypeRepost || commentAndRepost){

        [[AKWeiboManager currentManager] postRepostStatus:_status.idstr content:self.statusTextView.string shouldComment:commentAndRepost callbackTarget:self];
    }else if (self.statusType == AKStatusTypeComment) {

        [[AKWeiboManager currentManager] postCommentOnStatus:_status.idstr comment:self.statusTextView.string shouldCommentOriginStatus:NO callbackTarget:self];
    }

    
    [self setFreezing:YES];
}

- (IBAction)toolbarClicked:(id)sender {
    
    NSMatrix *toolbar = sender;
    NSInteger selectedIndex = [(NSButtonCell *)(toolbar.selectedCell) tag];
    
    //Insert Emotion
    if( selectedIndex == 0){
        
        NSButtonCell *buttonCell = (NSButtonCell *)toolbar.selectedCell;
        
        if(!_emotionController){
            
            _emotionController = [[AKEmotionTableController alloc] init];
            _emotionController.delegate = self;
        }
        
        if(_emotionController.isShown){
            [_emotionController closeEmotionDialog];
        }
        else{
            
            [_emotionController displayEmotionDialogForView:toolbar relativeToRect:NSMakeRect(0, 0, buttonCell.cellSize.width, buttonCell.cellSize.height)];
        }
        
        
        
    }
    //Insert Images
    else if (selectedIndex == 1){

        
    }
    //Insert Topic
    else if (selectedIndex == 2){
        
        
    }
    
}

-(BOOL)isFreezing{
    return _freezingFlag;
}

/**
 *  设置是否要进入冻结状态
 *
 *  @param flag YES 则进入冻结状态
 */
-(void)setFreezing:(BOOL)flag{
    
    _freezingFlag = flag;
    if(flag){
        
        [_progressIndicator startAnimation:nil];
    }
    else{
        [_progressIndicator stopAnimation:nil];
    }
    
    //TODO:post button didn't disabled atfer this:
    [self.postButton setEnabled:!flag];
    [self.statusTextView setEditable:!flag];    
    
}

-(void)reset{
    
    [self setFreezing:NO];
    self.statusTextView.string = @"";
}

#pragma mark - Emotion Table Controller Delegate
-(void)emotionTable:(AKEmotionTableController *)emotionTable emotionSelected:(AKEmotion *)emotion{
    
    [self.statusTextView insertText:emotion.code];
//    self.statusTextView.string = [self.statusTextView.string stringByAppendingString:emotion.code];
    [_emotionController closeEmotionDialog];
}

#pragma mark - Status TextView Delegate
-(void)atKeyPressed:(id)textView position:(NSRect)atPosition{
    [[AKNameSenceViewController sharedInstance] displayNameSenceForView:textView relativeToRect:atPosition];
}

-(BOOL)textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector{
    if(commandSelector == @selector(insertNewline:)){
        if(!self.isFreezing){
        
            [self postButtonClicked:nil];
        }
        return YES;
    }
    return NO;
}


-(void)textDidChange:(NSNotification *)notification{

    NSInteger countdown = 140 - self.statusTextView.string.length;
    self.countField.stringValue = [NSString stringWithFormat:@"%ld",countdown];
    if(countdown<0){
        self.countField.textColor = [NSColor redColor];
    }
    else{
        self.countField.textColor = [NSColor grayColor];
    }
    
}





#pragma mark - Weibo Manager Callback Methods

-(void)OnDelegateComplete:(AKWeiboManager*)weiboManager methodOption:(AKMethodAction)methodOption  httpHeader:(NSString *)httpHeader result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask{
    
    if(methodOption == AKWBOPT_POST_STATUSES_REPOST || methodOption == AKWBOPT_POST_COMMENTS_CREATE){
        
//        [self.window orderOut:self];
        NSSound *sound = [NSSound soundNamed:@"sent"];
        [sound play];
        [self reset];
        
        if(self.popoverController){
        
            [self.popoverController closePopover:self];
        
        }
    }
    
}

-(void)OnDelegateErrored:(AKWeiboManager *)weiboManager methodOption:(AKMethodAction)methodOption errCode:(NSInteger)errCode subErrCode:(NSInteger)subErrCode result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask{
    
    if(methodOption == AKWBOPT_POST_STATUSES_REPOST || methodOption == AKWBOPT_POST_COMMENTS_CREATE){
        
        NSBeep();
        //解除冻结
        [self setFreezing:NO];
        
    }
    
    
}

-(void)OnDelegateWillRelease:(AKWeiboManager *)weiboManager methodOption:(AKMethodAction)methodOption pTask:(AKUserTaskInfo *)pTask{
    
    
}


@end
