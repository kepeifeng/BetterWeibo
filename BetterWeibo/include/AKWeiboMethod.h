//
//  AKWeiboMethod.h
//  weibosdk
//
//  Created by Kent Peifeng Ke on 13-10-18.
//
//

#import <Foundation/Foundation.h>
#import "AKWeiboDef.h"
#import "AKVariableParams.h"
#import "AKID.h"
#import "AKParsingObject.h"

/**
 *  Weibo Method Actions
 */
typedef NS_ENUM(NSInteger, AKMethodAction)
{
    AKWBOPT_NONE,
    
    /**
     *获得Access Token
     *http://open.weibo.com/wiki/OAuth2/access_token
     */
    AKWBOPT_OAUTH2_ACCESS_TOKEN,
    /**
     *向服务器请求验证
     *http://open.weibo.com/wiki/Oauth2/authorize
     */
    AKWBOPT_OAUTH2_AUTHORIZE,
    /**
     *退出登录
     *http://open.weibo.com/wiki/2/account/end_session
     */
    AKWBOPT_END_SESSION,
    
    /**
     *获取最新更新的公共微博消息
     *http://open.weibo.com/wiki/2/statuses/public_timeline
     */
    AKWBOPT_GET_STATUSES_PUBLIC_TIMELINE,
    /**
     *获取当前用户所关注用户的最新微博信息 (别名: statuses/home_timeline)
     *http://open.weibo.com/wiki/2/statuses/friends_timeline
     */
    AKWBOPT_GET_STATUSES_FRIENDS_TIMELINE,
    /**
     *获取当前登录用户及其所关注用户的最新微博消息
     *http://open.weibo.com/wiki/2/statuses/home_timeline
     */
    AKWBOPT_GET_STATUSES_HOME_TIMELINE,
    /**
     *获取用户发布的微博信息列表
     *http://open.weibo.com/wiki/2/statuses/user_timeline
     */
    AKWBOPT_GET_STATUSES_USER_TIMELINE,
    /**
     *批量获得指定的某一批用户的timeline
     *http://open.weibo.com/wiki/2/statuses/timeline_batch
     */
    AKWBOPT_GET_STATUSES_TIMELINE_BATCH,
    /**
     *返回一条微博的最新n条转发微博信息
     *http://open.weibo.com/wiki/2/statuses/repost_timeline
     */
    AKWBOPT_GET_STATUSES_REPOST_TIMELINE,
    /**
     *返回用户转发的最新n条微博信息
     *
     */
    AKWBOPT_GET_STATUSES_REPOST_BYME,
    /**
     *获取@当前用户的微博列表
     *http://open.weibo.com/wiki/2/statuses/mentions
     */
    AKWBOPT_GET_STATUSES_MENTIONS,
    /**
     *根据ID获取单条微博信息
     *http://open.weibo.com/wiki/2/statuses/show
     */
    AKWBOPT_GET_STATUSES_SHOW,
    /**
     *批量获取微博信息
     *http://open.weibo.com/wiki/2/statuses/show_batch
     */
    AKWBOPT_GET_STATUSES_SHOW_BATCH,
    /**
     *通过id获取mid
     *http://open.weibo.com/wiki/2/statuses/querymid
     */
    AKWBOPT_GET_STATUSES_QUERYMID,
    /**
     *通过mid获取id
     *http://open.weibo.com/wiki/2/statuses/queryid
     */
    AKWBOPT_GET_STATUSES_QUERYID,
    /**
     *按天返回热门转发榜
     *
     */
    AKWBOPT_GET_STATUSES_REPOST_DAILY,
    /**
     *按周返回热门转发榜
     */
    AKWBOPT_GET_STATUSES_REPOST_WEEKLY,
    /**
     *按天返回热门评论榜
     */
    AKWBOPT_GET_STATUSES_HOT_COMMENTS_DAILY,
    /**
     *按周返回热门评论榜
     */
    AKWBOPT_GET_STATUSES_HOT_COMMENTS_WEEKLY,
    /**
     *转发一条微博信息
     *http://open.weibo.com/wiki/2/statuses/repost
     */
    AKWBOPT_POST_STATUSES_REPOST,
    /**
     *删除微博评论信息
     *http://open.weibo.com/wiki/2/statuses/destroy
     */
    AKWBOPT_POST_STATUSES_DESTROY,
    /**
     *发布一条微博信息
     *http://open.weibo.com/wiki/2/statuses/update
     */
    AKWBOPT_POST_STATUSES_UPDATE,
    /**
     *发布一条微博，同时指定上传的图片或图片url
     *http://open.weibo.com/wiki/2/statuses/upload_url_text
     */
    AKWBOPT_POST_STATUSES_UPLOAD_URL_TEXT,
    /**
     *发布一条微博，上传图片并发布一条微博信息
     *http://open.weibo.com/wiki/2/statuses/upload
     */
    AKWBOPT_POST_STATUSES_UPLOAD,
    
    /**
     *获取某条微博的评论列表
     *http://open.weibo.com/wiki/2/comments/show
     */
    AKWBOPT_GET_COMMENTS_SHOW,
    /**
     *我发出的评论列表
     *http://open.weibo.com/wiki/2/comments/by_me
     */
    AKWBOPT_GET_COMMENTS_BYME,
    /**
     *我收到的评论列表
     *http://open.weibo.com/wiki/2/comments/to_me
     */
    AKWBOPT_GET_COMMENTS_TOME,
    /**
     *获取当前用户发送及收到的评论列表
     *http://open.weibo.com/wiki/2/comments/timeline
     */
    AKWBOPT_GET_COMMENTS_TIMELINE,
    /**
     *@到我的评论
     *http://open.weibo.com/wiki/2/comments/mentions
     */
    AKWBOPT_GET_COMMENTS_MENTIONS,
    /**
     *@批量获取评论内容
     *http://open.weibo.com/wiki/2/comments/show_batch
     */
    AKWBOPT_GET_COMMENTS_SHOWBATCH,
    
    /**
     *评论一条微博
     *http://open.weibo.com/wiki/2/comments/create
     */
    AKWBOPT_POST_COMMENTS_CREATE,
    /**
     *删除一条评论
     *http://open.weibo.com/wiki/2/comments/destroy
     */
    AKWBOPT_POST_COMMENTS_DESTROY,
    /**
     *批量删除评论
     *http://open.weibo.com/wiki/2/comments/destroy_batch
     */
    AKWBOPT_POST_COMMENTS_DESTROY_BATCH ,
    /**
     *回复一条评论
     *http://open.weibo.com/wiki/2/comments/reply
     */
    AKWBOPT_POST_COMMENTS_REPLY,
    
    /**
     *获取当前用户最新私信列表
     */
    AKWBOPT_GET_DIRECTMESSAGES,
    /**
     *获取当前用户发送的最新私信列表
     */
    AKWBOPT_GET_DIRECTMESSAGES_SENT,
    /**
     *获取私信往来用户列表
     */
    AKWBOPT_GET_DIRECTMESSAGES_USER_LIST,
    /**
     *获取与指定用户的往来私信列表
     */
    AKWBOPT_GET_DIRECTMESSAGES_CONVERSATION,
    /**
     *批量获取私信内容
     */
    AKWBOPT_GET_DIRECTMESSAGES_SHOW_BATCH,
    /**
     *判断是否可以给对方发私信
     */
    AKWBOPT_GET_DIRECTMESSAGES_IS_CAPABLE,
    /**
     *发送一条私信
     */
    AKWBOPT_POST_DIRECTMESSAGES_NEW,
    /**
     *删除一条私信
     */
    AKWBOPT_POST_DIRECTMESSAGES_DESTORY,
    /**
     *批量删除私信
     */
    AKWBOPT_POST_DIRECTMESSAGES_DESTORY_BATCH,
    
    /**
     *获取用户资料http://open.weibo.com/wiki/2/users/show
     */
    AKWBOPT_GET_USERS_SHOW,
    /**
     *通过个性域名获取用户信息http://open.weibo.com/wiki/2/users/domain_show
     */
    AKWBOPT_GET_USERS_DOMAIN_SHOW,
    /**
     *批量获取用户信息
     */
    AKWBOPT_GET_USERS_SHOW_BATCH,
    
    /**
     *获取用户基本信息
     */
    AKWBOPT_GET_ACCOUNT_PROFILE_BASIC,
    /**
     *获取教育信息
     */
    AKWBOPT_GET_ACCOUNT_PROFILE_EDUCATION,
    /**
     *批量获取教育信息
     */
    AKWBOPT_GET_ACCOUNT_PROFILE_EDUCATION_BATCH,
    /**
     *获取职业信息
     */
    AKWBOPT_GET_ACCOUNT_PROFILE_CAREER,
    /**
     *批量获取职业信息
     */
    AKWBOPT_GET_ACCOUNT_PROFILE_CAREER_BATCH,
    /**
     *获取隐私设置信息http://open.weibo.com/wiki/2/account/get_privacy
     */
    AKWBOPT_GET_ACCOUNT_GET_PRIVACY,
    /**
     *获取所有学校列表http://open.weibo.com/wiki/2/account/profile/school_list
     */
    AKWBOPT_GET_ACCOUNT_PROFILE_SCHOOL_LIST,
    /**
     *获取当前用户API访问频率限制http://open.weibo.com/wiki/2/account/rate_limit_status
     */
    AKWBOPT_GET_ACCOUNT_RATE_LIMIT_STATUS,
    /**
     *OAuth授权之后获取用户UID（作用相当于旧版接口的account/verify_credentials）http://open.weibo.com/wiki/2/account/get_uid
     */
    AKWBOPT_GET_ACCOUNT_GET_UID,
    /**
     * 更新用户基本信息
     */
    AKWBOPT_POST_ACCOUNT_PROFILE_BASIC_UPDATE,
    /**
     * 更新用户教育信息
     */
    AKWBOPT_POST_ACCOUNT_PROFILE_EDU_UPDATE,
    /**
     * 删除用户教育信息
     */
    AKWBOPT_POST_ACCOUNT_PROFILE_EDU_DESTROY,
    /**
     * 更新用户职业信息
     */
    AKWBOPT_POST_ACCOUNT_PROFILE_CAR_UPDATE,
    /**
     * 删除用户职业信息
     */
    AKWBOPT_POST_ACCOUNT_PROFILE_CAR_DESTROY,
    /**
     * 上传头像
     */
    AKWBOPT_POST_ACCOUNT_AVATAR_UPLOAD,
    /**
     * 更新隐私设置
     */
    AKWBOPT_POST_ACCOUNT_UPDATE_PRIVACY,
    
    /**
     *获取用户的关注列表http://open.weibo.com/wiki/2/friendships/friends
     */
    AKWBOPT_GET_FRIENDSHIPS_FRIENDS,
    /**
     *获取共同关注人列表接口http://open.weibo.com/wiki/2/friendships/friends/in_common
     */
    AKWBOPT_GET_FRIENDSHIPS_IN_COMMON,
    /**
     *获取双向关注列表http://open.weibo.com/wiki/2/friendships/friends/bilateral
     */
    AKWBOPT_GET_FRIENDSHIPS_BILATERAL,
    /**
     *获取双向关注ID列表http://open.weibo.com/wiki/2/friendships/friends/bilateral/ids
     */
    AKWBOPT_GET_FRIENDSHIPS_BILATERAL_IDS,
    /**
     *获取用户关注对象uid列表http://open.weibo.com/wiki/2/friendships/friends/ids
     */
    AKWBOPT_GET_FRIENDSHIPS_FRIENDS_IDS,
    /**
     *批量获取备注
     */
    AKWBOPT_GET_FRIENDSHIPS_FRIENDS_REMARK_BATCH,
    /**
     *获取用户粉丝列表及每个粉丝的最新一条微博http://open.weibo.com/wiki/2/friendships/followers
     */
    AKWBOPT_GET_FRIENDSHIPS_FRIENDS_FOLLOWERS,
    /**
     *获取用户粉丝对象uid列表http://open.weibo.com/wiki/2/friendships/followers/ids
     */
    AKWBOPT_GET_FRIENDSHIPS_FRIENDS_FOLLOWERS_IDS,
    /**
     *获取用户优质粉丝列表关系链http://open.weibo.com/wiki/2/friendships/followers/active
     */
    AKWBOPT_GET_FRIENDSHIPS_FRIENDS_FOLLOWERS_ACTIVE,
    /**
     *获取我的关注人中关注了指定用户的分组http://open.weibo.com/wiki/2/friendships/friends_chain/followers
     */
    AKWBOPT_GET_FRIENDSHIPS_CHAIN_FOLLOWERS,
    /**
     *获取两个用户关系的详细情况http://open.weibo.com/wiki/2/friendships/show
     */
    AKWBOPT_GET_FRIENDSHIPS_SHOW,
    /**
     *关注某用户http://open.weibo.com/wiki/2/friendships/create
     */
    AKWBOPT_POST_FRIENDSHIPS_CREATE,
    /**
     *批量关注用户
     */
    AKWBOPT_POST_FRIENDSHIPS_CREATE_BATCH,
    /**
     *取消关注某用户http://open.weibo.com/wiki/2/friendships/destroy
     */
    AKWBOPT_POST_FRIENDSHIPS_DESTROY,
    /**
     *移除粉丝http://open.weibo.com/wiki/2/friendships/followers/destroy
     */
    AKWBOPT_POST_FRIENDSHIPS_FOLLOWERS_DESTORY,
    /**
     *更新关注人备注http://open.weibo.com/wiki/2/friendships/remark/update
     */
    AKWBOPT_POST_FRIENDSHIPS_REMARK_UPDATE,
    
    /**
     *获取当前登录用户的收藏列表http://open.weibo.com/wiki/2/favorites
     */
    AKWBOPT_GET_FAVORITES,
    /**
     *获取单条收藏信息http://open.weibo.com/wiki/2/favorites/show
     */
    AKWBOPT_GET_FAVORITES_SHOW,
    /**
     *获取当前用户某个标签下的收藏列表http://open.weibo.com/wiki/2/favorites/by_tags
     */
    AKWBOPT_GET_FAVORITES_BY_TAGS,
    /**
     *当前登录用户的收藏标签列表http://open.weibo.com/wiki/2/favorites/tags
     */
    AKWBOPT_GET_FAVORITES_TAGS,
    /**
     *添加收藏http://open.weibo.com/wiki/2/favorites/create
     */
    AKWBOPT_POST_FAVORITES_CREATE,
    /**
     *删除收藏http://open.weibo.com/wiki/2/favorites/destroy
     */
    AKWBOPT_POST_FAVORITES_DESTROY,
    /**
     *批量删除收藏http://open.weibo.com/wiki/2/favorites/destroy_batch
     */
    AKWBOPT_POST_FAVORITES_DESTROY_BATCH,
    /**
     *更新收藏标签http://open.weibo.com/wiki/2/favorites/tags/update
     */
    AKWBOPT_POST_FAVORITES_TAGS_UPDATE,
    /**
     *更新当前用户所有收藏下的指定标签http://open.weibo.com/wiki/2/favorites/tags/update_batch
     */
    AKWBOPT_POST_FAVORITES_TAGS_UPDATE_BATCH,
    /**
     *删除当前用户所有收藏下的指定标签http://open.weibo.com/wiki/2/favorites/tags/destroy_batch
     */
    AKWBOPT_POST_FAVORITES_TAGS_DESTROY_BATCH,
    
    /**
     *获取某人话题
     */
    AKWBOPT_GET_TRENDS,
    /**
     *获取某一话题下的微博
     */
    AKWBOPT_GET_TRENDS_STATUSES,
    /**
     *返回最近一小时内的热门话题http://open.weibo.com/wiki/2/trends/hourly
     */
    AKWBOPT_GET_TRENDS_HOURLY,
    /**
     *返回最近一天内的热门话题http://open.weibo.com/wiki/2/trends/daily
     */
    AKWBOPT_GET_TRENDS_DAILY,
    /**
     *返回最近一周内的热门话题http://open.weibo.com/wiki/2/trends/weekly
     */
    AKWBOPT_GET_TRENDS_WEEKLY,
    /**
     *关注某话题
     */
    AKWBOPT_POST_TRENDS_FOLLOW,
    /**
     *取消关注的某一个话题
     */
    AKWBOPT_POST_TRENDS_DESTROY,
    
    /**
     *返回指定用户的标签列表http://open.weibo.com/wiki/2/statuses/tags
     */
    AKWBOPT_GET_TAGS,
    /**
     *批量获取用户标签http://open.weibo.com/wiki/2/statuses/tags/show_batch
     */
    AKWBOPT_GET_TAGS_TAGS_BATCH,
    /**
     *返回系统推荐的标签列表
     */
    AKWBOPT_GET_TAGS_SUGGESTIONS,
    /**
     *添加用户标签http://open.weibo.com/wiki/2/statuses/tags/create
     */
    AKWBOPT_POST_TAGS_CREATE,
    /**
     *删除用户标签http://open.weibo.com/wiki/2/statuses/tags/destroy
     */
    AKWBOPT_POST_TAGS_DESTROY,
    /**
     *批量删除用户标签
     */
    AKWBOPT_POST_TAGS_DESTROY_BATCH,
    
    /**
     *搜用户搜索建议http://open.weibo.com/wiki/2/search/suggestions/users
     */
    AKWBOPT_GET_SEARCH_SUGGESTIONS_USERS,
    /**
     *搜微博搜索建议
     */
    AKWBOPT_GET_SEARCH_SUGGESTIONS_STATUSES,
    /**
     *搜学校搜索建议http://open.weibo.com/wiki/2/search/suggestions/schools
     */
    AKWBOPT_GET_SEARCH_SUGGESTIONS_SCHOOLS,
    
    /**
     *  搜公司搜索建议http://open.weibo.com/wiki/2/search/suggestions/companies
     */
    AKWBOPT_GET_SEARCH_SUGGESTIONS_COMPANIES,
    /**
     *搜应用搜索建议http://open.weibo.com/wiki/2/search/suggestions/apps
     */
    AKWBOPT_GET_SEARCH_SUGGESTIONS_APPS,
    
    /**
     *  @联想搜索http://open.weibo.com/wiki/2/search/suggestions/at_users
     */
    AKWBOPT_GET_SEARCH_SUGGESTIONS_AT_USERS,
    
    /**
     *  综合联想搜索
     */
    AKWBOPT_GET_SEARCH_SUGGESTIONS_INTEGRATE,
    /**
     *微博搜索
     */
    AKWBOPT_GET_SEARCH_STATUSES,
    /**
     *  搜索指定范围内的微博
     */
    AKWBOPT_GET_SEARCH_GEO_STATUSES,
    /**
     *搜索用户
     */
    AKWBOPT_GET_SEARCH_USERS,
    
    /**
     *热门收藏http://open.weibo.com/wiki/2/suggestions/favorites/hot
     */
    AKWBOPT_GET_SUGGESTIONS_FAVORITES_HOT,
    /**
     *获取系统推荐用户
     */
    AKWBOPT_GET_SUGGESTIONS_USERS_HOT,
    /**
     *获取用户可能感兴趣的人
     */
    AKWBOPT_GET_SUGGESTIONS_USERS_MAY_INTERESTED,
    /**
     *不感兴趣的人http://open.weibo.com/wiki/2/suggestions/users/not_interested
     */
    AKWBOPT_POST_SUGGESTIONS_USERS_NOT_INTERESTED,
    /**
     *根据微博内容推荐用户
     */
    AKWBOPT_GET_SUGGESTIONS_USERS_BY_STATUS,
    
    /**
     *将一个或多个长链接转换成短链接http://open.weibo.com/wiki/2/short_url/shorten
     */
    AKWBOPT_GET_SHORT_URL_SHORTEN,
    /**
     *将一个或多个短链接还原成原始的长链接http://open.weibo.com/wiki/2/short_url/expand
     */
    AKWBOPT_GET_SHORT_URL_EXPAND,
    /**
     *取得一个短链接在微博上的微博分享数（包含原创和转发的微博）http://open.weibo.com/wiki/2/short_url/share/counts
     */
    AKWBOPT_GET_SHORT_URL_SHARE_COUNTS,
    /**
     *取得包含指定单个短链接的最新微博内容http://open.weibo.com/wiki/2/short_url/share/statuses
     */
    AKWBOPT_GET_SHORT_URL_SHARE_STATUSES,
    /**
     *取得一个短链接在微博上的微博评论数http://open.weibo.com/wiki/2/short_url/comment/counts
     */
    AKWBOPT_GET_SHORT_URL_COMMENT_COUNTS,
    /**
     *取得包含指定单个短链接的最新微博评论内容http://open.weibo.com/wiki/2/short_url/comment/comments
     */
    AKWBOPT_GET_SHORT_URL_COMMENT_COMMENTS,
    
    /**
     *  取得短链接的信息
     */
    AKWBOPT_GET_SHORT_URL_INFO,
    
    /**
     *获取某个用户的各种消息未读数http://open.weibo.com/wiki/2/remind/unread_count
     */
    AKWBOPT_GET_REMIND_UNREAD_COUNT,
    /**
     *对当前登录用户某一种消息未读数进行清零 http://open.weibo.com/wiki/2/remind/set_count
     */
    AKWBOPT_POST_STATUSES_RESET_COUNT,
    
    // Groups
    AKWBOPT_GET_GROUPS_JOINED,
    AKWBOPT_GET_GROUPS_SHOW_BATCH,
    AKWBOPT_GET_GROUPS_GET_ANNOUNCEMENT,
    AKWBOPT_GET_GROUPS_ADMIN,
    AKWBOPT_GET_GROUPS_USERS,
    AKWBOPT_GET_GROUPS_SUGGESTION_MAY_INTERESTED,
    AKWBOPT_GET_GROUPS_CHAT_BLOCK,
    AKWBOPT_GET_GROUPS_CHAT_UNBLOCK,
    AKWBOPT_GET_GROUPS_CHAT_IS_BLOCKED,
    AKWBOPT_GET_GROUP_USERS_JOINED_STATUSES,
    
    AKWBOPT_END
};

