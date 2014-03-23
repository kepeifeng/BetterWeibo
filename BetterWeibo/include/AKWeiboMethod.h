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
     *@see http://open.weibo.com/wiki/OAuth2/access_token
     */
    AKWBOPT_OAUTH2_ACCESS_TOKEN,
    /**
     *向服务器请求验证
     *@see http://open.weibo.com/wiki/Oauth2/authorize
     */
    AKWBOPT_OAUTH2_AUTHORIZE,
    /**
     *退出登录
     *@see http://open.weibo.com/wiki/2/account/end_session
     */
    AKWBOPT_END_SESSION,
    
    /**
     *获取最新更新的公共微博消息
     *@see http://open.weibo.com/wiki/2/statuses/public_timeline
     */
    AKWBOPT_GET_STATUSES_PUBLIC_TIMELINE,
    /**
     *获取当前用户所关注用户的最新微博信息 (别名: statuses/home_timeline)
     *@see http://open.weibo.com/wiki/2/statuses/friends_timeline
     */
    AKWBOPT_GET_STATUSES_FRIENDS_TIMELINE,
    /**
     *获取当前登录用户及其所关注用户的最新微博消息
     *@see http://open.weibo.com/wiki/2/statuses/home_timeline
     */
    AKWBOPT_GET_STATUSES_HOME_TIMELINE,
    /**
     *获取用户发布的微博信息列表
     *@see http://open.weibo.com/wiki/2/statuses/user_timeline
     */
    AKWBOPT_GET_STATUSES_USER_TIMELINE,
    /**
     *批量获得指定的某一批用户的timeline
     *@see http://open.weibo.com/wiki/2/statuses/timeline_batch
     */
    AKWBOPT_GET_STATUSES_TIMELINE_BATCH,
    /**
     *返回一条微博的最新n条转发微博信息
     *@see http://open.weibo.com/wiki/2/statuses/repost_timeline
     */
    AKWBOPT_GET_STATUSES_REPOST_TIMELINE,
    /**
     *返回用户转发的最新n条微博信息
     *
     */
    AKWBOPT_GET_STATUSES_REPOST_BYME,
    /**
     *获取@当前用户的微博列表
     *@see http://open.weibo.com/wiki/2/statuses/mentions
     */
    AKWBOPT_GET_STATUSES_MENTIONS,
    /**
     *根据ID获取单条微博信息
     *@see http://open.weibo.com/wiki/2/statuses/show
     */
    AKWBOPT_GET_STATUSES_SHOW,
    /**
     *批量获取微博信息
     *@see http://open.weibo.com/wiki/2/statuses/show_batch
     */
    AKWBOPT_GET_STATUSES_SHOW_BATCH,
    /**
     *通过id获取mid
     *@see http://open.weibo.com/wiki/2/statuses/querymid
     */
    AKWBOPT_GET_STATUSES_QUERYMID,
    /**
     *通过mid获取id
     *@see http://open.weibo.com/wiki/2/statuses/queryid
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
     *@see sss
     *@see http://open.weibo.com/wiki/2/statuses/repost
     */
    AKWBOPT_POST_STATUSES_REPOST,
    /**
     *删除微博评论信息
     *@see http://open.weibo.com/wiki/2/statuses/destroy
     */
    AKWBOPT_POST_STATUSES_DESTROY,
    /**
     *发布一条微博信息
     *@see http://open.weibo.com/wiki/2/statuses/update
     */
    AKWBOPT_POST_STATUSES_UPDATE,
    /**
     *发布一条微博，同时指定上传的图片或图片url
     *@see http://open.weibo.com/wiki/2/statuses/upload_url_text
     */
    AKWBOPT_POST_STATUSES_UPLOAD_URL_TEXT,
    /**
     *发布一条微博，上传图片并发布一条微博信息
     *@see http://open.weibo.com/wiki/2/statuses/upload
     */
    AKWBOPT_POST_STATUSES_UPLOAD,
    
    /**
     *获取某条微博的评论列表
     *@see http://open.weibo.com/wiki/2/comments/show
     */
    AKWBOPT_GET_COMMENTS_SHOW,
    /**
     *我发出的评论列表
     *@see http://open.weibo.com/wiki/2/comments/by_me
     */
    AKWBOPT_GET_COMMENTS_BYME,
    /**
     *我收到的评论列表
     *@see http://open.weibo.com/wiki/2/comments/to_me
     */
    AKWBOPT_GET_COMMENTS_TOME,
    /**
     *获取当前用户发送及收到的评论列表
     *@see http://open.weibo.com/wiki/2/comments/timeline
     */
    AKWBOPT_GET_COMMENTS_TIMELINE,
    /**
     *@到我的评论
     *@see http://open.weibo.com/wiki/2/comments/mentions
     */
    AKWBOPT_GET_COMMENTS_MENTIONS,
    /**
     *@批量获取评论内容
     *@see http://open.weibo.com/wiki/2/comments/show_batch
     */
    AKWBOPT_GET_COMMENTS_SHOWBATCH,
    
    /**
     *评论一条微博
     *@see http://open.weibo.com/wiki/2/comments/create
     */
    AKWBOPT_POST_COMMENTS_CREATE,
    /**
     *删除一条评论
     *@see http://open.weibo.com/wiki/2/comments/destroy
     */
    AKWBOPT_POST_COMMENTS_DESTROY,
    /**
     *批量删除评论
     *@see http://open.weibo.com/wiki/2/comments/destroy_batch
     */
    AKWBOPT_POST_COMMENTS_DESTROY_BATCH ,
    /**
     *回复一条评论
     *@see http://open.weibo.com/wiki/2/comments/reply
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
     *获取用户资料
     *@see http://open.weibo.com/wiki/2/users/show
     */
    AKWBOPT_GET_USERS_SHOW,
    /**
     *通过个性域名获取用户信息
     *@see http://open.weibo.com/wiki/2/users/domain_show
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
     *获取隐私设置信息
     *@see http://open.weibo.com/wiki/2/account/get_privacy
     */
    AKWBOPT_GET_ACCOUNT_GET_PRIVACY,
    /**
     *获取所有学校列表
     *@see http://open.weibo.com/wiki/2/account/profile/school_list
     */
    AKWBOPT_GET_ACCOUNT_PROFILE_SCHOOL_LIST,
    /**
     *获取当前用户API访问频率限制
     *@see http://open.weibo.com/wiki/2/account/rate_limit_status
     */
    AKWBOPT_GET_ACCOUNT_RATE_LIMIT_STATUS,
    /**
     *OAuth授权之后获取用户UID（作用相当于旧版接口的account/verify_credentials）
     *@see http://open.weibo.com/wiki/2/account/get_uid
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
     *获取用户的关注列表
     *@see http://open.weibo.com/wiki/2/friendships/friends
     */
    AKWBOPT_GET_FRIENDSHIPS_FRIENDS,
    /**
     *获取共同关注人列表接口
     *@see http://open.weibo.com/wiki/2/friendships/friends/in_common
     */
    AKWBOPT_GET_FRIENDSHIPS_IN_COMMON,
    /**
     *获取双向关注列表
     *@see http://open.weibo.com/wiki/2/friendships/friends/bilateral
     */
    AKWBOPT_GET_FRIENDSHIPS_BILATERAL,
    /**
     *获取双向关注ID列表
     *@see http://open.weibo.com/wiki/2/friendships/friends/bilateral/ids
     */
    AKWBOPT_GET_FRIENDSHIPS_BILATERAL_IDS,
    /**
     *获取用户关注对象uid列表
     *@see http://open.weibo.com/wiki/2/friendships/friends/ids
     */
    AKWBOPT_GET_FRIENDSHIPS_FRIENDS_IDS,
    /**
     *批量获取备注
     */
    AKWBOPT_GET_FRIENDSHIPS_FRIENDS_REMARK_BATCH,
    /**
     *获取用户粉丝列表及每个粉丝的最新一条微博
     *@see http://open.weibo.com/wiki/2/friendships/followers
     */
    AKWBOPT_GET_FRIENDSHIPS_FRIENDS_FOLLOWERS,
    /**
     *获取用户粉丝对象uid列表
     *@see http://open.weibo.com/wiki/2/friendships/followers/ids
     */
    AKWBOPT_GET_FRIENDSHIPS_FRIENDS_FOLLOWERS_IDS,
    /**
     *获取用户优质粉丝列表关系链
     *@see http://open.weibo.com/wiki/2/friendships/followers/active
     */
    AKWBOPT_GET_FRIENDSHIPS_FRIENDS_FOLLOWERS_ACTIVE,
    /**
     *获取我的关注人中关注了指定用户的分组
     *@see http://open.weibo.com/wiki/2/friendships/friends_chain/followers
     */
    AKWBOPT_GET_FRIENDSHIPS_CHAIN_FOLLOWERS,
    /**
     *获取两个用户关系的详细情况
     *@see http://open.weibo.com/wiki/2/friendships/show
     */
    AKWBOPT_GET_FRIENDSHIPS_SHOW,
    /**
     *关注某用户
     *@see http://open.weibo.com/wiki/2/friendships/create
     */
    AKWBOPT_POST_FRIENDSHIPS_CREATE,
    /**
     *批量关注用户
     */
    AKWBOPT_POST_FRIENDSHIPS_CREATE_BATCH,
    /**
     *取消关注某用户
     *@see http://open.weibo.com/wiki/2/friendships/destroy
     */
    AKWBOPT_POST_FRIENDSHIPS_DESTROY,
    /**
     *移除粉丝
     *@see http://open.weibo.com/wiki/2/friendships/followers/destroy
     */
    AKWBOPT_POST_FRIENDSHIPS_FOLLOWERS_DESTORY,
    /**
     *更新关注人备注
     *@see http://open.weibo.com/wiki/2/friendships/remark/update
     */
    AKWBOPT_POST_FRIENDSHIPS_REMARK_UPDATE,
    
    /**
     *获取当前登录用户的收藏列表
     *@see http://open.weibo.com/wiki/2/favorites
     */
    AKWBOPT_GET_FAVORITES,
    /**
     *获取单条收藏信息
     *@see http://open.weibo.com/wiki/2/favorites/show
     */
    AKWBOPT_GET_FAVORITES_SHOW,
    /**
     *获取当前用户某个标签下的收藏列表
     *@see http://open.weibo.com/wiki/2/favorites/by_tags
     */
    AKWBOPT_GET_FAVORITES_BY_TAGS,
    /**
     *当前登录用户的收藏标签列表
     *@see http://open.weibo.com/wiki/2/favorites/tags
     */
    AKWBOPT_GET_FAVORITES_TAGS,
    /**
     *添加收藏
     *@see http://open.weibo.com/wiki/2/favorites/create
     */
    AKWBOPT_POST_FAVORITES_CREATE,
    /**
     *删除收藏
     *@see http://open.weibo.com/wiki/2/favorites/destroy
     */
    AKWBOPT_POST_FAVORITES_DESTROY,
    /**
     *批量删除收藏
     *@see http://open.weibo.com/wiki/2/favorites/destroy_batch
     */
    AKWBOPT_POST_FAVORITES_DESTROY_BATCH,
    /**
     *更新收藏标签
     *@see http://open.weibo.com/wiki/2/favorites/tags/update
     */
    AKWBOPT_POST_FAVORITES_TAGS_UPDATE,
    /**
     *更新当前用户所有收藏下的指定标签
     *@see http://open.weibo.com/wiki/2/favorites/tags/update_batch
     */
    AKWBOPT_POST_FAVORITES_TAGS_UPDATE_BATCH,
    /**
     *删除当前用户所有收藏下的指定标签
     *@see http://open.weibo.com/wiki/2/favorites/tags/destroy_batch
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
     *返回最近一小时内的热门话题
     *@see http://open.weibo.com/wiki/2/trends/hourly
     */
    AKWBOPT_GET_TRENDS_HOURLY,
    /**
     *返回最近一天内的热门话题
     *@see http://open.weibo.com/wiki/2/trends/daily
     */
    AKWBOPT_GET_TRENDS_DAILY,
    /**
     *返回最近一周内的热门话题
     *@see http://open.weibo.com/wiki/2/trends/weekly
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
     *返回指定用户的标签列表
     *@see http://open.weibo.com/wiki/2/statuses/tags
     */
    AKWBOPT_GET_TAGS,
    /**
     *批量获取用户标签
     *@see http://open.weibo.com/wiki/2/statuses/tags/show_batch
     */
    AKWBOPT_GET_TAGS_TAGS_BATCH,
    /**
     *返回系统推荐的标签列表
     */
    AKWBOPT_GET_TAGS_SUGGESTIONS,
    /**
     *添加用户标签
     *@see http://open.weibo.com/wiki/2/statuses/tags/create
     */
    AKWBOPT_POST_TAGS_CREATE,
    /**
     *删除用户标签
     *@see http://open.weibo.com/wiki/2/statuses/tags/destroy
     */
    AKWBOPT_POST_TAGS_DESTROY,
    /**
     *批量删除用户标签
     */
    AKWBOPT_POST_TAGS_DESTROY_BATCH,
    
    /**
     *搜用户搜索建议
     *@see http://open.weibo.com/wiki/2/search/suggestions/users
     */
    AKWBOPT_GET_SEARCH_SUGGESTIONS_USERS,
    /**
     *搜微博搜索建议
     */
    AKWBOPT_GET_SEARCH_SUGGESTIONS_STATUSES,
    /**
     *搜学校搜索建议
     *@see http://open.weibo.com/wiki/2/search/suggestions/schools
     */
    AKWBOPT_GET_SEARCH_SUGGESTIONS_SCHOOLS,
    
    /**
     *  搜公司搜索建议
     *@see http://open.weibo.com/wiki/2/search/suggestions/companies
     */
    AKWBOPT_GET_SEARCH_SUGGESTIONS_COMPANIES,
    /**
     *搜应用搜索建议
     *@see http://open.weibo.com/wiki/2/search/suggestions/apps
     */
    AKWBOPT_GET_SEARCH_SUGGESTIONS_APPS,
    
    /**
     *  @联想搜索
     *@see http://open.weibo.com/wiki/2/search/suggestions/at_users
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
     *热门收藏
     *@see http://open.weibo.com/wiki/2/suggestions/favorites/hot
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
     *不感兴趣的人
     *@see http://open.weibo.com/wiki/2/suggestions/users/not_interested
     */
    AKWBOPT_POST_SUGGESTIONS_USERS_NOT_INTERESTED,
    /**
     *根据微博内容推荐用户
     */
    AKWBOPT_GET_SUGGESTIONS_USERS_BY_STATUS,
    
    /**
     *将一个或多个长链接转换成短链接
     *@see http://open.weibo.com/wiki/2/short_url/shorten
     */
    AKWBOPT_GET_SHORT_URL_SHORTEN,
    /**
     *将一个或多个短链接还原成原始的长链接
     *@see http://open.weibo.com/wiki/2/short_url/expand
     */
    AKWBOPT_GET_SHORT_URL_EXPAND,
    /**
     *取得一个短链接在微博上的微博分享数（包含原创和转发的微博）
     *@see http://open.weibo.com/wiki/2/short_url/share/counts
     */
    AKWBOPT_GET_SHORT_URL_SHARE_COUNTS,
    /**
     *取得包含指定单个短链接的最新微博内容
     *@see http://open.weibo.com/wiki/2/short_url/share/statuses
     */
    AKWBOPT_GET_SHORT_URL_SHARE_STATUSES,
    /**
     *取得一个短链接在微博上的微博评论数
     *@see http://open.weibo.com/wiki/2/short_url/comment/counts
     */
    AKWBOPT_GET_SHORT_URL_COMMENT_COUNTS,
    /**
     *取得包含指定单个短链接的最新微博评论内容
     *@see http://open.weibo.com/wiki/2/short_url/comment/comments
     */
    AKWBOPT_GET_SHORT_URL_COMMENT_COMMENTS,
    
    /**
     *  取得短链接的信息
     */
    AKWBOPT_GET_SHORT_URL_INFO,
    
    /**
     *获取某个用户的各种消息未读数
     *@see http://open.weibo.com/wiki/2/remind/unread_count
     */
    AKWBOPT_GET_REMIND_UNREAD_COUNT,
    /**
     *对当前登录用户某一种消息未读数进行清零
     *@see http://open.weibo.com/wiki/2/remind/set_count
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
    
    //好友分组
    /**
     *获取当前登陆用户好友分组列表
     *@see http://open.weibo.com/wiki/2/friendships/groups
     */
    AKWBOPT_GET_FRIENDSHIPS_GROUPS,
    /**
     *获取当前登录用户某一好友分组的微博列表
     *@see http://open.weibo.com/wiki/2/friendships/groups/timeline
     */
    AKWBOPT_GET_FRIENDSHIPS_GROUPS_TIMELINE,
    /**
     *获取当前登陆用户某一好友分组的微博ID列表
     *@see http://open.weibo.com/wiki/2/friendships/groups/timeline/ids
     */
    AKWBOPT_GET_FRIENDSHIPS_GROUPS_TIMELINE_IDS,
    /**
     *获取某一好友分组下的成员列表
     *@see http://open.weibo.com/wiki/2/friendships/groups/members
     */
    AKWBOPT_GET_FRIENDSHIPS_GROUPS_MEMBERS,
    /**
     *获取当前登录用户某一好友分组下的成员列表的ID
     *@see http://open.weibo.com/wiki/2/friendships/groups/members/ids
     */
    AKWBOPT_GET_FRIENDSHIPS_GROUPS_MEMBERS_IDS,
    /**
     *批量获取当前登录用户好友分组成员的分组说明
     *@see http://open.weibo.com/wiki/2/friendships/groups/members/description
     */
    AKWBOPT_GET_FRIENDSHIPS_GROUPS_MEMBERS_DESCRIPTION,
    /**
     *判断某个用户是否是当前登录用户指定好友分组内的成员
     *@see http://open.weibo.com/wiki/2/friendships/groups/is_member
     */
    AKWBOPT_GET_FRIENDSHIPS_GROUPS_IS_MEMBER,
    /**
     *批量获取某些用户在当前登录用户指定好友分组中的收录信息
     *@see http://open.weibo.com/wiki/2/friendships/groups/listed
     */
    AKWBOPT_GET_FRIENDSHIPS_GROUPS_LISTED,
    /**
     *获取当前登陆用户某个分组的详细信息
     *@see http://open.weibo.com/wiki/2/friendships/groups/show
     */
    AKWBOPT_GET_FRIENDSHIPS_GROUPS_SHOW,
    /**
     *批量获取好友分组的详细信息
     *@see http://open.weibo.com/wiki/2/friendships/groups/show_batch
     */
    AKWBOPT_GET_FRIENDSHIPS_GROUPS_SHOW_BATCH,
    /**
     *创建好友分组
     *@see http://open.weibo.com/wiki/2/friendships/groups/create
     */
    AKWBOPT_POST_FRIENDSHIPS_GROUPS_CREATE,
    /**
     *更新好友分组
     *@see http://open.weibo.com/wiki/2/friendships/groups/update
     */
    AKWBOPT_POST_FRIENDSHIPS_GROUPS_UPDATE,
    /**
     *删除好友分组
     *@see http://open.weibo.com/wiki/2/friendships/groups/destroy
     */
    AKWBOPT_POST_FRIENDSHIPS_GROUPS_DESTROY,
    /**
     *添加关注用户到好友分组
     *@see http://open.weibo.com/wiki/2/friendships/groups/members/add
     */
    AKWBOPT_POST_FRIENDSHIPS_GROUPS_MEMBERS_ADD,
    /**
     *批量添加用户到好友分组
     *@see http://open.weibo.com/wiki/2/friendships/groups/members/add_batch
     */
    AKWBOPT_POST_FRIENDSHIPS_GROUPS_MEMBERS_ADD_BATCH,
    /**
     *更新好友分组中成员的分组说明
     *@see http://open.weibo.com/wiki/2/friendships/groups/members/update
     */
    AKWBOPT_POST_FRIENDSHIPS_GROUPS_MEMBERS_UPDATE,
    /**
     *删除好友分组内的关注用户
     *@see http://open.weibo.com/wiki/2/friendships/groups/members/destroy
     */
    AKWBOPT_POST_FRIENDSHIPS_GROUPS_MEMBERS_DESTROY,
    /**
     *调整当前登录用户的好友分组顺序
     *@see http://open.weibo.com/wiki/2/friendships/groups/order
     */
    AKWBOPT_POST_FRIENDSHIPS_GROUPS_ORDER,

    
    /**
     *获取用户主页置顶微博
     *@see http://open.weibo.com/wiki/2/users/get_top_status
     */
    AKWBOPT_GET_USERS_GET_TOP_STATUS,
    /**
     *设置当前用户主页置顶微博
     *@see http://open.weibo.com/wiki/2/users/set_top_status
     */
    AKWBOPT_POST_USERS_SET_TOP_STATUS,
    /**
     *取消当前用户主页置顶微博
     *@see http://open.weibo.com/wiki/2/users/cancel_top_status
     */
    AKWBOPT_POST_USERS_CANCEL_TOP_STATUS,
    /**
     *通过地址编码获取地址名称
     *@see http://open.weibo.com/wiki/2/common/code_to_location
     */
    AKWBOPT_GET_COMMON_CODE_TO_LOCATION,
    /**
     *获取城市列表
     *@see http://open.weibo.com/wiki/2/common/get_city
     */
    AKWBOPT_GET_COMMON_GET_CITY,
    /**
     *获取省份列表
     *@see http://open.weibo.com/wiki/2/common/get_province
     */
    AKWBOPT_GET_COMMON_GET_PROVINCE,
    /**
     *获取国家列表
     *@see http://open.weibo.com/wiki/2/common/get_country
     */
    AKWBOPT_GET_COMMON_GET_COUNTRY,
    /**
     *获取时区配置表
     *@see http://open.weibo.com/wiki/2/common/get_timezone
     */
    AKWBOPT_GET_COMMON_GET_TIMEZONE,
    /**
     *获取最新20条公共的位置动态
     *@see http://open.weibo.com/wiki/2/place/public_timeline
     */
    AKWBOPT_GET_PLACE_PUBLIC_TIMELINE,
    /**
     *获取当前登录用户与其好友的位置动态
     *@see http://open.weibo.com/wiki/2/place/friends_timeline
     */
    AKWBOPT_GET_PLACE_FRIENDS_TIMELINE,
    /**
     *获取某个用户的位置动态
     *@see http://open.weibo.com/wiki/2/place/user_timeline
     */
    AKWBOPT_GET_PLACE_USER_TIMELINE,
    /**
     *获取某个位置地点的动态
     *@see http://open.weibo.com/wiki/2/place/poi_timeline
     */
    AKWBOPT_GET_PLACE_POI_TIMELINE,
    /**
     *获取某个位置周边的动态
     *@see http://open.weibo.com/wiki/2/place/nearby_timeline
     */
    AKWBOPT_GET_PLACE_NEARBY_TIMELINE,
    /**
     *根据ID获取动态的详情
     *@see http://open.weibo.com/wiki/2/place/statuses/show
     */
    AKWBOPT_GET_PLACE_STATUSES_SHOW,
    /**
     *获取LBS位置服务内的用户信息
     *@see http://open.weibo.com/wiki/2/place/users/show
     */
    AKWBOPT_GET_PLACE_USERS_SHOW,
    /**
     *获取用户签到过的地点列表
     *@see http://open.weibo.com/wiki/2/place/users/checkins
     */
    AKWBOPT_GET_PLACE_USERS_CHECKINS,
    /**
     *获取用户的照片列表
     *@see http://open.weibo.com/wiki/2/place/users/photos
     */
    AKWBOPT_GET_PLACE_USERS_PHOTOS,
    /**
     *（已废弃）获取用户的点评列表
     *@see http://open.weibo.com/wiki/2/place/users/tips
     */
    AKWBOPT_GET_PLACE_USERS_TIPS,
    /**
     *获取用户的todo列表
     *@see http://open.weibo.com/wiki/2/place/users/todos
     */
    AKWBOPT_GET_PLACE_USERS_TODOS,
    /**
     *获取地点详情
     *@see http://open.weibo.com/wiki/2/place/pois/show
     */
    AKWBOPT_GET_PLACE_POIS_SHOW,
    /**
     *获取在某个地点签到的人的列表
     *@see http://open.weibo.com/wiki/2/place/pois/users
     */
    AKWBOPT_GET_PLACE_POIS_USERS,
    /**
     *（已废弃）获取地点点评列表
     *@see http://open.weibo.com/wiki/2/place/pois/tips
     */
    AKWBOPT_GET_PLACE_POIS_TIPS,
    /**
     *获取地点照片列表
     *@see http://open.weibo.com/wiki/2/place/pois/photos
     */
    AKWBOPT_GET_PLACE_POIS_PHOTOS,
    /**
     *按省市查询地点
     *@see http://open.weibo.com/wiki/2/place/pois/search
     */
    AKWBOPT_GET_PLACE_POIS_SEARCH,
    /**
     *获取地点分类
     *@see http://open.weibo.com/wiki/2/place/pois/category
     */
    AKWBOPT_GET_PLACE_POIS_CATEGORY,
    /**
     *获取附近地点
     *@see http://open.weibo.com/wiki/2/place/nearby/pois
     */
    AKWBOPT_GET_PLACE_NEARBY_POIS,
    /**
     *获取附近发位置微博的人
     *@see http://open.weibo.com/wiki/2/place/nearby/users
     */
    AKWBOPT_GET_PLACE_NEARBY_USERS,
    /**
     *获取附近照片
     *@see http://open.weibo.com/wiki/2/place/nearby/photos
     */
    AKWBOPT_GET_PLACE_NEARBY_PHOTOS,
    /**
     *获取附近的人
     *@see http://open.weibo.com/wiki/2/place/nearby_users/list
     */
    AKWBOPT_GET_PLACE_NEARBY_USERS_LIST,
    /**
     *添加地点
     *@see http://open.weibo.com/wiki/2/place/pois/create
     */
    AKWBOPT_POST_PLACE_POIS_CREATE,
    /**
     *签到同时可以上传一张图片
     *@see http://open.weibo.com/wiki/2/place/pois/add_checkin
     */
    AKWBOPT_POST_PLACE_POIS_ADD_CHECKIN,
    /**
     *添加照片
     *@see http://open.weibo.com/wiki/2/place/pois/add_photo
     */
    AKWBOPT_POST_PLACE_POIS_ADD_PHOTO,
    /**
     *添加点评
     *@see http://open.weibo.com/wiki/2/place/pois/add_tip
     */
    AKWBOPT_POST_PLACE_POIS_ADD_TIP,
    /**
     *添加todo
     *@see http://open.weibo.com/wiki/2/place/pois/add_todo
     */
    AKWBOPT_POST_PLACE_POIS_ADD_TODO,
    /**
     *用户添加自己的位置
     *@see http://open.weibo.com/wiki/2/place/nearby_users/create
     */
    AKWBOPT_POST_PLACE_NEARBY_USERS_CREATE,
    /**
     *用户删除自己的位置
     *@see http://open.weibo.com/wiki/2/place/nearby_users/destroy
     */
    AKWBOPT_POST_PLACE_NEARBY_USERS_DESTROY,
    /**
     *生成一张静态的地图图片
     *@see http://open.weibo.com/wiki/2/location/base/get_map_image
     */
    AKWBOPT_GET_LOCATION_BASE_GET_MAP_IMAGE,
    /**
     *根据IP地址返回地理信息坐标
     *@see http://open.weibo.com/wiki/2/location/geo/ip_to_geo
     */
    AKWBOPT_GET_LOCATION_GEO_IP_TO_GEO,
    /**
     *根据实际地址返回地理信息坐标
     *@see http://open.weibo.com/wiki/2/location/geo/address_to_geo
     */
    AKWBOPT_GET_LOCATION_GEO_ADDRESS_TO_GEO,
    /**
     *根据地理信息坐标返回实际地址
     *@see http://open.weibo.com/wiki/2/location/geo/geo_to_address
     */
    AKWBOPT_GET_LOCATION_GEO_GEO_TO_ADDRESS,
    /**
     *根据GPS坐标获取偏移后的坐标
     *@see http://open.weibo.com/wiki/2/location/geo/gps_to_offset
     */
    AKWBOPT_GET_LOCATION_GEO_GPS_TO_OFFSET,
    /**
     *判断地理信息坐标是否是国内坐标
     *@see http://open.weibo.com/wiki/2/location/geo/is_domestic
     */
    AKWBOPT_GET_LOCATION_GEO_IS_DOMESTIC,
    /**
     *根据关键词按地址位置获取POI点的信息
     *@see http://open.weibo.com/wiki/2/location/pois/search/by_location
     */
    AKWBOPT_GET_LOCATION_POIS_SEARCH_BY_LOCATION,
    /**
     *根据关键词按坐标点范围获取POI点的信息
     *@see http://open.weibo.com/wiki/2/location/pois/search/by_geo
     */
    AKWBOPT_GET_LOCATION_POIS_SEARCH_BY_GEO,
    /**
     *根据关键词按矩形区域获取POI点的信息
     *@see http://open.weibo.com/wiki/2/location/pois/search/by_area
     */
    AKWBOPT_GET_LOCATION_POIS_SEARCH_BY_AREA,
    /**
     *批量获取POI点的信息
     *@see http://open.weibo.com/wiki/2/location/pois/show_batch
     */
    AKWBOPT_GET_LOCATION_POIS_SHOW_BATCH,
    /**
     *提交一个新增的POI点信息
     *@see http://open.weibo.com/wiki/2/location/pois/add
     */
    AKWBOPT_POST_LOCATION_POIS_ADD,
    /**
     *根据移动基站WIFI等数据获取当前位置信息
     *@see http://open.weibo.com/wiki/2/location/mobile/get_location
     */
    AKWBOPT_POST_LOCATION_MOBILE_GET_LOCATION,
    /**
     *根据起点与终点数据查询自驾车路线信息
     *@see http://open.weibo.com/wiki/2/location/line/drive_route
     */
    AKWBOPT_GET_LOCATION_LINE_DRIVE_ROUTE,
    /**
     *根据起点与终点数据查询公交乘坐路线信息
     *@see http://open.weibo.com/wiki/2/location/line/bus_route
     */
    AKWBOPT_GET_LOCATION_LINE_BUS_ROUTE,
    /**
     *根据关键词查询公交线路信息
     *@see http://open.weibo.com/wiki/2/location/line/bus_line
     */
    AKWBOPT_GET_LOCATION_LINE_BUS_LINE,
    /**
     *根据关键词查询公交站点信息
     *@see http://open.weibo.com/wiki/2/location/line/bus_station
     */
    AKWBOPT_GET_LOCATION_LINE_BUS_STATION,
    /**
     *地理信息平台接口中使用到的城市代码与城市名的对应列表
     *@see http://open.weibo.com/wiki/Location/citycode
     */
    AKWBOPT__LOCATION_CITYCODE,
    /**
     *公交城市对应表
     *@see http://open.weibo.com/wiki/Location/citycode_bus
     */
    AKWBOPT__LOCATION_CITYCODE_BUS,
    /**
     *地理信息平台接口中用到的分类代码对应列表
     *@see http://open.weibo.com/wiki/Location/category
     */
    AKWBOPT__LOCATION_CATEGORY,

    
    
    AKWBOPT_END
};



