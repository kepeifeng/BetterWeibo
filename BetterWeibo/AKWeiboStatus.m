//
//  AKWeibo.m
//  BetterWeibo
//
//  Created by Kent on 13-10-6.
//  Copyright (c) 2013年 Kent Peifeng Ke. All rights reserved.
//

#import "AKWeiboStatus.h"
#import "AKUserProfile.h"
#import "AKImageDownloader.h"
#import "AKImageHelper.h"
#import "RegexKitLite.h"
#import "AKEmotion.h"

#define DEFAULT_FONT_SIZE 13.0

NSString *const ATEntityPropertyNamedThumbnailImage = @"thumbnailImages";
NSString *const AKWeiboStatusPropertyNamedFavorited = @"favorited";

static NSOperationQueue *ATSharedOperationQueue() {
    static NSOperationQueue *_ATSharedOperationQueue = nil;
    if (_ATSharedOperationQueue == nil) {
        _ATSharedOperationQueue = [[NSOperationQueue alloc] init];
        // We limit the concurrency to see things easier for demo purposes. The default value NSOperationQueueDefaultMaxConcurrentOperationCount will yield better results, as it will create more threads, as appropriate for your processor
        [_ATSharedOperationQueue setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
    }
    return _ATSharedOperationQueue;
}

@implementation AKWeiboStatus{

    NSArray *_thumbnailImages;
}


@synthesize pic_urls = _pic_urls;
@synthesize attributedText = _attributedText;
@synthesize text = _text;

-(NSArray *)pic_urls{

    return _pic_urls;

}


-(void)setPic_urls:(NSArray *)pic_urls{

    _pic_urls = pic_urls;
    if(_pic_urls){
    
        
    
    }

}

-(NSString *)text{
    return _text;
}

-(void)setText:(NSString *)text{
    _text = [text copy];
    
    if(!_text){
        _attributedText = nil;
        return;
    }
    
//    NSString *statusString = aString;
	
    
	// Building up our attributed string
	NSMutableAttributedString *attributedStatusString = [[NSMutableAttributedString alloc] initWithString:text];
	
	// Defining our paragraph style for the tweet text. Starting with the shadow to make the text
	// appear inset against the gray background.
	NSShadow *textShadow = [[NSShadow alloc] init];
	[textShadow setShadowColor:[NSColor colorWithDeviceWhite:1 alpha:.8]];
	[textShadow setShadowBlurRadius:0];
	[textShadow setShadowOffset:NSMakeSize(0, -1)];
    
	NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
	[paragraphStyle setMinimumLineHeight:18];
	[paragraphStyle setMaximumLineHeight:18];
	[paragraphStyle setParagraphSpacing:0];
	[paragraphStyle setParagraphSpacingBefore:0];
	[paragraphStyle setTighteningFactorForTruncation:4];
	[paragraphStyle setAlignment:NSNaturalTextAlignment];
	[paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
	
	// Our initial set of attributes that are applied to the full string length
	NSDictionary *fullAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
									[NSColor colorWithDeviceHue:.53 saturation:.13 brightness:.26 alpha:1], NSForegroundColorAttributeName,
									textShadow, NSShadowAttributeName,
									[NSCursor arrowCursor], NSCursorAttributeName,
									[NSNumber numberWithFloat:0.0], NSKernAttributeName,
									[NSNumber numberWithInt:0], NSLigatureAttributeName,
									paragraphStyle, NSParagraphStyleAttributeName,
									[NSFont systemFontOfSize:DEFAULT_FONT_SIZE], NSFontAttributeName, nil];
	[attributedStatusString addAttributes:fullAttributes range:NSMakeRange(0, [text length])];
    
    
	// Generate arrays of our interesting items. Links, usernames, hashtags.
	NSArray *linkMatches = [self scanStringForLinks:text];
	NSArray *usernameMatches = [self scanStringForUsernames:text];
	NSArray *hashtagMatches = [self scanStringForHashtags:text];
    NSArray *emotions = [self scanStringForEmotions:text];
	
	// Iterate across the string matches from our regular expressions, find the range
	// of each match, add new attributes to that range
	for (NSString *linkMatchedString in linkMatches) {
        
		NSRange range = [text rangeOfString:linkMatchedString];
		if( range.location != NSNotFound ) {
			// Add custom attribute of LinkMatch to indicate where our URLs are found. Could be blue
			// or any other color.
			NSDictionary *linkAttr = [[NSDictionary alloc] initWithObjectsAndKeys:
									  [NSCursor pointingHandCursor], NSCursorAttributeName,
									  [NSColor blueColor], NSForegroundColorAttributeName,
									  [NSFont boldSystemFontOfSize:DEFAULT_FONT_SIZE], NSFontAttributeName,
									  linkMatchedString, @"LinkMatch",
									  nil];
			[attributedStatusString addAttributes:linkAttr range:range];
            
		}
	}
	
	for (NSString *usernameMatchedString in usernameMatches) {
        
        NSUInteger count = 0, length = [text length];
        NSRange range = NSMakeRange(0, length);
        while(range.location != NSNotFound)
        {
            range = [text rangeOfString: usernameMatchedString options:0 range:range];
            if(range.location != NSNotFound)
            {
                
                // Add custom attribute of UsernameMatch to indicate where our usernames are found
                NSDictionary *linkAttr2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                                           [NSColor blackColor], NSForegroundColorAttributeName,
                                           [NSCursor pointingHandCursor], NSCursorAttributeName,
                                           [NSFont boldSystemFontOfSize:DEFAULT_FONT_SIZE], NSFontAttributeName,
                                           usernameMatchedString, @"UsernameMatch",
                                           nil];
                [attributedStatusString addAttributes:linkAttr2 range:range];
                
                
                range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
                count++;
            }
        }
        
	}
	
	for (NSString *hashtagMatchedString in hashtagMatches) {
		NSRange range = [text rangeOfString:hashtagMatchedString];
		if( range.location != NSNotFound ) {
			// Add custom attribute of HashtagMatch to indicate where our hashtags are found
			NSDictionary *linkAttr3 = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       [NSColor grayColor], NSForegroundColorAttributeName,
                                       [NSCursor pointingHandCursor], NSCursorAttributeName,
                                       [NSFont systemFontOfSize:DEFAULT_FONT_SIZE], NSFontAttributeName,
                                       hashtagMatchedString, @"HashtagMatch",
                                       nil];
			[attributedStatusString addAttributes:linkAttr3 range:range];
            
		}
	}
    
    for (NSString *emotionCode in emotions) {
        
        AKEmotion *emotion;
        if(!( emotion = [[AKEmotion emotionDictionary]objectForKey:emotionCode])){
            
            continue;
        }
        
		NSUInteger length = [text length];
        NSRange range = NSMakeRange(0, length);
        
        //assert(range.length+range.location<=statusString.length);
        range = [text rangeOfString: emotionCode options:0 range:range];
        if( range.location != NSNotFound ) {
            // Add custom attribute of HashtagMatch to indicate where our hashtags are found
            NSTextAttachmentCell *textAttachmentCell = [[NSTextAttachmentCell alloc] initImageCell:emotion.image];
            NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
            [textAttachment setAttachmentCell:textAttachmentCell];
            NSAttributedString *emotionIconString = [NSAttributedString attributedStringWithAttachment:textAttachment];
            
            assert(range.length+range.location<=attributedStatusString.length);
            [attributedStatusString replaceCharactersInRange:NSMakeRange(range.location, range.length) withAttributedString:emotionIconString];
            
            text = attributedStatusString.string;
        }
        
	}

    _attributedText = attributedStatusString;

}