@protocol AKMethodDelegate

/**
 *  This method is call when connection is completed.
 *
 *  @param methodOption <#methodOption description#>
 *  @param httpHeader   <#httpHeader description#>
 *  @param result       <#result description#>
 *  @param pTask        <#pTask description#>
 */
-(void)OnDelegateCompleted:(AKMethodAction)methodOption httpHeader:(NSString *)httpHeader result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask;

-(void)OnDelegateErrored:(AKMethodAction)methodOption errCode:(NSInteger)errCode subErrCode:(NSInteger)subErrCode result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask;

-(void)OnDelegateWillRelease:(AKMethodAction)methodOption pTask:(AKUserTaskInfo *)pTask;

@end


/**
 *  A List of Weibo Methods
 */
@protocol AKWeiboMethodProtocol


@property id<AKMethodDelegate> delegate;

/**
 *  使用用户名和密码进行登录验证（已被官方弃用弃用，请勿使用）
 *
 *  @param userName 用户名
 *  @param password 密码
 *  @param pTask    pTask
 *
 *  @return AKWeiboResultCode
 */
-(AKWeiboResultCode)oauth2:(NSString *) userName password: (NSString *) password task:(AKUserTaskInfo *)pTask;
/**
 *  使用Code方式进行登录验证。用户在网页中授权App进行登录后，页面会跳转到App的redirect url，同时带上一个Code，开发者在拿到这个Code之后调用此函数获得AccessToken
 *
 *  @param code  从Redirect URL获得的Code
 *  @param url   App的Redirect URL
 *  @param pTask pTask
 *
 *  @return AKWeiboResultCode
 */