typedef NS_ENUM(NSUInteger, AKMessageType){
    
    /*
     follower：新粉丝数
     cmt：新评论数
     dm：新私信数
     mention_status：新提及我的微博数
     mention_cmt：新提及我的评论数
     group：微群消息数
     notice：新通知数
     invite：新邀请数
     badge：新勋章数
     photo：相册消息数
     close_friends_feeds：密友feeds未读数
     close_friends_mention_status：密友提及我的微博未读数
     close_friends_mention_cmt：密友提及我的评论未读数
     close_friends_cmt：密友评论未读数
     close_friends_attitude：密友表态未读数
     close_friends_common_cmt：密友共同评论未读数
     close_friends_invite：密友邀请未读数
     */
    
    //新粉丝数
    AKMessageTypeFollower,
    //新评论数
    AKMessageTypeComment,
    //新私信数
    AKMessageTypeDirectMessage,
    //新提及我的微博数
    AKMessageTypeMentionStatus,
    //新提及我的评论数
    AKMessageTypeMentionComment,
    //微群消息数
    AKMessageTypeGroup,
    //新通知数
    AKMessageTypeNotice,
    //新邀请数
    AKMessageTypeInvite,
    //新勋章数
    AKMessageTypeBadge,
    //相册消息数
    AKMessageTypePhoto,
    //密友feeds未读数
    AKMessageTypeCloseFriendsFeeds,
    //密友提及我的微博未读数
    AKMessageTypeCloseFriendsMentionStatus,
    //密友提及我的评论未读数
    AKMessageTypeCloseFriendsMentionComment,
    //密友评论未读数
    AKMessageTypeCloseFriendsComment,
    //密友表态未读数
    AKMessageTypeCloseFriendsAttitude,
    //密友共同评论未读数
    AKMessageTypeCloseFriendsCommonComment,
    //密友邀请未读数
    AKMessageTypeCloseFriendsInvite
    
};