-(NSString *)dateDuration{
    if (!_created_at) {
        return nil;
    }
    
    NSTimeInterval timeInterval = -[_created_at timeIntervalSinceNow];
    NSInteger result = 0;
    //86400 = 60 * 60 *24
    if((result = timeInterval/86400)>0){
        return [NSString stringWithFormat:@"%ld天", result];
    }
    else if((result = timeInterval/3600)>0){
        return [NSString stringWithFormat:@"%ld小时", result];
    }
    else if((result = timeInterval / 60)>0){
        return [NSString stringWithFormat:@"%ld分", result];
    }
    else{
        return [NSString stringWithFormat:@"%ld秒", (long)timeInterval];
    }
    
}

-(BOOL)hasImages{

    return (self.pic_urls && self.pic_urls.count>0);
}

// Lazily load the thumbnail image when requested
- (NSArray *)thumbnailImages {
    if (_thumbnailImages) {
        // Generate the thumbnail right now, synchronously
        return _thumbnailImages;
    } else if (_thumbnailImages == nil && !self.isLoadingThumbnails) {
        // Load the image lazily
        [self loadThumbnailImages];
    }
    return _thumbnailImages;
}

- (void)setThumbnailImages:(NSArray *)images {
    if (images != _thumbnailImages) {
        _thumbnailImages = images;
    }
}