-(AKWeiboResultCode)oauth2Code:(NSString *)code url:(NSString *)url  pTask:(AKUserTaskInfo*) pTask;
/**
 *  退出登录
 *
 *  @return AKWeiboResultCode
 */
-(AKWeiboResultCode)endSession;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 微博读取
/**
 *  返回最新的200条公共微博，返回结果非完全实时
 *  http://open.weibo.com/wiki/2/statuses/public_timeline
 *  @param var   参数，参数列表如下：
 *  count 	false 	int 	单页返回的记录条数，最大不超过200，默认为20。
 *  @param pTask pTask
 *
 *  @return AKWeiboResultCode
 */
-(AKWeiboResultCode) getStatusesPublicTimeline:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getStatusesFriendTimeline:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getStatusesHomeTimeline:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getStatusesUserTimeline:(AKID *)usrId  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getStatusesTimelineBatch:(AKID *)usrId  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getStatusesRepostTimeline:(NSString *)aID  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getStatusesRepostByMe:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getStatusesMentions:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getStatusesShow:(NSString *)aID  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getStatusesShowBatch:(NSString *)inputIDs  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getStatusesQueryMID:(NSString *) weiboId    type:(NSInteger)type  is_batch:(NSInteger) is_batch  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getStatusesQueryID:(NSString *) mId    type:(NSInteger)type  is_batch:(NSInteger) is_batch  inbox:(NSInteger) inbox  isBase62:(NSInteger) isBase62  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getStatusesRepostDaily:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getStatusesRepostWeekly:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getStatusesHotCommmentsDaily:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getStatusesHotCommmentsWeekly:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
    
    // 微博写入