@protocol AKMethodDelegate

/**
 *  请求成功结束的时候该方法将被调用。
 *
 *  @param methodOption 执行的操作
 *  @param httpHeader   http头
 *  @param result       返回结果
 *  @param pTask        用户任务信息
 */
-(void)OnDelegateCompleted:(AKMethodAction)methodOption httpHeader:(NSString *)httpHeader result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask;

/**
 *  请求失败的时候该方法将被调用
 *
 *  @param methodOption 执行的操作
 *  @param errCode      错误代码
 *  @param subErrCode   二级错误代码
 *  @param result       返回结果
 *  @param pTask        用户任务信息
 */
-(void)OnDelegateErrored:(AKMethodAction)methodOption errCode:(NSInteger)errCode subErrCode:(NSInteger)subErrCode result:(AKParsingObject *)result pTask:(AKUserTaskInfo *)pTask;
/**
 *  请求被释放的时候该方法将调用
 *
 *  @param methodOption 执行的操作
 *  @param pTask        用户任务信息
 */
-(void)OnDelegateWillRelease:(AKMethodAction)methodOption pTask:(AKUserTaskInfo *)pTask;

@end


/**
 *  定义微博API接口
 */
@protocol AKWeiboMethodProtocol

#pragma mark - 登录

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
 *  [写入接口 ]account/end_session
 *  @see http://open.weibo.com/wiki/2/account/end_session
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode)endSession;

#pragma mark - 微博