-(void)loadThumbnailImages{
    
    if(!self.hasImages && !(self.retweeted_status && self.retweeted_status.hasImages)){
        return;
    }
    
    @synchronized (self) {
        if (_thumbnailImages == nil && !self.isLoadingThumbnails) {
            self.isLoadingThumbnails = YES;
            // We would have to keep track of the block with an NSBlockOperation, if we wanted to later support cancelling operations that have scrolled offscreen and are no longer needed. That will be left as an exercise to the user.
            [ATSharedOperationQueue() addOperationWithBlock:^(void) {
                
                NSMutableArray *thumbnails = [NSMutableArray new];
                
                NSInteger i=0;
                
                NSArray *pictureURLs = (self.hasImages)?self.pic_urls:self.retweeted_status.pic_urls;
                BOOL getSquareImage = (pictureURLs.count>1);
                for(NSDictionary *url in pictureURLs){
                    NSString *urlString = [url objectForKey:@"thumbnail_pic"];
                    if(getSquareImage){
                        urlString = [urlString stringByReplacingOccurrencesOfString:@"/thumbnail/" withString:@"/square/"];
                    }
                    NSImage *image = [AKImageHelper getImageFromData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
                    image = [AKImageHelper getSquareImageFrom:image];
                    
                    [thumbnails addObject:(image)?image:[NSNull new]];
                    i++;
                    
                }
                if (thumbnails != nil) {
                    //NSImage *thumbnailImage = ATThumbnailImageFromImage(image);
                    // We synchronize access to the image/imageLoading pair of variables
                    @synchronized (self) {
                        self.isLoadingThumbnails = NO;
                        self.thumbnailImages = thumbnails;
                        
                        
                    }

                } else {
                    @synchronized (self) {
                        //self.image = [NSImage imageNamed:NSImageNameTrashFull];
                    }
                }

                
            }];
        }
    }

}


#pragma mark - String parsing

// These regular expressions aren't the greatest. There are much better ones out there to parse URLs, @usernames
// and hashtags out of tweets. Getting the escaping just right is a pain in the ass, so be forewarned.

- (NSArray *)scanStringForLinks:(NSString *)string {
	return [string componentsMatchedByRegex:@"https?://[a-zA-Z0-9\\-.]+(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?"];
    
}

- (NSArray *)scanStringForUsernames:(NSString *)string {
	NSArray *array = [string componentsMatchedByRegex:@"@[\u4e00-\u9fa5a-zA-Z0-9_-]{2,30}"];
    NSMutableArray *copy = [NSMutableArray arrayWithArray:array];
    NSInteger index = [array count] - 1;
    for (id object in [array reverseObjectEnumerator]) {
        if ([copy indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) {
            [copy removeObjectAtIndex:index];
        }
        index--;
    }
    
    return copy;
    
    //	return [string componentsMatchedByRegex:@"@{1}([-A-Za-z0-9_]{2,})"];
}

- (NSArray *)scanStringForHashtags:(NSString *)string {
	return [string componentsMatchedByRegex:@"#[^#]+#"];
    //    return [string componentsMatchedByRegex:@"[\\s]{1,}#{1}([^\\s]{2,})"];
}


- (NSArray *)scanStringForEmotions:(NSString *)string {
	return [string componentsMatchedByRegex:@"\\[[\u4e00-\u9fa5a-zA-Z0-9_-]{1,10}\\]"];
    
}


#pragma mark - Static Methods

+(NSDateFormatter *)dateFormatter{

    static NSDateFormatter *gDateFormatter;
    if(!gDateFormatter){
        gDateFormatter = [[NSDateFormatter alloc]init];
        gDateFormatter.dateFormat = @"EEE MMM dd HH:mm:ss ZZZ yyy";
        gDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    }
    
    return gDateFormatter;
}

+(AKWeiboStatus *)getStatusFromDictionary:(NSDictionary *)status{
    
    if(!status){
        return nil;
    }
    /*
     created_at 	string 	微博创建时间
     id 	int64 	微博ID
     mid 	int64 	微博MID
     idstr 	string 	字符串型的微博ID
     text 	string 	微博信息内容
     source 	string 	微博来源
     favorited 	boolean 	是否已收藏，true：是，false：否
     truncated 	boolean 	是否被截断，true：是，false：否
     in_reply_to_status_id 	string 	（暂未支持）回复ID
     in_reply_to_user_id 	string 	（暂未支持）回复人UID
     in_reply_to_screen_name 	string 	（暂未支持）回复人昵称
     thumbnail_pic 	string 	缩略图片地址，没有时不返回此字段
     bmiddle_pic 	string 	中等尺寸图片地址，没有时不返回此字段
     original_pic 	string 	原始图片地址，没有时不返回此字段
     geo 	object 	地理信息字段 详细
     user 	object 	微博作者的用户信息字段 详细
     retweeted_status 	object 	被转发的原微博信息字段，当该微博为转发微博时返回 详细
     reposts_count 	int 	转发数
     comments_count 	int 	评论数
     attitudes_count 	int 	表态数
     mlevel 	int 	暂未支持
     visible 	object 	微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
     pic_urls 	object 	微博配图地址。多图时返回多图链接。无配图返回“[]”
     ad 	object array 	微博流内的推广微博ID
     */
    
    
    AKWeiboStatus *statusObject = [[AKWeiboStatus alloc]init];
    statusObject.ID = [(NSNumber *)[status objectForKey:@"id"] longLongValue];
    statusObject.mid = [(NSNumber *)[status objectForKey:@"mid"] longLongValue];
    statusObject.idstr =(NSString *)[status objectForKey:@"idstr"];
    statusObject.created_at = [[[self class] dateFormatter] dateFromString:(NSString *)[status objectForKey:@"created_at"]];
    statusObject.thumbnail_pic = (NSString *)[status objectForKey:@"thumbnail_pic"];
    statusObject.bmiddle_pic =(NSString *)[status objectForKey:@"bmiddle_pic"];
    statusObject.original_pic = (NSString *)[status objectForKey:@"created_at"];
    statusObject.retweeted_status = [AKWeiboStatus getStatusFromDictionary:(NSDictionary  *)[status objectForKey:@"retweeted_status"]];
    statusObject.favorited = [(NSNumber *)[status objectForKey:@"favorited"] boolValue];
    //            statusObject.geo =
    statusObject.in_reply_to_screen_name = (NSString *)[status objectForKey:@"in_reply_to_screen_name"];
    statusObject.in_reply_to_status_id = (NSString *)[status objectForKey:@"in_reply_to_status_id"];
    statusObject.in_reply_to_user_id = (NSString *)[status objectForKey:@"in_reply_to_user_id"];
    statusObject.reposts_count = [(NSNumber *)[status objectForKey:@"reposts_count"] longLongValue];
    statusObject.comments_count = [(NSNumber *)[status objectForKey:@"comments_count"] integerValue];
    statusObject.attitudes_count = [(NSNumber *)[status objectForKey:@"attitudes_count"] integerValue];
    statusObject.visible = [AKWeiboVisibility getVisibilityFromDictionary:(NSDictionary *)[status objectForKey:@"visible"]];
    statusObject.pic_urls = (NSArray *)[status objectForKey:@"pic_urls"];
    statusObject.source = (NSString *)[status objectForKey:@"source"];
    statusObject.text = (NSString *)[status objectForKey:@"text"];
    statusObject.truncated = [(NSNumber *)[status objectForKey:@"favorited"] boolValue];
    
    NSDictionary *userProfileDictionary = (NSDictionary *)[status objectForKey:@"user"];
    
    statusObject.user = [AKUserProfile getUserProfileFromDictionary:userProfileDictionary];

    return statusObject;
    
}

+(AKWeiboStatus *)getStatusFromDictionary:(NSDictionary *)statusDictionary forStatus:(AKWeiboStatus *)repostedStatus{

    
    
    AKWeiboStatus *statusObject = [[AKWeiboStatus alloc]init];
    statusObject.ID = [(NSNumber *)[statusDictionary objectForKey:@"id"] longLongValue];
    statusObject.mid = [(NSNumber *)[statusDictionary objectForKey:@"mid"] longLongValue];
    statusObject.idstr =(NSString *)[statusDictionary objectForKey:@"idstr"];
    statusObject.created_at = [[[self class] dateFormatter] dateFromString:(NSString *)[statusDictionary objectForKey:@"created_at"]];
    statusObject.thumbnail_pic = (NSString *)[statusDictionary objectForKey:@"thumbnail_pic"];
    statusObject.bmiddle_pic =(NSString *)[statusDictionary objectForKey:@"bmiddle_pic"];
    statusObject.original_pic = (NSString *)[statusDictionary objectForKey:@"created_at"];
    statusObject.retweeted_status = repostedStatus;
    statusObject.favorited = [(NSNumber *)[statusDictionary objectForKey:@"favorited"] boolValue];
    //            statusObject.geo =
    statusObject.in_reply_to_screen_name = (NSString *)[statusDictionary objectForKey:@"in_reply_to_screen_name"];
    statusObject.in_reply_to_status_id = (NSString *)[statusDictionary objectForKey:@"in_reply_to_status_id"];
    statusObject.in_reply_to_user_id = (NSString *)[statusDictionary objectForKey:@"in_reply_to_user_id"];
    statusObject.reposts_count = [(NSNumber *)[statusDictionary objectForKey:@"reposts_count"] longLongValue];
    statusObject.comments_count = [(NSNumber *)[statusDictionary objectForKey:@"comments_count"] integerValue];
    statusObject.attitudes_count = [(NSNumber *)[statusDictionary objectForKey:@"attitudes_count"] integerValue];
    statusObject.visible = [AKWeiboVisibility getVisibilityFromDictionary:(NSDictionary *)[statusDictionary objectForKey:@"visible"]];
    statusObject.pic_urls = (NSArray *)[statusDictionary objectForKey:@"pic_urls"];
    statusObject.source = (NSString *)[statusDictionary objectForKey:@"source"];
    statusObject.text = (NSString *)[statusDictionary objectForKey:@"text"];
    statusObject.truncated = [(NSNumber *)[statusDictionary objectForKey:@"favorited"] boolValue];
    
    NSDictionary *userProfileDictionary = (NSDictionary *)[statusDictionary objectForKey:@"user"];
    
    statusObject.user = [AKUserProfile getUserProfileFromDictionary:userProfileDictionary];
    
    return statusObject;

}


@end


@implementation AKWeiboVisibility

+(AKWeiboVisibility *)getVisibilityFromDictionary:(NSDictionary *)visibilityDictionary{

    if(!visibilityDictionary)
        return nil;
    
    AKWeiboVisibility *visibilityObject = [[AKWeiboVisibility alloc]init];
    visibilityObject.type = [(NSNumber *)[visibilityDictionary objectForKey:@"type"] integerValue];
    visibilityObject.list_id = [(NSNumber *)[visibilityDictionary objectForKey:@"list_id"] integerValue];
    
    return visibilityObject;

}

@end