-(AKWeiboResultCode) postStatusesRepost:(NSString *) weiboId   statusText:(NSString *)statusText isComment:(NSInteger)isComment  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) postStatusesDestroy:(NSString *) weiboId   var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) postStatusesUpdate:(NSString *)statusText  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) postStatusesUploadUrlText:(NSString *)statusText  picInfo:(NSString *)picInfo  isPicUrl:(BOOL)isPicUrl  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) postStatusesUpload:(NSString *)statusText  filePath:(NSString *)filePath  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 评论读取
-(AKWeiboResultCode) getCommentsShow:(NSString *) weiboId   var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getCommentsByMe:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getCommentsToMe:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getCommentsTimeline:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getCommentsMentions:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
    
    // 评论写入
-(AKWeiboResultCode) getCommentsShowBatch:(NSString *)commentIds  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) postCommentsCreate:(NSString *)postId comment:(NSString *)comment   commentOri:(NSInteger)commentOri var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) postCommentsDestroy:(NSString *)postId  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) postCommentsDestroyBatch:(NSString *)postId  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) postCommentsReply:(NSString *) commentId comment:(NSString *)comment weiboId:(NSString *)weiboId
                                                  withoutMention:(NSInteger)withoutMention   commentOri:(NSInteger)commentOri  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 私信读取
