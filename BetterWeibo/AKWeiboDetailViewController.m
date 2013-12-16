//
//  AKWeiboDetailViewController.m
//  BetterWeibo
//
//  Created by Kent Peifeng Ke on 13-10-2.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKWeiboDetailViewController.h"
#import "AKUserProfile.h"
#import "AKCommentViewCell.h"
#import "AKWeiboTableCellView.h"

#pragma mark - Constants

#define LISTVIEW_CELL_IDENTIFIER		@"AKCommentViewCell"




@interface AKWeiboDetailViewController ()

@end

@implementation AKWeiboDetailViewController{

    NSMutableArray *_comments;
    NSTrackingArea *trackingArea;
    
}

@synthesize status = _status;


#pragma mark - Init/Dealloc

- (id)init
{

    
    self = [super initWithNibName:@"AKWeiboDetailViewController" bundle:nil];
    if (self) {
        self.title = @"评    论";        
        _comments = [NSMutableArray new];
        
        NSArray *topLevelObjects;
        [[NSBundle mainBundle]loadNibNamed:@"AKWeiboStatusDetailView" owner:self topLevelObjects:&topLevelObjects];
        
        for(id object in topLevelObjects){
            
            if([object isKindOfClass:[NSView class]]){
                self.statusDetailView = object;
                
                break;
            }
        }
        
        [self.view addSubview:self.statusDetailView];
        
        [self.statusDetailView setFrameSize:self.view.bounds.size];
       // NSSize statusDetailViewSize = [self.statusDetailView intrinsicContentSize];
        //NSPoint statusDetailViewOrigin = NSMakePoint(0, self.view.bounds.size.height - statusDetailViewSize.height);
        

        //[self.statusDetailView setFrameSize:statusDetailViewSize];
        //[self.statusDetailView setFrameOrigin:statusDetailViewOrigin];
        //[self.statusDetailView setAutoresizesSubviews:YES];
        [self.statusDetailView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
        

        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        _comments = [NSMutableArray new];

    }
    return self;
}


- (void)awakeFromNib
{
	[listView setCellSpacing:2.0f];
	[listView setAllowsEmptySelection:YES];
	[listView setAllowsMultipleSelection:YES];
	[listView registerForDraggedTypes:[NSArray arrayWithObjects: NSStringPboardType, nil]];

    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = CGColorCreateGenericRGB(1, 1, 1, 1);
    
    //self.view.layer.contents = [NSImage imageNamed:@"app_content_background"];
    
}



#pragma mark - Properties

-(AKWeiboStatus *)status{
    
    return _status;
}

-(void)setStatus:(AKWeiboStatus *)status {
    
    
    _status = status;

    
}


#pragma mark - List View Delegate Methods

- (NSUInteger)numberOfRowsInListView: (PXListView*)aListView
{
#pragma unused(aListView)
	return [_comments count];
}

- (PXListViewCell*)listView:(PXListView*)aListView cellForRow:(NSUInteger)row
{
	AKCommentViewCell *cell = (AKCommentViewCell*)[aListView dequeueCellWithReusableIdentifier:LISTVIEW_CELL_IDENTIFIER];
	
	if(!cell) {
		cell = [AKCommentViewCell cellLoadedFromNibNamed:@"AKCommentViewCell" reusableIdentifier:LISTVIEW_CELL_IDENTIFIER];
	}
	
    AKComment *comment = [_comments objectAtIndex:row];
	// Set up the new cell:
	[cell.userAliasField setStringValue:comment.user.screen_name];
    [cell.commentField setStringValue:comment.text];
	
	return cell;
}

- (CGFloat)listView:(PXListView*)aListView heightOfRow:(NSUInteger)row
{
	return 50;
}

- (void)listViewSelectionDidChange:(NSNotification*)aNotification
{
    NSLog(@"Selection changed");
}


// The following are only needed for drag'n drop:
- (BOOL)listView:(PXListView*)aListView writeRowsWithIndexes:(NSIndexSet*)rowIndexes toPasteboard:(NSPasteboard*)dragPasteboard
{
	// +++ Actually drag the items, not just dummy data.
	[dragPasteboard declareTypes: [NSArray arrayWithObjects: NSStringPboardType, nil] owner: self];
	[dragPasteboard setString: @"Just Testing" forType: NSStringPboardType];
	
	return YES;
}

- (NSDragOperation)listView:(PXListView*)aListView validateDrop:(id <NSDraggingInfo>)info proposedRow:(NSUInteger)row
      proposedDropHighlight:(PXListViewDropHighlight)dropHighlight;
{
	return NSDragOperationCopy;
}

- (IBAction) reloadTable:(id)sender
{
	[listView reloadData];
}

@end