/**
 * 返回最新的200条公共微博，返回结果非完全实时
 *
 *  [读取接口]statuses/public_timeline
 *
 *  可用VariableParams参数：
 *
 *  [count] 单页返回的记录条数，最大不超过200，默认为20。
 *
 *  @see http://open.weibo.com/wiki/2/statuses/public_timeline
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getStatusesPublicTimeline:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;


/**
 *  获取当前登录用户及其所关注用户的最新微博
 *
 *  [读取接口 ]statuses/friends_timeline
 *  @see http://open.weibo.com/wiki/2/statuses/friends_timeline
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getStatusesFriendTimeline:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  获取当前登录用户及其所关注用户的最新微博
 *
 *  [读取接口 ]statuses/home_timeline
 *  @see http://open.weibo.com/wiki/2/statuses/home_timeline
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getStatusesHomeTimeline:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;


/**
 *  获取用户发布的微博
 *
 *  [读取接口 ]statuses/user_timeline
 *  @see http://open.weibo.com/wiki/2/statuses/user_timeline
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getStatusesUserTimeline:(AKID *)usrId  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  批量获取指定的一批用户的微博列表
 *
 *  [读取接口 ]statuses/timeline_batch
 *  @see http://open.weibo.com/wiki/2/statuses/timeline_batch
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getStatusesTimelineBatch:(AKID *)usrId  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;


/**
 *  返回一条原创微博的最新转发微博
 *
 *  [读取接口 ]statuses/repost_timeline
 *  @see http://open.weibo.com/wiki/2/statuses/repost_timeline
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getStatusesRepostTimeline:(NSString *)aID  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

-(AKWeiboResultCode) getStatusesRepostByMe:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  获取@当前用户的最新微博
 *
 *  [读取接口 ]statuses/mentions
 *  @see http://open.weibo.com/wiki/2/statuses/mentions
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getStatusesMentions:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  根据ID获取单条微博信息
 *
 *  [读取接口 ]statuses/show
 *  @see http://open.weibo.com/wiki/2/statuses/show
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getStatusesShow:(NSString *)aID  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;


/**
 *  根据微博ID批量获取微博信息
 *
 *  [读取接口 ]statuses/show_batch
 *  @see http://open.weibo.com/wiki/2/statuses/show_batch
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getStatusesShowBatch:(NSString *)inputIDs  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;


/**
 *  通过id获取mid
 *
 *  [读取接口 ]statuses/querymid
 *  @see http://open.weibo.com/wiki/2/statuses/querymid
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getStatusesQueryMID:(NSString *) weiboId    type:(NSInteger)type  is_batch:(NSInteger) is_batch  pTask:(AKUserTaskInfo *) pTask;

/**
 *  通过mid获取id
 *
 *  [读取接口 ]statuses/queryid
 *  @see http://open.weibo.com/wiki/2/statuses/queryid
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getStatusesQueryID:(NSString *) mId    type:(NSInteger)type  is_batch:(NSInteger) is_batch  inbox:(NSInteger) inbox  isBase62:(NSInteger) isBase62  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getStatusesRepostDaily:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getStatusesRepostWeekly:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getStatusesHotCommmentsDaily:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getStatusesHotCommmentsWeekly:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
    
    // 微博写入

/**
 *  转发一条微博信息
 *
 *  [写入接口 ]statuses/repost
 *  @see http://open.weibo.com/wiki/2/statuses/repost
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postStatusesRepost:(NSString *) weiboId   statusText:(NSString *)statusText isComment:(NSInteger)isComment  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  删除微博信息
 *
 *  [写入接口 ]statuses/destroy
 *  @see http://open.weibo.com/wiki/2/statuses/destroy
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postStatusesDestroy:(NSString *) weiboId   var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
/**
 *  发布一条微博信息
 *
 *  [写入接口 ]statuses/update
 *  @see http://open.weibo.com/wiki/2/statuses/update
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postStatusesUpdate:(NSString *)statusText  var:(AKVariableParams *) var  pTask: (AKUserTaskInfo *) pTask;

/**
 *  发布一条微博同时指定上传的图片或图片url
 *
 *  [写入接口 ]statuses/upload_url_text
 *  @see http://open.weibo.com/wiki/2/statuses/upload_url_text
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postStatusesUploadUrlText:(NSString *)statusText  picInfo:(NSString *)picInfo  isPicUrl:(BOOL)isPicUrl  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  上传图片并发布一条微博
 *
 *  [写入接口 ]statuses/upload
 *  @see http://open.weibo.com/wiki/2/statuses/upload
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postStatusesUpload:(NSString *)statusText  filePath:(NSArray *)filePath  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
    
#pragma mark - 评论

/**
 *  获取某条微博的评论列表
 *
 *  [读取接口 ]comments/show
 *  @see http://open.weibo.com/wiki/2/comments/show
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getCommentsShow:(NSString *) weiboId   var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  我发出的评论列表
 *
 *  [读取接口 ]comments/by_me
 *  @see http://open.weibo.com/wiki/2/comments/by_me
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getCommentsByMe:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;


/**
 *  我收到的评论列表
 *
 *  [读取接口 ]comments/to_me
 *  @see http://open.weibo.com/wiki/2/comments/to_me
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getCommentsToMe:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  获取用户发送及收到的评论列表
 *
 *  [读取接口 ]comments/timeline
 *  @see http://open.weibo.com/wiki/2/comments/timeline
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getCommentsTimeline:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;


/**
 *  获取@到我的评论
 *
 *  [读取接口 ]comments/mentions
 *  @see http://open.weibo.com/wiki/2/comments/mentions
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getCommentsMentions:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
    
    // 评论写入

/**
 *  批量获取评论内容
 *
 *  [读取接口 ]comments/show_batch
 *  @see http://open.weibo.com/wiki/2/comments/show_batch
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getCommentsShowBatch:(NSString *)commentIds  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  评论一条微博
 *
 *  [写入接口 ]comments/create
 *  @see http://open.weibo.com/wiki/2/comments/create
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postCommentsCreate:(NSString *)postId comment:(NSString *)comment   commentOri:(NSInteger)commentOri var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  删除一条评论
 *
 *  [写入接口 ]comments/destroy
 *  @see http://open.weibo.com/wiki/2/comments/destroy
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postCommentsDestroy:(NSString *)postId  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  批量删除评论
 *
 *  [写入接口 ]comments/destroy_batch
 *  @see http://open.weibo.com/wiki/2/comments/destroy_batch
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postCommentsDestroyBatch:(NSString *)postId  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  回复一条评论
 *
 *  [写入接口 ]comments/reply
 *  @see http://open.weibo.com/wiki/2/comments/reply
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
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
    
#pragma mark - 用户


/**
 *  获取用户信息
 *
 *  [读取接口 ]users/show
 *  @see http://open.weibo.com/wiki/2/users/show
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getUsersShow:(AKID *)usrId extend:(NSString *)extend var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  通过个性域名获取用户信息
 *
 *  [读取接口 ]users/domain_show
 *  @see http://open.weibo.com/wiki/2/users/domain_show
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getUsersDomainShow:(NSString *) domain  extend:(NSString *)extend  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;


-(AKWeiboResultCode) getUsersShowBatch:(AKID *)usrId extend:(NSString *)extend  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
    

#pragma mark - 关系

/**
 *  获取用户的关注列表
 *
 *  [关注读取接口 ]friendships/friends
 *  @see http://open.weibo.com/wiki/2/friendships/friends
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFriendshipsFriends:(AKID *)usrId   order:(NSInteger)order var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;


/**
 *  获取共同关注人列表
 *
 *  [关注读取接口 ]friendships/friends/in_common
 *  @see http://open.weibo.com/wiki/2/friendships/friends/in_common
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFriendshipsInCommon:(NSString *)aID suid:(NSString *)suid  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;


/**
 *  获取双向关注列表
 *
 *  [关注读取接口 ]friendships/friends/bilateral
 *  @see http://open.weibo.com/wiki/2/friendships/friends/bilateral
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFriendshipsBilateral:(NSString *)uid  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;

/**
 *  获取双向关注UID列表
 *
 *  [关注读取接口 ]friendships/friends/bilateral/ids
 *  @see http://open.weibo.com/wiki/2/friendships/friends/bilateral/ids
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFriendshipsBilateralIDs:(NSString *)uid  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;

/**
 *  获取用户关注对象UID列表
 *
 *  [关注读取接口 ]friendships/friends/ids
 *  @see http://open.weibo.com/wiki/2/friendships/friends/ids
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFriendshipsFriendIDs:(AKID *)usrId  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;

/**
 *  批量获取当前登录用户的关注人的备注信息
 *
 *  [关注读取接口 ]friendships/friends/remark_batch
 *  @see http://open.weibo.com/wiki/2/friendships/friends/remark_batch
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFriendshipsFriendRemarkBatch:(NSString *)uids  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;


#pragma mark - 好友分组

/**
 *  获取当前登陆用户好友分组列表
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [读取接口]friendships/groups
 *
 *  @see http://open.weibo.com/wiki/2/friendships/groups
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFriendshipsGroups:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取当前登录用户某一好友分组的微博列表
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [读取接口]friendships/groups/timeline
 *
 *  可用VariableParams参数：
 *
 *  [since_id] 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *
 *  [max_id] 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *
 *  [count] 单页返回的记录条数，最大不超过200，默认为50。
 *
 *  [page] 返回结果的页码，默认为1。
 *
 *  [base_app] 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 *
 *  [feature] 过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
 *
 *  @see http://open.weibo.com/wiki/2/friendships/groups/timeline
 *  @param list_id   需要查询的好友分组ID，建议使用返回值里的idstr，当查询的为私有分组时，则当前登录用户必须为其所有者。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFriendshipsGroupsTimeline:(long)list_id var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取当前登陆用户某一好友分组的微博ID列表
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [读取接口]friendships/groups/timeline/ids
 *
 *  可用VariableParams参数：
 *
 *  [since_id] 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *
 *  [max_id] 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *
 *  [count] 单页返回的记录条数，，最大不超过200，默认为50。
 *
 *  [page] 返回结果的页码，默认为1。
 *
 *  [base_app] 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 *
 *  [feature] 过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
 *
 *  @see http://open.weibo.com/wiki/2/friendships/groups/timeline/ids
 *  @param list_id   需要查询的好友分组ID，建议使用返回值里的idstr，当查询的为私有分组时，则当前登录用户必须为其所有者。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFriendshipsGroupsTimelineIds:(long)list_id var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取某一好友分组下的成员列表
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [读取接口]friendships/groups/members
 *
 *  可用VariableParams参数：
 *
 *  [count] 单页返回的记录条数，默认为50，最大不超过200。
 *
 *  [cursor] 分页返回结果的游标，下一页用返回值里的next_cursor，上一页用previous_cursor，默认为0。
 *
 *  @see http://open.weibo.com/wiki/2/friendships/groups/members
 *  @param list_id   好友分组ID，建议使用返回值里的idstr。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFriendshipsGroupsMembers:(long)list_id var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取当前登录用户某一好友分组下的成员列表的ID
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [读取接口]friendships/groups/members/ids
 *
 *  可用VariableParams参数：
 *
 *  [count] 单页返回的记录条数，默认为50，最大不超过200。
 *
 *  [cursor] 分页返回结果的游标，下一页用返回值里的next_cursor，上一页用previous_cursor，默认为0。
 *
 *  @see http://open.weibo.com/wiki/2/friendships/groups/members/ids
 *  @param list_id   好友分组ID，建议使用返回值里的idstr。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFriendshipsGroupsMembersIds:(long)list_id var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  批量获取当前登录用户好友分组成员的分组说明
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [读取接口]friendships/groups/members/description
 *
 *  @see http://open.weibo.com/wiki/2/friendships/groups/members/description
 *  @param uids   需要查询的好友分组成员用户UID，多个之间用逗号分隔，最多不超过100个。
 *  @param list_id   指定成员所在的好友分组ID，建议使用返回值里的idstr。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFriendshipsGroupsMembersDescription:(NSString *)uids list_id:(long)list_id var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  判断某个用户是否是当前登录用户指定好友分组内的成员
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [读取接口]friendships/groups/is_member
 *
 *  @see http://open.weibo.com/wiki/2/friendships/groups/is_member
 *  @param uid   需要判断的用户的UID。
 *  @param list_id   指定的当前用户的好友分组ID，建议使用返回值里的idstr。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFriendshipsGroupsIsMember:(long)uid list_id:(long)list_id var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  批量获取某些用户在当前登录用户指定好友分组中的收录信息
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [读取接口]friendships/groups/listed
 *
 *  @see http://open.weibo.com/wiki/2/friendships/groups/listed
 *  @param uids   需要获取好友分组信息的用户UID列表，多个之间用逗号分隔，每次不超过50个。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFriendshipsGroupsListed:(NSString *)uids var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取当前登陆用户某个分组的详细信息
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [读取接口]friendships/groups/show
 *
 *  @see http://open.weibo.com/wiki/2/friendships/groups/show
 *  @param list_id   需要查询的好友分组ID，建议使用返回值里的idstr。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFriendshipsGroupsShow:(long)list_id var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  批量获取好友分组的详细信息
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [读取接口]friendships/groups/show_batch
 *
 *  @see http://open.weibo.com/wiki/2/friendships/groups/show_batch
 *  @param list_ids   需要查询的好友分组ID，建议使用返回值里的idstr，多个之间用逗号分隔，每次不超过20个。
 *  @param uids   参数list_ids所指的好友分组的所有者UID，多个之间用逗号分隔，每次不超过20个，需与list_ids一一对应。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFriendshipsGroupsShowBatch:(long)list_ids uids:(NSString *)uids var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  创建好友分组
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [写入接口]friendships/groups/create
 *
 *  @see http://open.weibo.com/wiki/2/friendships/groups/create
 *  @param name   要创建的好友分组的名称，不超过10个汉字，20个半角字符。
 *  @param description   要创建的好友分组的描述，不超过70个汉字，140个半角字符。
 *  @param tags   要创建的好友分组的标签，多个之间用逗号分隔，最多不超过10个，每个不超过7个汉字，14个半角字符。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postFriendshipsGroupsCreate:(NSString *)name description:(NSString *)description tags:(NSString *)tags var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  更新好友分组
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [写入接口]friendships/groups/update
 *
 *  @see http://open.weibo.com/wiki/2/friendships/groups/update
 *  @param list_id   需要更新的好友分组ID，建议使用返回值里的idstr，只能更新当前登录用户自己创建的分组。
 *  @param name   好友分组更新后的名称，不超过8个汉字，16个半角字符。
 *  @param description   好友分组更新后的描述，不超过70个汉字，140个半角字符。
 *  @param tags   好友分组更新后的标签，多个之间用逗号分隔，最多不超过10个，每个不超过7个汉字，14个半角字符。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postFriendshipsGroupsUpdate:(long)list_id name:(NSString *)name description:(NSString *)description tags:(NSString *)tags var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  删除好友分组
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [写入接口]friendships/groups/destroy
 *
 *  @see http://open.weibo.com/wiki/2/friendships/groups/destroy
 *  @param list_id   要删除的好友分组ID，建议使用返回值里的idstr。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postFriendshipsGroupsDestroy:(long)list_id var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  添加关注用户到好友分组
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [写入接口]friendships/groups/members/add
 *
 *  @see http://open.weibo.com/wiki/2/friendships/groups/members/add
 *  @param uid   需要添加的用户的UID。
 *  @param list_id   好友分组ID，建议使用返回值里的idstr。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postFriendshipsGroupsMembersAdd:(long)uid list_id:(long)list_id var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  批量添加用户到好友分组
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [写入接口]friendships/groups/members/add_batch
 *
 *  @see http://open.weibo.com/wiki/2/friendships/groups/members/add_batch
 *  @param list_id   好友分组ID，建议使用返回值里的idstr。
 *  @param uids   需要添加的用户的UID，多个之间用逗号分隔，最多不超过30个。
 *  @param group_descriptions   添加成员的分组说明，每个说明最多8个汉字，16个半角字符，多个需先URLencode，然后再用半角逗号分隔，最多不超过30个，且需与uids参数一一对应。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postFriendshipsGroupsMembersAddBatch:(long)list_id uids:(NSString *)uids group_descriptions:(NSString *)group_descriptions var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  更新好友分组中成员的分组说明
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [写入接口]friendships/groups/members/update
 *
 *  @see http://open.weibo.com/wiki/2/friendships/groups/members/update
 *  @param list_id   好友分组ID，建议使用返回值里的idstr。
 *  @param uid   需要更新分组成员说明的用户的UID。
 *  @param group_description   需要更新的分组成员说明，每个说明最多8个汉字，16个半角字符，需要URLencode。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postFriendshipsGroupsMembersUpdate:(long)list_id uid:(long)uid group_description:(NSString *)group_description var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  删除好友分组内的关注用户
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [写入接口]friendships/groups/members/destroy
 *
 *  @see http://open.weibo.com/wiki/2/friendships/groups/members/destroy
 *  @param uid   需要删除的用户的UID。
 *  @param list_id   好友分组ID，建议使用返回值里的idstr。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postFriendshipsGroupsMembersDestroy:(long)uid list_id:(long)list_id var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  调整当前登录用户的好友分组顺序
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [写入接口]friendships/groups/order
 *
 *  可用VariableParams参数：
 *
 *  [count] 好友分组数量，必须与用户所有的分组数一致、与分组ID的list_id个数一致。
 *
 *  @see http://open.weibo.com/wiki/2/friendships/groups/order
 *  @param list_ids   调整好顺序后的分组ID列表，以逗号分隔，例：57,38，表示57排第一、38排第二，以此类推。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postFriendshipsGroupsOrder:(NSString *)list_ids var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;


#pragma mark - 粉丝


/**
 *  获取用户粉丝列表
 *
 *  [粉丝读取接口 ]friendships/followers
 *  @see http://open.weibo.com/wiki/2/friendships/followers
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFriendshipsFriendsFollowers:(AKID *)usrId  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  获取用户粉丝UID列表
 *
 *  [粉丝读取接口 ]friendships/followers/ids
 *  @see http://open.weibo.com/wiki/2/friendships/followers/ids
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFriendshipsFriendsFollowersIDs:(AKID *)usrId  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;

/**
 *  获取用户优质粉丝列表
 *
 *  [粉丝读取接口 ]friendships/followers/active
 *  @see http://open.weibo.com/wiki/2/friendships/followers/active
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFriendshipsFriendsFollowersActive:(AKID *)usrIDs  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;
    
    // 关系链读取

/**
 *  获取我的关注人中关注了指定用户的人
 *
 *  [关系链读取接口 ]friendships/friends_chain/followers
 *  @see http://open.weibo.com/wiki/2/friendships/friends_chain/followers
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFriendshipsFriendsChainFollowers:(NSString *)uid  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;
    
    // 关系状态
/**
 *  获取两个用户关系的详细情况
 *
 *  [关系读取接口 ]friendships/show
 *  @see http://open.weibo.com/wiki/2/friendships/show
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFriendshipShow:(AKID *)sourceId targetId:(AKID *)targetId  pTask:(AKUserTaskInfo *) pTask ;
    
    // 关系写入

/**
 *  关注某用户
 *
 *  [写入接口 ]friendships/create
 *  @see http://open.weibo.com/wiki/2/friendships/create
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postFriendshipsCreate:(AKID *)usrId   skipCheck:(NSInteger)skipCheck  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) postFriendshipsCreateBatch:(NSString *)uids  pTask:(AKUserTaskInfo *) pTask ;

/**
 *  取消关注某用户
 *
 *  [写入接口 ]friendships/destroy
 *  @see http://open.weibo.com/wiki/2/friendships/destroy
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postFriendshipsDestroy:(AKID *)usrId  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;

/**
 *  移除当前登录用户的粉丝
 *
 *  [写入接口 ]friendships/followers/destroy
 *  @see http://open.weibo.com/wiki/2/friendships/followers/destroy
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postFriendshipsFollowersDestroy:(NSString *)uid  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;

/**
 *  更新关注人备注
 *
 *  [写入接口 ]friendships/remark/update
 *  @see http://open.weibo.com/wiki/2/friendships/remark/update
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postFriendshipsRemarkUpdate:(NSString *) uid remark:(NSString *)remark  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask ;

#pragma mark - 账号


-(AKWeiboResultCode) getAccountProfileBasic:(NSString *) uid   pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) getAccountProfileEducation:(NSString *)uid  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) getAccountProfileEducationBatch:(NSString *)uids  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) getAccountProfileCareer:(NSString *)uid  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) getAccountProfileCareerBatch:(NSString *)uids  pTask:(AKUserTaskInfo *) pTask ;
/**
 *  获取隐私设置信息
 *
 *  [读取接口 ]account/get_privacy
 *  @see http://open.weibo.com/wiki/2/account/get_privacy
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getAccountGetPrivacy:(AKUserTaskInfo *) pTask ;

/**
 *  获取所有学校列表
 *
 *  [读取接口 ]account/profile/school_list
 *  @see http://open.weibo.com/wiki/2/account/profile/school_list
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getAccountProfileSchoolList:(NSInteger) province  city:(NSInteger) city  area:(NSInteger) area  type:(NSInteger) type  capital:(NSString *)capital keyword:(NSString *)keyword  counts:(NSInteger) counts  pTask:(AKUserTaskInfo *) pTask ;

/**
 *  获取当前用户API访问频率限制
 *
 *  [读取接口 ]account/rate_limit_status
 *  @see http://open.weibo.com/wiki/2/account/rate_limit_status
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getAccountRateLimitStatus:(AKUserTaskInfo *) pTask ;


/**
 *  OAuth授权之后获取用户UID（作用相当于旧版接口的 account/verify_credentials）
 *
 *  [读取接口 ]account/get_uid
 *  @see http://open.weibo.com/wiki/2/account/get_uid
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getAccountGetUID:(AKUserTaskInfo *) pTask ;
    
    // 帐号写入
-(AKWeiboResultCode) postAccountProfileBasicUpdate:(AKBasicInfo*)basic  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) postAccountProfileEduUpdate:(AKEducationInfo *)edu  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) postAccountProfileEduDestroy:(NSString *)aID  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) postAccountProfileCarUpdate:(AKCareerInfo *) career  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) postAccountProfileCarDestroy:(NSString *)aID  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) postAccountAvatarUpload:(NSString *)filePath  pTask:(AKUserTaskInfo *) pTask ;
-(AKWeiboResultCode) postAccountUpdatePrivacy:(NSInteger) comment  geo:(NSInteger) geo  message:(NSInteger) message realname:(NSInteger) realname  badge:(NSInteger) badge  mobile:(NSInteger) mobile  pTask:(AKUserTaskInfo *) pTask ;
    

#pragma mark - 收藏

/**
 *  获取当前用户的收藏列表
 *
 *  [读取接口 ]favorites
 *  @see http://open.weibo.com/wiki/2/favorites
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFavorites:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  获取单条收藏信息
 *
 *  [读取接口 ]favorites/show
 *  @see http://open.weibo.com/wiki/2/favorites/show
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFavoritesShow:(NSString *)aID  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  获取当前用户某个标签下的收藏列表
 *
 *  [读取接口 ]favorites/by_tags
 *  @see http://open.weibo.com/wiki/2/favorites/by_tags
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFavoritesByTags:(NSString *)tid  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  当前登录用户的收藏标签列表
 *
 *  [读取接口 ]favorites/tags
 *  @see http://open.weibo.com/wiki/2/favorites/tags
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getFavoritesTags:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
    
    // 收藏写入

/**
 *  添加收藏
 *
 *  [写入接口 ]favorites/create
 *  @see http://open.weibo.com/wiki/2/favorites/create
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postFavoritesCreate:(NSString *)aID  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  删除收藏
 *
 *  [写入接口 ]favorites/destroy
 *  @see http://open.weibo.com/wiki/2/favorites/destroy
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */

-(AKWeiboResultCode) postFavoritesDestroy:(NSString *)aID  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;


/**
 *  批量删除收藏
 *
 *  [写入接口 ]favorites/destroy_batch
 *  @see http://open.weibo.com/wiki/2/favorites/destroy_batch
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */

-(AKWeiboResultCode) postFavoritesDestroyBatch:(NSString *)aIDs  pTask:(AKUserTaskInfo *) pTask;


/**
 *  更新收藏标签
 *
 *  [写入接口 ]favorites/tags/update
 *  @see http://open.weibo.com/wiki/2/favorites/tags/update
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postFavoritesTagUpdate:(NSString *)tagId tagName:(NSString *)tagName  var:(AKVariableParams *)var  pTask:(AKUserTaskInfo *) pTask;


/**
 *  更新当前用户所有收藏下的指定标签
 *
 *  [写入接口 ]favorites/tags/update_batch
 *  @see http://open.weibo.com/wiki/2/favorites/tags/update_batch
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postFavoritesTagsUpdateBatch:(NSString *)tagId tagName:(NSString *)tagName  var:(AKVariableParams *)var  pTask:(AKUserTaskInfo *)pTask;

/**
 *  删除当前用户所有收藏下的指定标签
 *
 *  [写入接口 ]favorites/tags/destroy_batch
 *  @see http://open.weibo.com/wiki/2/favorites/tags/destroy_batch
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postFavoritesTagsDestroyBatch:(NSString *)tagId  var:(AKVariableParams *)var  pTask:(AKUserTaskInfo *)pTask;
    

#pragma mark - 话题

//***********************************************
//话题
//***********************************************


-(AKWeiboResultCode) getTrends:(NSString *)uid  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getTrendsStatuses:(NSString *)trendWords provinceId:(NSString *)provinceId  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  返回最近一小时内的热门话题
 *
 *  [读取接口 ]trends/hourly
 *  @see http://open.weibo.com/wiki/2/trends/hourly
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getTrendsHourly:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  返回最近一天内的热门话题
 *
 *  [读取接口 ]trends/daily
 *  @see http://open.weibo.com/wiki/2/trends/daily
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getTrendsDaily:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  返回最近一周内的热门话题
 *
 *  [读取接口 ]trends/weekly
 *  @see http://open.weibo.com/wiki/2/trends/weekly
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getTrendsWeekly:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
    
    // 话题写入
-(AKWeiboResultCode) postTrendsFollow:(NSString *)trendName  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) postTrendsDestroy:(NSString *)trendId  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;


#pragma mark - 标签
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 标签读取

/**
 *  返回指定用户的标签列表
 *
 *  [读取接口 ]tags
 *  @see http://open.weibo.com/wiki/2/tags
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getTags:(NSString *)uid  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  批量获取用户标签
 *
 *  [读取接口 ]tags/tags_batch
 *  @see http://open.weibo.com/wiki/2/tags/tags_batch
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getTagsTagsBatch:(NSString *)uids  pTask:(AKUserTaskInfo *) pTask;

/**
 *  返回系统推荐的标签列表
 *
 *  [读取接口 ]tags/suggestions
 *  @see http://open.weibo.com/wiki/2/tags/suggestions
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getTagsSuggestions:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
    
    // 标签写入

/**
 *  添加用户标签
 *
 *  [写入接口 ]tags/create
 *  @see http://open.weibo.com/wiki/2/tags/create
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postTagsCreate:(NSString *)tags  pTask:(AKUserTaskInfo *) pTask;

/**
 *  删除用户标签
 *
 *  [写入接口 ]tags/destroy
 *  @see http://open.weibo.com/wiki/2/tags/destroy
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postTagsDestroy:(NSString *)tagId  pTask:(AKUserTaskInfo *) pTask;

/**
 *  批量删除用户标签
 *
 *  [写入接口 ]tags/destroy_batch
 *  @see http://open.weibo.com/wiki/2/tags/destroy_batch
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postTagsDestroyBatch:(NSString *)tagIds  pTask:(AKUserTaskInfo *) pTask;


#pragma mark - 搜索

/**
 *  搜用户搜索建议
 *
 *  [搜索联想接口 ]search/suggestions/users
 *  @see http://open.weibo.com/wiki/2/search/suggestions/users
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getSearchSuggestionsUsers:(NSString *)q  count:(NSInteger) count  pTask:(AKUserTaskInfo *) pTask;


-(AKWeiboResultCode) getSearchSuggestionsStatues:(NSString *)q  count:(NSInteger) count  pTask:(AKUserTaskInfo *) pTask;

/**
 *  搜学校搜索建议
 *
 *  [搜索联想接口 ]search/suggestions/schools
 *  @see http://open.weibo.com/wiki/2/search/suggestions/schools
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getSearchSuggestionsSchool:(NSString *)q  count:(NSInteger) count  pTask:(AKUserTaskInfo *) pTask;

/**
 *  搜公司搜索建议
 *
 *  [搜索联想接口 ]search/suggestions/companies
 *  @see http://open.weibo.com/wiki/2/search/suggestions/companies
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getSearchSuggestionsCompanies:(NSString *)q  count:(NSInteger) count  pTask:(AKUserTaskInfo *) pTask;

/**
 *  搜应用搜索建议
 *
 *  [搜索联想接口 ]search/suggestions/apps
 *  @see http://open.weibo.com/wiki/2/search/suggestions/apps
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getSearchSuggestionsApps:(NSString *)q  count:(NSInteger) count  pTask:(AKUserTaskInfo *) pTask;

/**
 *  @联想搜索
 *
 *  [搜索联想接口 ]search/suggestions/at_users
 *  @see http://open.weibo.com/wiki/2/search/suggestions/at_users
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getSearchSuggestionsAtUsers:(NSString *)q   type:(NSInteger)type  count:(NSInteger) count  range:(NSInteger) range  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getSearchSuggestionsIntegrate:(NSString *)query  sort_user:(NSInteger) sort_user  sort_app:(NSInteger) sort_app  sort_grp:(NSInteger) sort_grp  user_count:(NSInteger) user_count  app_count:(NSInteger) app_count  grp_count:(NSInteger) grp_count  pTask:(AKUserTaskInfo *) pTask;


-(AKWeiboResultCode) getSearchStatuses:(NSString *)q  filter_ori:(NSInteger) filter_ori   filter_pic:(NSInteger)filter_pic  fuid:(NSString *)fuid province:(NSInteger) province   city:(NSInteger)city  starttime:(NSString *)starttime endtime:(NSString *)endtime  count:(NSInteger) count  page:(NSInteger) page  needcount:(BOOL)needcount  base_app:(NSInteger) base_app  pTask:(AKUserTaskInfo *) pTask;


-(AKWeiboResultCode) getSearchGeoStatuses:(float) longitude  latitudeconst:(float)latitudeconst  range:(NSInteger) range  time:(NSInteger) time sort_type:(NSInteger) sort_type  page:(NSInteger) page  count:(NSInteger) count  base_app:(NSInteger) base_app  pTask:(AKUserTaskInfo *) pTask;


-(AKWeiboResultCode) getSearchUsers:(NSString *)q  snick:(NSInteger) snick  sdomain:(NSInteger) sdomain  sintro:(NSInteger) sintro  stag:(NSInteger) stag province:(NSInteger) province   city:(NSInteger)city  gender:(NSString *)gender  comorsch:(NSString *)comorsch   sort:(NSInteger) sort count:(NSInteger) count  page:(NSInteger) page  base_app:(NSInteger) base_app  pTask:(AKUserTaskInfo *) pTask;
    
//***********************************************
//推荐
//***********************************************

/**
 *  热门收藏
 *
 *  [读取接口 ]suggestions/favorites/hot
 *  @see http://open.weibo.com/wiki/2/suggestions/favorites/hot
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getSuggestionsFavoritesHot:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  获取系统推荐用户
 *
 *  [读取接口 ]suggestions/users/hot
 *  @see http://open.weibo.com/wiki/2/suggestions/users/hot
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getSuggestionsUsersHot:(NSString *)category  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  获取用户可能感兴趣的人
 *
 *  [读取接口 ]suggestions/users/may_interested
 *  @see http://open.weibo.com/wiki/2/suggestions/users/may_interested
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getSuggestionsUsersMayInterested:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  根据微博内容推荐用户
 *
 *  [读取接口 ]suggestions/users/by_status
 *  @see http://open.weibo.com/wiki/2/suggestions/users/by_status
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getSuggestionsUsersByStatus:(NSString *)content   num:(NSInteger)num  url:(NSString *)url  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;


/**
 *  不感兴趣的人
 *
 *  [写入接口 ]suggestions/users/not_interested
 *  @see http://open.weibo.com/wiki/2/suggestions/users/not_interested
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postSuggestionsUsersNotInterested:(NSString *)uid  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
    
//***********************************************
//短链
//***********************************************

/**
 *  长链转短链
 *
 *  [转换接口 ]short_url/shorten
 *  @see http://open.weibo.com/wiki/2/short_url/shorten
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getShortURLShorten:(NSArray *)longURLs  pTask:(AKUserTaskInfo *) pTask;

/**
 *  短链转长链
 *
 *  [转换接口 ]short_url/expand
 *  @see http://open.weibo.com/wiki/2/short_url/expand
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getShortURLExpand:(NSArray *)url_shorts  pTask:(AKUserTaskInfo *) pTask;


/**
 *  获取短链接在微博上的微博分享数
 *
 *  [数据接口 ]short_url/share/counts
 *  @see http://open.weibo.com/wiki/2/short_url/share/counts
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getShortURLShareCounts:(NSString *)url_short  pTask:(AKUserTaskInfo *) pTask;

/**
 *  获取包含指定单个短链接的最新微博内容
 *
 *  [数据接口 ]short_url/share/statuses
 *  @see http://open.weibo.com/wiki/2/short_url/share/statuses
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getShortURLShareStatuses:(NSString *)url_short  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;

/**
 *  获取短链接在微博上的微博评论数
 *
 *  [数据接口 ]short_url/comment/counts
 *  @see http://open.weibo.com/wiki/2/short_url/comment/counts
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getShortURLCommentCounts:(NSString *)url_short  pTask:(AKUserTaskInfo *) pTask;

/**
 *  获取包含指定单个短链接的最新微博评论
 *
 *  [数据接口 ]short_url/comment/comments
 *  @see http://open.weibo.com/wiki/2/short_url/comment/comments
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getShortURLCommentComments:(NSString *)url_short  var:(AKVariableParams *) var  pTask:(AKUserTaskInfo *) pTask;
-(AKWeiboResultCode) getShortUrlInfo:(NSString *)shortUrlIDs  pTask:(AKUserTaskInfo *) pTask;

//***********************************************
//提醒
//***********************************************


/**
 *  获取某个用户的各种消息未读数
 *
 *  [读取接口 ]remind/unread_count
 *  @see http://open.weibo.com/wiki/2/remind/unread_count
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getRemindUnreadCount:(NSString *)uid var:(AKVariableParams *) var pTask:(AKUserTaskInfo *) pTask;


/**
 *  对当前登录用户某一种消息未读数进行清零
 *
 *  [写入接口 ]remind/set_count
 *  @see http://open.weibo.com/wiki/2/remind/set_count
 *  @param type  需要设置未读数计数的消息项，
         follower：新粉丝数、
         cmt：新评论数、
         dm：新私信数、
         mention_status：新提及我的微博数、
         mention_cmt：新提及我的评论数、
         group：微群消息数、
         notice：新通知数、
         invite：新邀请数、
         badge：新勋章数、
         photo：相册消息数、
         close_friends_feeds：密友feeds未读数、
         close_friends_mention_status：密友提及我的微博未读数、
         close_friends_mention_cmt：密友提及我的评论未读数、
         close_friends_cmt：密友评论未读数、
         close_friends_attitude：密友表态未读数、
         close_friends_common_cmt：密友共同评论未读数、
         close_friends_invite：密友邀请未读数，
         一次只能操作一项。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postStatusesResetCount:(AKMessageType)type  pTask:(AKUserTaskInfo *) pTask;


/**
 *  获取用户主页置顶微博
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [读取接口]users/get_top_status
 *
 *  @see http://open.weibo.com/wiki/2/users/get_top_status
 *  @param uid   需要查询的用户UID。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getUsersGetTopStatus:(long)uid var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  设置当前用户主页置顶微博
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [写入接口]users/set_top_status
 *
 *  @see http://open.weibo.com/wiki/2/users/set_top_status
 *  @param id   需要设置为置顶微博的微博ID。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postUsersSetTopStatus:(long)id var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  取消当前用户主页置顶微博
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [写入接口]users/cancel_top_status
 *
 *  @see http://open.weibo.com/wiki/2/users/cancel_top_status
 *  @param id   需要取消设置为置顶微博的微博ID。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postUsersCancelTopStatus:(long)id var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  通过地址编码获取地址名称
 *
 *  访问级别：普通接口
 *
 *  [读取接口]common/code_to_location
 *
 *  @see http://open.weibo.com/wiki/2/common/code_to_location
 *  @param codes   需要查询的地址编码，多个之间用逗号分隔。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getCommonCodeToLocation:(NSString *)codes var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取城市列表
 *
 *  访问级别：普通接口
 *
 *  [读取接口]common/get_city
 *
 *  @see http://open.weibo.com/wiki/2/common/get_city
 *  @param province   省份的省份代码。
 *  @param capital   城市的首字母，a-z，可为空代表返回全部，默认为全部。
 *  @param language   返回的语言版本，zh-cn：简体中文、zh-tw：繁体中文、english：英文，默认为zh-cn。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getCommonGetCity:(NSString *)province capital:(NSString *)capital language:(NSString *)language var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取省份列表
 *
 *  访问级别：普通接口
 *
 *  [读取接口]common/get_province
 *
 *  @see http://open.weibo.com/wiki/2/common/get_province
 *  @param country   国家的国家代码。
 *  @param capital   省份的首字母，a-z，可为空代表返回全部，默认为全部。
 *  @param language   返回的语言版本，zh-cn：简体中文、zh-tw：繁体中文、english：英文，默认为zh-cn。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getCommonGetProvince:(NSString *)country capital:(NSString *)capital language:(NSString *)language var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取国家列表
 *
 *  访问级别：普通接口
 *
 *  [读取接口]common/get_country
 *
 *  @see http://open.weibo.com/wiki/2/common/get_country
 *  @param capital   国家的首字母，a-z，可为空代表返回全部，默认为全部。
 *  @param language   返回的语言版本，zh-cn：简体中文、zh-tw：繁体中文、english：英文，默认为zh-cn。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getCommonGetCountry:(NSString *)capital language:(NSString *)language var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取时区配置表
 *
 *  访问级别：普通接口
 *
 *  [读取接口]common/get_timezone
 *
 *  @see http://open.weibo.com/wiki/2/common/get_timezone
 *  @param language   返回的语言版本，zh-cn：简体中文、zh-tw：繁体中文、english：英文，默认为zh-cn。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getCommonGetTimezone:(NSString *)language var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取最新20条公共的位置动态
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [读取接口]place/public_timeline
 *
 *  可用VariableParams参数：
 *
 *  [count] 每次返回的动态数，最大为50，默认为20。
 *
 *  [base_app] 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 *
 *  @see http://open.weibo.com/wiki/2/place/public_timeline
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getPlacePublicTimeline:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取当前登录用户与其好友的位置动态
 *
 *  访问级别：普通接口
 *
 *  [读取接口]place/friends_timeline
 *
 *  可用VariableParams参数：
 *
 *  [since_id] 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *
 *  [max_id] 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *
 *  [count] 单页返回的记录条数，最大为50，默认为20。
 *
 *  [page] 返回结果的页码，默认为1。
 *
 *  @see http://open.weibo.com/wiki/2/place/friends_timeline
 *  @param type   关系过滤，0：仅返回关注的，1：返回好友的，默认为0。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getPlaceFriendsTimeline:(NSInteger)type var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取某个用户的位置动态
 *
 *  访问级别：普通接口
 *
 *  [读取接口]place/user_timeline
 *
 *  可用VariableParams参数：
 *
 *  [since_id] 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *
 *  [max_id] 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *
 *  [count] 单页返回的记录条数，最大为50，默认为20。
 *
 *  [page] 返回结果的页码，默认为1。
 *
 *  [base_app] 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 *
 *  @see http://open.weibo.com/wiki/2/place/user_timeline
 *  @param uid   需要查询的用户ID。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getPlaceUserTimeline:(long)uid var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取某个位置地点的动态
 *
 *  访问级别：普通接口
 *
 *  [读取接口]place/poi_timeline
 *
 *  可用VariableParams参数：
 *
 *  [since_id] 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *
 *  [max_id] 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *
 *  [count] 单页返回的记录条数，最大为50，默认为20。
 *
 *  [page] 返回结果的页码，默认为1。
 *
 *  [base_app] 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 *
 *  @see http://open.weibo.com/wiki/2/place/poi_timeline
 *  @param poiid   需要查询的POI点ID。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getPlacePoiTimeline:(NSString *)poiid var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取某个位置周边的动态
 *
 *  访问级别：普通接口
 *
 *  [读取接口]place/nearby_timeline
 *
 *  可用VariableParams参数：
 *
 *  [sort] 排序方式。默认为0，按时间排序；为1时按与中心点距离进行排序。
 *
 *  [count] 单页返回的记录条数，最大为50，默认为20。
 *
 *  [page] 返回结果的页码，默认为1。
 *
 *  [base_app] 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 *
 *  @see http://open.weibo.com/wiki/2/place/nearby_timeline
 *  @param lat   纬度。有效范围：-90.0到+90.0，+表示北纬。
 *  @param long   经度。有效范围：-180.0到+180.0，+表示东经。
 *  @param range   搜索范围，单位米，默认2000米，最大11132米。
 *  @param starttime   开始时间，Unix时间戳。
 *  @param endtime   结束时间，Unix时间戳。
 *  @param offset   传入的经纬度是否是纠偏过，0：没纠偏、1：纠偏过，默认为0。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getPlaceNearbyTimeline:(float)latitude longitude:(float)longitude range:(NSInteger)range starttime:(NSInteger)starttime endtime:(NSInteger)endtime offset:(NSInteger)offset var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  根据ID获取动态的详情
 *
 *  访问级别：普通接口
 *
 *  [读取接口]place/statuses/show
 *
 *  @see http://open.weibo.com/wiki/2/place/statuses/show
 *  @param id   需要获取的动态ID。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getPlaceStatusesShow:(long)id var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取LBS位置服务内的用户信息
 *
 *  访问级别：普通接口
 *
 *  [读取接口]place/users/show
 *
 *  可用VariableParams参数：
 *
 *  [base_app] 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 *
 *  @see http://open.weibo.com/wiki/2/place/users/show
 *  @param uid   需要查询的用户ID。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getPlaceUsersShow:(long)uid var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取用户签到过的地点列表
 *
 *  访问级别：普通接口
 *
 *  [读取接口]place/users/checkins
 *
 *  可用VariableParams参数：
 *
 *  [count] 单页返回的记录条数，默认为20，最大为50。
 *
 *  [page] 返回结果的页码，默认为1。
 *
 *  [base_app] 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 *
 *  @see http://open.weibo.com/wiki/2/place/users/checkins
 *  @param uid   需要查询的用户ID。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getPlaceUsersCheckins:(long)uid var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取用户的照片列表
 *
 *  访问级别：普通接口
 *
 *  [读取接口]place/users/photos
 *
 *  可用VariableParams参数：
 *
 *  [count] 单页返回的记录条数，默认为20，最大为50。
 *
 *  [page] 返回结果的页码，默认为1。
 *
 *  [base_app] 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 *
 *  @see http://open.weibo.com/wiki/2/place/users/photos
 *  @param uid   需要查询的用户ID。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getPlaceUsersPhotos:(long)uid var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  （已废弃）获取用户的点评列表
 *
 *  访问级别：普通接口
 *
 *  [读取接口]place/users/tips
 *
 *  可用VariableParams参数：
 *
 *  [count] 单页返回的记录条数，默认为20，最大为50。
 *
 *  [page] 返回结果的页码，默认为1。
 *
 *  [base_app] 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 *
 *  @see http://open.weibo.com/wiki/2/place/users/tips
 *  @param uid   需要查询的用户ID。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getPlaceUsersTips:(long)uid var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取用户的todo列表
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [读取接口]place/users/todos
 *
 *  可用VariableParams参数：
 *
 *  [count] 单页返回的记录条数，默认为20，最大为50。
 *
 *  [page] 返回结果的页码，默认为1。
 *
 *  [base_app] 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 *
 *  @see http://open.weibo.com/wiki/2/place/users/todos
 *  @param uid   需要查询的用户ID。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getPlaceUsersTodos:(long)uid var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取地点详情
 *
 *  访问级别：普通接口
 *
 *  [读取接口]place/pois/show
 *
 *  可用VariableParams参数：
 *
 *  [base_app] 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 *
 *  @see http://open.weibo.com/wiki/2/place/pois/show
 *  @param poiid   需要查询的POI地点ID。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getPlacePoisShow:(NSString *)poiid var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取在某个地点签到的人的列表
 *
 *  访问级别：普通接口
 *
 *  [读取接口]place/pois/users
 *
 *  可用VariableParams参数：
 *
 *  [count] 单页返回的记录条数，默认为20，最大为50。
 *
 *  [page] 返回结果的页码，默认为1。
 *
 *  [base_app] 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 *
 *  @see http://open.weibo.com/wiki/2/place/pois/users
 *  @param poiid   需要查询的POI地点ID。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getPlacePoisUsers:(NSString *)poiid var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  （已废弃）获取地点点评列表
 *
 *  访问级别：普通接口
 *
 *  [读取接口]place/pois/tips
 *
 *  可用VariableParams参数：
 *
 *  [count] 单页返回的记录条数，默认为20，最大为50。
 *
 *  [page] 返回结果的页码，默认为1。
 *
 *  [sort] 排序方式，0：按时间、1：按热门，默认为0，目前只支持0。
 *
 *  [base_app] 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 *
 *  @see http://open.weibo.com/wiki/2/place/pois/tips
 *  @param poiid   需要查询的POI地点ID。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getPlacePoisTips:(NSString *)poiid var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取地点照片列表
 *
 *  访问级别：普通接口
 *
 *  [读取接口]place/pois/photos
 *
 *  可用VariableParams参数：
 *
 *  [count] 单页返回的记录条数，默认为20，最大为50。
 *
 *  [page] 返回结果的页码，默认为1。
 *
 *  [sort] 排序方式，0：按时间、1：按热门，默认为0，目前只支持0。
 *
 *  [base_app] 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 *
 *  @see http://open.weibo.com/wiki/2/place/pois/photos
 *  @param poiid   需要查询的POI地点ID。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getPlacePoisPhotos:(NSString *)poiid var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  按省市查询地点
 *
 *  访问级别：普通接口
 *
 *  [读取接口]place/pois/search
 *
 *  可用VariableParams参数：
 *
 *  [page] 返回结果的页码，默认为1。
 *
 *  [count] 单页返回的记录条数，默认为20，最大为50。
 *
 *  @see http://open.weibo.com/wiki/2/place/pois/search
 *  @param keyword   查询的关键词，必须进行URLencode。
 *  @param city   城市代码，默认为全国搜索。
 *  @param category   查询的分类代码，取值范围见：分类代码对应表。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getPlacePoisSearch:(NSString *)keyword city:(NSString *)city category:(NSString *)category var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取地点分类
 *
 *  访问级别：普通接口
 *
 *  [读取接口]place/pois/category
 *
 *  @see http://open.weibo.com/wiki/2/place/pois/category
 *  @param pid   父分类ID，默认为0。
 *  @param flag   是否返回全部分类，0：只返回本级下的分类，1：返回全部分类，默认为0。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getPlacePoisCategory:(NSInteger)pid flag:(NSInteger)flag var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取附近地点
 *
 *  访问级别：普通接口
 *
 *  [读取接口]place/nearby/pois
 *
 *  可用VariableParams参数：
 *
 *  [count] 单页返回的记录条数，默认为20，最大为50。
 *
 *  [page] 返回结果的页码，默认为1。
 *
 *  [sort] 排序方式，0：按权重，1：按距离，3：按签到人数。默认为0。
 *
 *  @see http://open.weibo.com/wiki/2/place/nearby/pois
 *  @param lat   纬度，有效范围：-90.0到+90.0，+表示北纬。
 *  @param long   经度，有效范围：-180.0到+180.0，+表示东经。
 *  @param range   查询范围半径，默认为2000，最大为10000，单位米。
 *  @param q   查询的关键词，必须进行URLencode。
 *  @param category   查询的分类代码，取值范围见：分类代码对应表。
 *  @param offset   传入的经纬度是否是纠偏过，0：没纠偏、1：纠偏过，默认为0。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getPlaceNearbyPois:(float)latitude longitude:(float)longitude range:(NSInteger)range q:(NSString *)q category:(NSString *)category offset:(NSInteger)offset var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取附近发位置微博的人
 *
 *  访问级别：普通接口
 *
 *  [读取接口]place/nearby/users
 *
 *  可用VariableParams参数：
 *
 *  [count] 单页返回的记录条数，默认为20，最大为50。
 *
 *  [page] 返回结果的页码，默认为1。
 *
 *  [sort] 排序方式，0：按时间、1：按距离，默认为0。
 *
 *  @see http://open.weibo.com/wiki/2/place/nearby/users
 *  @param lat   纬度，有效范围：-90.0到+90.0，+表示北纬。
 *  @param long   经度，有效范围：-180.0到+180.0，+表示东经。
 *  @param range   查询范围半径，默认为2000，最大为11132，单位米。
 *  @param starttime   开始时间，Unix时间戳。
 *  @param endtime   结束时间，Unix时间戳。
 *  @param offset   传入的经纬度是否是纠偏过，0：没纠偏、1：纠偏过，默认为0。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getPlaceNearbyUsers:(float)latitude longitude:(float)longitude range:(NSInteger)range starttime:(long)starttime endtime:(long)endtime offset:(NSInteger)offset var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取附近照片
 *
 *  访问级别：普通接口
 *
 *  [读取接口]place/nearby/photos
 *
 *  可用VariableParams参数：
 *
 *  [count] 单页返回的记录条数，默认为20，最大为50。
 *
 *  [page] 返回结果的页码，默认为1。
 *
 *  [sort] 排序方式，0：按时间、1：按距离，默认为0。
 *
 *  @see http://open.weibo.com/wiki/2/place/nearby/photos
 *  @param lat   纬度，有效范围：-90.0到+90.0，+表示北纬。
 *  @param long   经度，有效范围：-180.0到+180.0，+表示东经。
 *  @param range   查询范围半径，默认为500，最大为11132，单位米。
 *  @param starttime   开始时间，Unix时间戳。
 *  @param endtime   结束时间，Unix时间戳。
 *  @param offset   传入的经纬度是否是纠偏过，0：没纠偏、1：纠偏过，默认为0。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getPlaceNearbyPhotos:(float)latitude longitude:(float)longitude range:(NSInteger)range starttime:(long)starttime endtime:(long)endtime offset:(NSInteger)offset var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  获取附近的人
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [读取接口]place/nearby_users/list
 *
 *  可用VariableParams参数：
 *
 *  [count] 单页返回的记录条数，最大为50，默认为20。
 *
 *  [page] 返回结果的页码，默认为1。
 *
 *  [sort] 排序方式，0：按时间、1：按距离、2：按社会化关系，默认为2。
 *
 *  @see http://open.weibo.com/wiki/2/place/nearby_users/list
 *  @param lat   动态发生的纬度，有效范围：-90.0到+90.0，+表示北纬，默认为0.0。
 *  @param long   动态发生的经度，有效范围：-180.0到+180.0，+表示东经，默认为0.0。
 *  @param range   查询范围半径，默认为2000，最大为11132。
 *  @param filter   （暂未启用）用户关系过滤，0：全部、1：只返回陌生人、2：只返回关注人，默认为0。
 *  @param gender   性别过滤，0：全部、1：男、2：女，默认为0。
 *  @param level   用户级别过滤，0：全部、1：普通用户、2：VIP用户、7：达人，默认为0。
 *  @param startbirth   与参数endbirth一起定义过滤年龄段，数值为年龄大小，默认为空。
 *  @param endbirth   与参数startbirth一起定义过滤年龄段，数值为年龄大小，默认为空。
 *  @param offset   传入的经纬度是否是纠偏过，0：没纠偏、1：纠偏过，默认为0。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getPlaceNearbyUsersList:(float)latitude longitude:(float)longitude range:(NSInteger)range filter:(NSInteger)filter gender:(NSInteger)gender level:(NSInteger)level startbirth:(NSInteger)startbirth endbirth:(NSInteger)endbirth offset:(NSInteger)offset var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  添加地点
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [写入接口]place/pois/create
 *
 *  @see http://open.weibo.com/wiki/2/place/pois/create
 *  @param title   POI点的名称，不超过30个字符，必须进行URLencode。
 *  @param address   POI点的地址，不超过60个字符，必须进行URLencode。
 *  @param category   POI的类型分类代码，取值范围见：分类代码对应表，默认为500。
 *  @param lat   纬度，有效范围：-90.0到+90.0，+表示北纬。
 *  @param long   经度，有效范围：-180.0到+180.0，+表示东经。
 *  @param city   城市代码。
 *  @param province   省份代码。
 *  @param country   国家代码。
 *  @param phone   POI点的电话，不超过14个字符。
 *  @param postcode   POI点的邮编。
 *  @param extra   其他，必须进行URLencode。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postPlacePoisCreate:(NSString *)title address:(NSString *)address category:(NSInteger)category lat:(float)latitude longitude:(float)longitude city:(NSString *)city province:(NSInteger)province country:(NSInteger)country phone:(NSString *)phone postcode:(NSString *)postcode extra:(NSString *)extra var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  签到同时可以上传一张图片
 *
 *  访问级别：普通接口
 *
 *  [写入接口]place/pois/add_checkin
 *
 *  @see http://open.weibo.com/wiki/2/place/pois/add_checkin
 *  @param poiid   需要签到的POI地点ID。
 *  @param status   签到时发布的动态内容，必须做URLencode，内容不超过140个汉字。
 *  @param pic   需要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
 *  @param public   是否同步到微博，1：是、0：否，默认为0。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postPlacePoisAddCheckin:(NSString *)poiid status:(NSString *)status pic:(NSImage *)pic isPublic:(NSInteger)isPublic var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  添加照片
 *
 *  访问级别：普通接口
 *
 *  [写入接口]place/pois/add_photo
 *
 *  @see http://open.weibo.com/wiki/2/place/pois/add_photo
 *  @param poiid   需要添加照片的POI地点ID。
 *  @param status   签到时发布的动态内容，必须做URLencode，内容不超过140个汉字。
 *  @param pic   需要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
 *  @param public   是否同步到微博，1：是、0：否，默认为0。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postPlacePoisAddPhoto:(NSString *)poiid status:(NSString *)status pic:(NSImage *)pic isPublic:(NSInteger)isPublic var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  添加点评
 *
 *  访问级别：普通接口
 *
 *  [写入接口]place/pois/add_tip
 *
 *  @see http://open.weibo.com/wiki/2/place/pois/add_tip
 *  @param poiid   需要点评的POI地点ID。
 *  @param status   点评时发布的动态内容，必须做URLencode，内容不超过140个汉字。
 *  @param public   是否同步到微博，1：是、0：否，默认为0。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postPlacePoisAddTip:(NSString *)poiid status:(NSString *)status isPublic:(NSInteger)isPublic var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  添加todo
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [写入接口]place/pois/add_todo
 *
 *  @see http://open.weibo.com/wiki/2/place/pois/add_todo
 *  @param poiid   需要添加todo的POI地点ID。
 *  @param status   添加todo时发布的动态内容，必须做URLencode，内容不超过140个汉字。
 *  @param public   是否同步到微博，1：是、0：否，默认为0。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postPlacePoisAddTodo:(NSString *)poiid status:(NSString *)status isPublic:(NSInteger)isPublic var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  用户添加自己的位置
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [写入接口]place/nearby_users/create
 *
 *  @see http://open.weibo.com/wiki/2/place/nearby_users/create
 *  @param lat   纬度，有效范围：-90.0到+90.0，+表示北纬。
 *  @param long   经度，有效范围：-180.0到+180.0，+表示东经。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postPlaceNearbyUsersCreate:(float)latitude longitude:(float)longitude var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  用户删除自己的位置
 *
 *  访问级别：高级接口（需要授权）
 *
 *  [写入接口]place/nearby_users/destroy
 *
 *  @see http://open.weibo.com/wiki/2/place/nearby_users/destroy
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postPlaceNearbyUsersDestroy:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  生成一张静态的地图图片
 *
 *  访问级别：普通接口
 *
 *  [读取接口]location/base/get_map_image
 *
 *  @see http://open.weibo.com/wiki/2/location/base/get_map_image
 *  @param center_coordinate   中心点坐标，经度纬度用逗号分隔，与城市代码两者必选其一，中心点坐标优先。
 *  @param city   城市代码，与中心点坐标两者必选其一，中心点坐标优先。
 *  @param coordinates   地图上标点的坐标串，经度纬度用逗号分隔，多个坐标间用“|”分隔，最多不超过10个。示例：coordinates=120.0358,23.1014|116.0358,38.1014。
 *  @param names   地图上标点的名称串，多个名称用逗号分隔，最多不超过10个，数量必须与coordinates参数一致，超出的无效。
 *  @param offset_x   x轴偏移方向，东移为正，西移为负，偏移单位为1/4图片宽度，示例：offset_x=1，地图向右移动1/4。
 *  @param offset_y   y轴偏移方向，北移为正，南移为负，偏移单位为1/4图片高度，示例：offset_y=1，地图向上移动1/4。
 *  @param font   字体格式，参数形式为：”字体,字体风格,字号,字体颜色,背景颜色,是否有背景“，其中是否有背景（0：无，1：有），示例：font=宋体,1,20,0XFF0C0C,0XFFFF00,1，默认值为“宋体,1,20,0XFF0CC0,0XFFFFE0,1”，字号最大不超过72号字，如果coordinates参数不存在则font参数无效。
 *  @param lines   在地图中画一条线，参数形式为：“线的颜色,线的宽度,线的拐点坐标”，拐点坐标经度纬度用逗号分隔，多个坐标间用“|”分隔，最多不超过10个，示例：lines=0XFF0000,2,116.32,39.96|116.12,39.96，取值范围为：线的宽度0-50。
 *  @param polygons   在地图中画一个多边形，参数形式为：“边框颜色,边框宽度,填充颜色,填充透明度,多边形的拐点坐标”，拐点坐标经度纬度用逗号分隔，多个坐标间用“|”分隔，最多不超过10个，示例：polygons=0XFF0000,1,0XFF0000,50,116.32,39.96|116.12,39.96|116.32,39.86，取值范围：边框宽度0-50，默认为1、填充透明度0（透明）-100（不透明），默认为50。
 *  @param size   生成的地图大小，格式为宽×高，最大值为800，默认为240，示例：size=480×360，注意：“x”为小写“x”字母，非“＊”号字符。
 *  @param format   生成的地图的图片格式，支持png、jpg等格式，参数全部为小写，默认为png。
 *  @param zoom   地图焦距等级，取值范围为1-17，默认为自适应大小。
 *  @param scale   是否显示比例尺，true：是，false：否。
 *  @param traffic   是否需要叠加实际交通地图，true：是，false：否。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getLocationBaseGetMapImage:(NSString *)center_coordinate city:(NSString *)city coordinates:(NSString *)coordinates names:(NSString *)names offset_x:(NSString *)offset_x offset_y:(NSString *)offset_y font:(NSString *)font lines:(NSString *)lines polygons:(NSString *)polygons size:(NSString *)size format:(NSString *)format zoom:(NSString *)zoom scale:(BOOL)scale traffic:(BOOL)traffic var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  根据IP地址返回地理信息坐标
 *
 *  访问级别：普通接口
 *
 *  [读取接口]location/geo/ip_to_geo
 *
 *  @see http://open.weibo.com/wiki/2/location/geo/ip_to_geo
 *  @param ip   需要获取坐标的IP地址，多个IP用逗号分隔，最多不超过10个。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getLocationGeoIpToGeo:(NSString *)ip var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  根据实际地址返回地理信息坐标
 *
 *  访问级别：普通接口
 *
 *  [读取接口]location/geo/address_to_geo
 *
 *  @see http://open.weibo.com/wiki/2/location/geo/address_to_geo
 *  @param address   需要获取坐标的实际地址，必须进行URLencode。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getLocationGeoAddressToGeo:(NSString *)address var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  根据地理信息坐标返回实际地址
 *
 *  访问级别：普通接口
 *
 *  [读取接口]location/geo/geo_to_address
 *
 *  @see http://open.weibo.com/wiki/2/location/geo/geo_to_address
 *  @param coordinate   需要获取实际地址的坐标，经度纬度用逗号分隔。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getLocationGeoGeoToAddress:(NSString *)coordinate var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  根据GPS坐标获取偏移后的坐标
 *
 *  访问级别：普通接口
 *
 *  [读取接口]location/geo/gps_to_offset
 *
 *  @see http://open.weibo.com/wiki/2/location/geo/gps_to_offset
 *  @param coordinate   需要获取偏移坐标的源坐标，经度纬度用逗号分隔。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getLocationGeoGpsToOffset:(NSString *)coordinate var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  判断地理信息坐标是否是国内坐标
 *
 *  访问级别：普通接口
 *
 *  [读取接口]location/geo/is_domestic
 *
 *  @see http://open.weibo.com/wiki/2/location/geo/is_domestic
 *  @param coordinates   需要判断的坐标，格式：经度,纬度,字符标识|经度,纬度,字符标识。其中经度纬度用逗号分隔，字符标识用于返回结果中的返回值标识。“|”分隔多个坐标。一次最多50个坐标。示例：coordinates=120.035847163,23.1014362572,g1|116.035847163,38.1014362572,g2。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getLocationGeoIsDomestic:(NSString *)coordinates var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  根据关键词按地址位置获取POI点的信息
 *
 *  访问级别：普通接口
 *
 *  [读取接口]location/pois/search/by_location
 *
 *  可用VariableParams参数：
 *
 *  [page] 返回结果的页码，默认为1，最大为40。
 *
 *  [count] 单页返回的记录条数，默认为10，最大为20。
 *
 *  @see http://open.weibo.com/wiki/2/location/pois/search/by_location
 *  @param q   查询的关键词，必须进行URLencode，与category参数必选其一。
 *  @param category   查询的分类代码，与q参数必选其一，取值范围见：分类代码对应表。
 *  @param city   城市代码，默认为全国搜索。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getLocationPoisSearchByLocation:(NSString *)q category:(NSString *)category city:(NSString *)city var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  根据关键词按坐标点范围获取POI点的信息
 *
 *  访问级别：普通接口
 *
 *  [读取接口]location/pois/search/by_geo
 *
 *  可用VariableParams参数：
 *
 *  [page] 返回结果的页码，默认为1，最大为40。
 *
 *  [count] 单页返回的记录条数，默认为10，最大为200。
 *
 *  @see http://open.weibo.com/wiki/2/location/pois/search/by_geo
 *  @param q   查询的关键词，必须进行URLencode。
 *  @param coordinate   查询的中心点坐标，经度纬度用逗号分隔。例：116.322479,39.980781。
 *  @param cenname   中心点名称，如：理想国际大厦。
 *  @param city   城市编码:支持编码和名称形式，如0010或者北京，需要进行urlencode编码，默认为全国搜索。
 *  @param range   查询范围半径，默认为3000。
 *  @param searchtype   查询类型:POI分类类型，需要进行urlencode编码，如：住宅小区。
 *  @param srctype   数据源类型，POI：基础库，BUS：公交站台。可混合查询。例如公交数据+基础库数据查询，srctype取值为“BUS:1000%2bPOI ”，代表前1000条数据为公交数据，后面为基础库数据。
 *  @param naviflag   航距离排序标识， 默认为0，不按照导航距离排序，如果为1将按照导航距离排序，但性能比直线距离排序差。
 *  @param sr   排序参数， sr为1代表按照距离排序。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getLocationPoisSearchByGeo:(NSString *)q coordinate:(NSString *)coordinate cenname:(NSString *)cenname city:(NSString *)city range:(NSString *)range searchtype:(NSString *)searchtype srctype:(NSString *)srctype naviflag:(NSInteger)naviflag sr:(NSInteger)sr var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  根据关键词按矩形区域获取POI点的信息
 *
 *  访问级别：普通接口
 *
 *  [读取接口]location/pois/search/by_area
 *
 *  可用VariableParams参数：
 *
 *  [page] 返回结果的页码，默认为1，最大为40。
 *
 *  [count] 单页返回的记录条数，默认为10，最大为20。
 *
 *  @see http://open.weibo.com/wiki/2/location/pois/search/by_area
 *  @param q   查询的关键词，必须进行URLencode，与category参数必选其一。
 *  @param category   查询的分类代码，与q参数必选其一，取值范围见：分类代码对应表。
 *  @param coordinates   查询的矩形区域坐标，第一个坐标为左上角的点，第二个为右下角，经度纬度用逗号分隔，坐标间用“|”分隔，示例：coordinates=116.37,39.93|116.43,39.91。
 *  @param city   城市代码，默认为全国搜索。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getLocationPoisSearchByArea:(NSString *)q category:(NSString *)category coordinates:(NSString *)coordinates city:(NSString *)city var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  批量获取POI点的信息
 *
 *  访问级别：普通接口
 *
 *  [读取接口]location/pois/show_batch
 *
 *  @see http://open.weibo.com/wiki/2/location/pois/show_batch
 *  @param srcids   需要获取POI的来源ID，是由用户通过add接口自己提交的，多个ID用逗号分隔，最多不超过5个。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getLocationPoisShowBatch:(NSString *)srcids var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  提交一个新增的POI点信息
 *
 *  访问级别：普通接口
 *
 *  [写入接口]location/pois/add
 *
 *  @see http://open.weibo.com/wiki/2/location/pois/add
 *  @param srcid   来源ID，用户自己设置，用于取回自己提交的POI信息，为2-8位的数字。
 *  @param name   POI点的名称，不超过30个字符，UTF-8编码。
 *  @param address   POI点的地址，不超过60个字符，UTF-8编码。
 *  @param city_name   POI点的城市中文名称，不超过30个字符，UTF-8编码。
 *  @param category   POI点的类别中文名称，不超过30个字符，UTF-8编码。
 *  @param longitude   POI点的经度，2-15个字符，在180到-180之间。
 *  @param latitude   POI点的维度，2-15个字符，在90到-90之间。
 *  @param telephone   POI点的电话，不超过14个字符。
 *  @param pic_url   POI点的图片地址，不超过60个字符。
 *  @param url   POI点的网址，不超过60个字符。
 *  @param tags   POI点的标签，多个标签之间用逗号分隔，不超过60个字符，UTF-8编码。
 *  @param description   POI点的介绍，不超过120个字符，UTF-8编码。
 *  @param intro   POI点的其他特色信息，不超过120个字符，可以以JSON字符串方式提交，UTF-8编码。
 *  @param traffic   POI点的交通情况描述，不超过120个字符，UTF-8编码。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postLocationPoisAdd:(NSInteger)srcid name:(NSString *)name address:(NSString *)address city_name:(NSString *)city_name category:(NSString *)category longitude:(NSString *)longitude latitude:(NSString *)latitude telephone:(NSString *)telephone pic_url:(NSString *)pic_url url:(NSString *)url tags:(NSString *)tags description:(NSString *)description intro:(NSString *)intro traffic:(NSString *)traffic var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  根据移动基站WIFI等数据获取当前位置信息
 *
 *  访问级别：普通接口
 *
 *  [写入接口]location/mobile/get_location
 *
 *  @see http://open.weibo.com/wiki/2/location/mobile/get_location
 *  @param json   特殊的JSON参数形式，使用方法如下，见注意事项。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) postLocationMobileGetLocation:(NSString *)json var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  根据起点与终点数据查询自驾车路线信息
 *
 *  访问级别：普通接口
 *
 *  [读取接口]location/line/drive_route
 *
 *  @see http://open.weibo.com/wiki/2/location/line/drive_route
 *  @param begin_pid   查询起点POI的ID，与begin_coordinate参数必选其一，begin_pid优先。
 *  @param begin_coordinate   查询起点的坐标，经度纬度用逗号分隔，与begin_pid参数必选其一，begin_pid优先。
 *  @param end_pid   查询终点POI的ID，与end_coordinate参数必选其一，end_pid优先。
 *  @param end_coordinate   查询终点的坐标，经度纬度用逗号分隔，与end_pid参数必选其一，end_pid优先。
 *  @param type   查询类型，0：速度优先、1：费用优先、2：距离优先，默认值为0。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getLocationLineDriveRoute:(NSString *)begin_pid begin_coordinate:(NSString *)begin_coordinate end_pid:(NSString *)end_pid end_coordinate:(NSString *)end_coordinate type:(NSInteger)type var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  根据起点与终点数据查询公交乘坐路线信息
 *
 *  访问级别：普通接口
 *
 *  [读取接口]location/line/bus_route
 *
 *  @see http://open.weibo.com/wiki/2/location/line/bus_route
 *  @param begin_pid   查询起点POI的ID，与begin_coordinate参数必选其一，begin_pid优先。
 *  @param begin_coordinate   查询起点的坐标，经度纬度用逗号分隔，与begin_pid参数必选其一，begin_pid优先。
 *  @param end_pid   查询终点POI的ID，与end_coordinate参数必选其一，end_pid优先。
 *  @param end_coordinate   查询终点的坐标，经度纬度用逗号分隔，与end_pid参数必选其一，end_pid优先。
 *  @param type   查询类型，0：最快捷、1：最经济、2：最少换乘、3：最少步行、4：最舒适，默认值为0。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getLocationLineBusRoute:(NSString *)begin_pid begin_coordinate:(NSString *)begin_coordinate end_pid:(NSString *)end_pid end_coordinate:(NSString *)end_coordinate type:(NSInteger)type var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  根据关键词查询公交线路信息
 *
 *  访问级别：普通接口
 *
 *  [读取接口]location/line/bus_line
 *
 *  可用VariableParams参数：
 *
 *  [page] 返回结果的页码，默认为1，最大为40。
 *
 *  [count] 单页返回的记录条数，默认为10，最大为50。
 *
 *  @see http://open.weibo.com/wiki/2/location/line/bus_line
 *  @param q   查询的关键词，必须进行URLencode。
 *  @param city   城市代码，默认为北京搜索。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getLocationLineBusLine:(NSString *)q city:(NSString *)city var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  根据关键词查询公交站点信息
 *
 *  访问级别：普通接口
 *
 *  [读取接口]location/line/bus_station
 *
 *  可用VariableParams参数：
 *
 *  [page] 返回结果的页码，默认为1，最大为40。
 *
 *  [count] 单页返回的记录条数，默认为10，最大为50。
 *
 *  @see http://open.weibo.com/wiki/2/location/line/bus_station
 *  @param q   查询的关键词，必须进行URLencode。
 *  @param city   城市代码，默认为北京搜索。
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) getLocationLineBusStation:(NSString *)q city:(NSString *)city var:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  地理信息平台接口中使用到的城市代码与城市名的对应列表
 *
 *  访问级别：
 *
 *  [写入接口]Location/citycode
 *
 *  @see http://open.weibo.com/wiki/Location/citycode
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) LocationCitycode:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  公交城市对应表
 *
 *  访问级别：
 *
 *  [写入接口]Location/citycode bus
 *
 *  @see http://open.weibo.com/wiki/Location/citycode_bus
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) LocationCitycodeBus:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;
/**
 *  地理信息平台接口中用到的分类代码对应列表
 *
 *  访问级别：
 *
 *  [写入接口]Location/category
 *
 *  @see http://open.weibo.com/wiki/Location/category
 *  @param var   附加参数，用于过滤内容，可以为详见「AKVariableParams」。
 *  @param pTask 用户任务信息，此Object将会在Callback中一同返回。详见「AKUserTaskInfo」。
 *
 *  @return 执行结果的代码，详见「AKWeiboResultCode」。
 */
-(AKWeiboResultCode) LocationCategory:(AKVariableParams *)var pTask:(AKUserTaskInfo *)pTask;


    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 微博群组（现已更名为新浪微群，独立运营）
-(AKWeiboResultCode) getGroupsJoined:(NSString *)uid   page:(NSInteger)page   count:(NSInteger)count type:(NSInteger)type   filter:(NSInteger)filter   sort:(NSInteger)sort   member_limit:(NSInteger)member_limit   simplify:(NSInteger)simplify  pTask:(AKUserTaskInfo *) pTask;
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