-(AKWeiboResultCode) getDirectMessages:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getDirectMessagesSent:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getDirectMessagesUserList:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getDirectMessagesCoversation:(AKID  *)usrId  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getDirectMessagesShowBatch:(NSString *)aID  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getDirectMessagesIsCapable:(NSString *)uid  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
    
    // 私信写入
-(AKWeiboResultCode) postDirectMessagesNew:(NSString *)text uid:(AKID *) uid fields:(NSString *)fields
                                                weiboId:(NSString *) weiboId  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) postDirectMessagesDestory:(NSString *)aID  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) postDirectMessagesDestoryBatch:(NSString *)aIDs uid:(NSString *)uid  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 用户读取
-(AKWeiboResultCode) getUsersShow:(AKID *)usrId extend:(NSString *)extend var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getUsersDomainShow:(NSString *) domain  extend:(NSString *)extend  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getUsersShowBatch:(AKID *)usrId extend:(NSString *)extend  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 关注读取
-(AKWeiboResultCode) getFriendshipsFriends:(AKID *)usrId   order:(NSInteger)order/**/  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) getFriendshipsInCommon:(NSString *)aID suid:(NSString *)suid  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) getFriendshipsBilateral:(NSString *)uid  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) getFriendshipsBilateralIDs:(NSString *)uid  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) getFriendshipsFriendIDs:(AKID *)usrId  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) getFriendshipsFriendRemarkBatch:(NSString *)uids  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;
    
    // 粉丝读取
-(AKWeiboResultCode) getFriendshipsFriendsFollowers:(AKID *)usrId  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getFriendshipsFriendsFollowersIDs:(AKID *)usrId  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) getFriendshipsFriendsFollowersActive:(AKID *)usrIDs  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;
    
    // 关系链读取
-(AKWeiboResultCode) getFriendshipsFriendsChainFollowers:(NSString *)uid  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;
    
    // 关系状态
-(AKWeiboResultCode) getFriendshipShow:(AKID *)sourceId targetId:(AKID *)targetId  pTask:(AKUserTaskInfo *) pTask ;
    
    // 关系写入
-(AKWeiboResultCode) postFriendshipsCreate:(AKID *)usrId   skipCheck:(NSInteger)skipCheck  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) postFriendshipsCreateBatch:(NSString *)uids  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) postFriendshipsDestroy:(AKID *)usrId  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) postFriendshipsFollowersDestroy:(NSString *)uid  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) postFriendshipsRemarkUpdate:(NSString *) uid remark:(NSString *)remark  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 帐号读取
-(AKWeiboResultCode) getAccountProfileBasic:(NSString *) uid   pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) getAccountProfileEducation:(NSString *)uid  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) getAccountProfileEducationBatch:(NSString *)uids  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) getAccountProfileCareer:(NSString *)uid  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) getAccountProfileCareerBatch:(NSString *)uids  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) getAccountGetPrivacy:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) getAccountProfileSchoolList:(NSInteger) province  city:(NSInteger) city  area:(NSInteger) area  type:(NSInteger) type
                                                 capital:(NSString *)capital keyword:(NSString *)keyword  counts:(NSInteger) counts  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) getAccountRateLimitStatus:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) getAccountGetUID:(AKUserTaskInfo *) pTask ;
    
    // 帐号写入
-(AKWeiboResultCode) postAccountProfileBasicUpdate:(AKBasicInfo*)basic  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) postAccountProfileEduUpdate:(AKEducationInfo *)edu  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) postAccountProfileEduDestroy:(NSString *)aID  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) postAccountProfileCarUpdate:(AKCareerInfo *) career  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) postAccountProfileCarDestroy:(NSString *)aID  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) postAccountAvatarUpload:(NSString *)filePath  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) postAccountUpdatePrivacy:(NSInteger) comment  geo:(NSInteger) geo  message:(NSInteger) message
                                                      realname:(NSInteger) realname  badge:(NSInteger) badge  mobile:(NSInteger) mobile  pTask:(AKUserTaskInfo *) pTask ;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 收藏读取
-(AKWeiboResultCode) getFavorites:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getFavoritesShow:(NSString *)aID  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getFavoritesByTags:(NSString *)tid  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getFavoritesTags:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
    
    // 收藏写入
-(AKWeiboResultCode) postFavoritesCreate:(NSString *)aID  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) postFavoritesDestroy:(NSString *)aID  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) postFavoritesDestroyBatch:(NSString *)aIDs  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) postFavoritesTagUpdate:(NSString *)tagId tagName:(NSString *)tagName  var:(AKVariableParams *)var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) postFavoritesTagsUpdateBatch:(NSString *)tagId tagName:(NSString *)tagName  var:(AKVariableParams *)var  pTask:(AKUserTaskInfo *)pTask;
-(AKWeiboResultCode) postFavoritesTagsDestroyBatch:(NSString *)tagId  var:(AKVariableParams *)var  pTask:(AKUserTaskInfo *)pTask;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 话题读取
-(AKWeiboResultCode) getTrends:(NSString *)uid  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getTrendsStatuses:(NSString *)trendWords provinceId:(NSString *)provinceId  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getTrendsHourly:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getTrendsDaily:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getTrendsWeekly:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
    
    // 话题写入
-(AKWeiboResultCode) postTrendsFollow:(NSString *)trendName  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) postTrendsDestroy:(NSString *)trendId  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 标签读取
-(AKWeiboResultCode) getTags:(NSString *)uid  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getTagsTagsBatch:(NSString *)uids  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getTagsSuggestions:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
    
    // 标签写入
-(AKWeiboResultCode) postTagsCreate:(NSString *)tags  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) postTagsDestroy:(NSString *)tagId  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) postTagsDestroyBatch:(NSString *)tagIds  pTask:(AKUserTaskInfo *) pTask;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 搜索
-(AKWeiboResultCode) getSearchSuggestionsUsers:(NSString *)q  count:(NSInteger) count  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getSearchSuggestionsStatues:(NSString *)q  count:(NSInteger) count  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getSearchSuggestionsSchool:(NSString *)q  count:(NSInteger) count  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getSearchSuggestionsCompanies:(NSString *)q  count:(NSInteger) count  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getSearchSuggestionsApps:(NSString *)q  count:(NSInteger) count  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getSearchSuggestionsAtUsers:(NSString *)q   type:(NSInteger)type  count:(NSInteger) count  range:(NSInteger) range  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getSearchSuggestionsIntegrate:(NSString *)query  sort_user:(NSInteger) sort_user  sort_app:(NSInteger) sort_app 
                                                           sort_grp:(NSInteger) sort_grp  user_count:(NSInteger) user_count  app_count:(NSInteger) app_count  grp_count:(NSInteger) grp_count  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getSearchStatuses:(NSString *)q  filter_ori:(NSInteger) filter_ori   filter_pic:(NSInteger)filter_pic  fuid:(NSString *)fuid  
                                               province:(NSInteger) province   city:(NSInteger)city  starttime:(NSString *)starttime endtime:(NSString *)endtime  count:(NSInteger) count 
                                               page:(NSInteger) page  needcount:(BOOL)needcount  base_app:(NSInteger) base_app  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getSearchGeoStatuses:(float) longitude  latitudeconst:(float)latitudeconst  range:(NSInteger) range  time:(NSInteger) time
                                                  sort_type:(NSInteger) sort_type  page:(NSInteger) page  count:(NSInteger) count  base_app:(NSInteger) base_app  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getSearchUsers:(NSString *)q  snick:(NSInteger) snick  sdomain:(NSInteger) sdomain  sintro:(NSInteger) sintro  stag:(NSInteger) stag 
                                            province:(NSInteger) province   city:(NSInteger)city  gender:(NSString *)gender  comorsch:(NSString *)comorsch   sort:(NSInteger) sort 
                                            count:(NSInteger) count  page:(NSInteger) page  base_app:(NSInteger) base_app  pTask:(AKUserTaskInfo *) pTask;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 推荐读取
-(AKWeiboResultCode) getSuggestionsFavoritesHot:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getSuggestionsUsersHot:(NSString *)category  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getSuggestionsUsersMayInterested:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getSuggestionsUsersByStatus:(NSString *)content   num:(NSInteger)num  url:(NSString *)url  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 推荐写入
-(AKWeiboResultCode) postSuggestionsUsersNotInterested:(NSString *)uid  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 短链接口
-(AKWeiboResultCode) getShortURLShorten:(NSArray *)longURLs  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getShortURLExpand:(NSArray *)url_shorts  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getShortURLShareCounts:(NSString *)url_short  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getShortURLShareStatuses:(NSString *)url_short  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getShortURLCommentCounts:(NSString *)url_short  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getShortURLCommentComments:(NSString *)url_short  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getShortUrlInfo:(NSString *)shortUrlIDs  pTask:(AKUserTaskInfo *) pTask;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Unread
-(AKWeiboResultCode) getRemindUnreadCount:(NSString *)uid  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) postStatusesResetCount:(NSInteger)type  pTask:(AKUserTaskInfo *) pTask;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Groups
-(AKWeiboResultCode) getGroupsJoined:(NSString *)uid   page:(NSInteger)page   count:(NSInteger)count 
                                              type:(NSInteger)type   filter:(NSInteger)filter   sort:(NSInteger)sort   member_limit:(NSInteger)member_limit   simplify:(NSInteger)simplify  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getGroupsShowBatch:(NSString *)gids  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getGroupsGetAnnouncement:(NSString *)gid  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getGroupsAdmin:(NSString *)gid  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getGroupsUsers:(NSString *)gid  var:(AKVariableParams*)var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getGroupsSuggestionMayInterested:(NSInteger)count  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getGroupsChatIsBlocked:(NSString *)gids  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) postGroupsChatBlock:(NSString *)gid  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) postGroupsChatUnblock:(NSString *)gid  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getGroupsUsersJoinedStatuses:(NSString *)uid  simplify:(NSInteger)simplify var:(AKVariableParams *)var pTask:(AKUserTaskInfo *) pTask;


@end


struct AKWeiboMethodOpaque;

/**
 *  An Implement of AKWeiboMethodProtocol
 */
@interface AKWeiboMethod : NSObject<AKWeiboMethodProtocol,NSURLConnectionDelegate,NSURLConnectionDataDelegate>{

    struct AKWeiboMethodOpaque * _weiboMethod;
}

-(id)initWithObject:(void *)object;

@property id<AKMethodDelegate> delegate;
@property NSString * consumerKey;
@property NSString * consumerSecret;
@property NSString * accessToken;
@property AKWeiboRequestFormat unifiedFormat;

@end


