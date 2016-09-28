//
//  IconFont.h
//  IconFont
//
//  Created by guanshanliu on 9/17/15.
//  Copyright © 2015 guanshanliu. All rights reserved.
//

#import <UIKit/UIKit.h>

// 对应html文件保存在工程根目录 Iconfont Doc 目录下
@interface IconFont : NSObject

+ (UIFont *)fontWithSize:(CGFloat)size  __attribute__((deprecated));

// 格式： 声明 // 对应html文件中的名字

+ (NSString *)addMusic  __attribute__((deprecated)); // add
+ (NSString *)audioEffect  __attribute__((deprecated)); // EQ
+ (NSString *)repeatPlaylist  __attribute__((deprecated)); // cycle
+ (NSString *)repeatSingle  __attribute__((deprecated)); // single
+ (NSString *)normalSongs  __attribute__((deprecated)); // onebyone
+ (NSString *)shuffleSongs  __attribute__((deprecated)); // shuffle
+ (NSString *)sleepTimer  __attribute__((deprecated)); // sleep
+ (NSString *)recognizer  __attribute__((deprecated)); // recognize
+ (NSString *)themes  __attribute__((deprecated)); // theme
+ (NSString *)musicPackage  __attribute__((deprecated)); //音乐包
+ (NSString *)trafficPackage  __attribute__((deprecated)); //traffic
+ (NSString *)settings  __attribute__((deprecated)); // settings
+ (NSString *)wifiOnly  __attribute__((deprecated));
+ (NSString *)notification  __attribute__((deprecated));

+ (NSString *)playInCircle  __attribute__((deprecated));
+ (NSString *)songListEdit  __attribute__((deprecated));

+ (NSString *)about  __attribute__((deprecated)); // sidebar-info
+ (NSString *)recommend  __attribute__((deprecated)); // recommend
+ (NSString *)lightingInCircle  __attribute__((deprecated)); // flow

+ (NSString *)present  __attribute__((deprecated)); // present
+ (NSString *)playingIndexes  __attribute__((deprecated)); // hotwords
+ (NSString *)trashBin  __attribute__((deprecated)); // delete
+ (NSString *)cancelIcon  __attribute__((deprecated));   //实心取消

+ (NSString *)checkMarkUnchecked  __attribute__((deprecated)); // iconfont-yuan
+ (NSString *)checkMarkChecked  __attribute__((deprecated)); // check

+ (NSString *)firstSongs  __attribute__((deprecated)); // new release
+ (NSString *)charts  __attribute__((deprecated)); // rank
+ (NSString *)artists  __attribute__((deprecated)); // singer
+ (NSString *)mv  __attribute__((deprecated)); // mv
+ (NSString *)radio  __attribute__((deprecated)); // radio
+ (NSString *)categories  __attribute__((deprecated)); // class
+ (NSString *)popularSongs  __attribute__((deprecated)); // popular
+ (NSString *)rington  __attribute__((deprecated)); // rington
+ (NSString *)TTFM  __attribute__((deprecated)); // radio2
+ (NSString *)recentlyPlay  __attribute__((deprecated)); // 最近播放
+ (NSString *)musicCircle  __attribute__((deprecated)); // 音乐圈
+ (NSString *)close  __attribute__((deprecated)); // close

//+ (NSString *)global  __attribute__((deprecated)); // diqiu
+ (NSString *)stopSign  __attribute__((deprecated)); // wuziyuan

+ (NSString *)localMusic  __attribute__((deprecated)); // 本地音乐
+ (NSString *)songsDownload  __attribute__((deprecated)); //音乐下载
+ (NSString *)emptyHeart  __attribute__((deprecated)); // 我的最爱
+ (NSString *)save  __attribute__((deprecated)); // 我的下载
+ (NSString *)playlist  __attribute__((deprecated)); // 我的歌单

+ (NSString *)topWithDotOnArrow  __attribute__((deprecated)); // 插歌
+ (NSString *)top  __attribute__((deprecated)); // top

+ (NSString *)mvTag  __attribute__((deprecated)); // MV
+ (NSString *)lossless  __attribute__((deprecated)); // SQ
+ (NSString *)highQuality  __attribute__((deprecated)); // HQ

+ (NSString *)dice  __attribute__((deprecated)); // 碰碰运气
+ (NSString *)circleDwonload  __attribute__((deprecated)); // 下载
+ (NSString *)circleLocal  __attribute__((deprecated)); // 本地音乐
+ (NSString *)circleRecently  __attribute__((deprecated)); // 历史记录

+ (NSString *)next  __attribute__((deprecated)); // 插队播放 copy
+ (NSString *)scanSongs  __attribute__((deprecated)); // 扫描歌曲

+ (NSString *)arrowPointingToTopLeft  __attribute__((deprecated)); // 歌手箭头
+ (NSString *)playFill  __attribute__((deprecated)); // 播放
+ (NSString *)singerBold  __attribute__((deprecated)); // 关联歌手
+ (NSString *)search  __attribute__((deprecated)); // 搜索
+ (NSString *)disclosureRight  __attribute__((deprecated)); // 向右
+ (NSString *)noteLine  __attribute__((deprecated)); // 木歌曲
+ (NSString *)deleteCross  __attribute__((deprecated)); // 删除

+ (NSString *)downArrow  __attribute__((deprecated)); //向下箭头

+ (NSString *)leftArrow  __attribute__((deprecated)); //发送弹幕返回
+ (NSString *)rightArrow  __attribute__((deprecated)); //指向右侧箭头
+ (NSString *)roundCheck  __attribute__((deprecated)); //颜色选择选中
+ (NSString *)roundUncheck  __attribute__((deprecated)); //颜色选择未选中
+ (NSString *)danmakuPostionLow  __attribute__((deprecated)); //弹幕位置
+ (NSString *)danmakuPostionMiddle  __attribute__((deprecated)); //弹幕位置
+ (NSString *)danmakuPostionHight  __attribute__((deprecated)); //弹幕位置
+ (NSString *)danmakuFontSizeSmall  __attribute__((deprecated)); //弹幕字体
+ (NSString *)danmakuFontSizeBig  __attribute__((deprecated));//弹幕字体
+ (NSString *)playIconTriangle  __attribute__((deprecated));//播放三角
+ (NSString *)playIcon  __attribute__((deprecated));   //播放信号
+ (NSString *)playIcon1  __attribute__((deprecated));   //播放动画1
+ (NSString *)playIcon2  __attribute__((deprecated));   //播放动画2
+ (NSString *)playIcon3  __attribute__((deprecated));   //播放动画3
+ (NSString *)pausedIcon  __attribute__((deprecated));
+ (NSString *)extensition  __attribute__((deprecated));   //扩展
+ (NSString *)contractions  __attribute__((deprecated));  //收缩
+ (NSString *)mvForPlay  __attribute__((deprecated)); // 歌曲列表页用前面的MV图标
+ (NSString *)playBackRound  __attribute__((deprecated)); //每日推荐圆形背景的推荐
+ (NSString *)mvPlayCount  __attribute__((deprecated));//MV播放次数
+ (NSString *)mvBulletCount  __attribute__((deprecated));//MV弹幕数量
+ (NSString *)mvDailyRecommendTag  __attribute__((deprecated));//每日推荐MV标签
+ (NSString *)mvTagForThreeWord  __attribute__((deprecated));//每日推荐MV标签三个字
+ (NSString *)mvForSearch  __attribute__((deprecated)); // 搜索关联词MV图标

+ (NSString *)mvLockScreen  __attribute__((deprecated));   //MV锁屏
+ (NSString *)mvUnLockScreen  __attribute__((deprecated)); //MV解锁
+ (NSString *)mvDanmakuSend  __attribute__((deprecated));  //发送弹幕
+ (NSString *)mvDanmakuShow  __attribute__((deprecated));  //显示弹幕
+ (NSString *)mvDanmakuClose  __attribute__((deprecated)); //关闭弹幕
+ (NSString *)mvDownload  __attribute__((deprecated));   //MV下载
+ (NSString *)mvUp  __attribute__((deprecated));    //MV顶
+ (NSString *)mvStep  __attribute__((deprecated));  //MV踩
+ (NSString *)mvUped  __attribute__((deprecated));  //顶过
+ (NSString *)mvSteped  __attribute__((deprecated)); //踩过
+ (NSString *)share  __attribute__((deprecated));  //分享
+ (NSString *)mainScreenBrightness  __attribute__((deprecated));
+ (NSString *)fastForward  __attribute__((deprecated));
+ (NSString *)fastBackward  __attribute__((deprecated));
+ (NSString *)volume  __attribute__((deprecated));

+ (NSString *)favorite  __attribute__((deprecated));
+ (NSString *)unfavorite  __attribute__((deprecated));

+ (NSString *)favoriteSonglist  __attribute__((deprecated));
+ (NSString *)favoriteAlbum  __attribute__((deprecated));
+ (NSString *)favoriteSinger  __attribute__((deprecated));
+ (NSString *)favoriteRank  __attribute__((deprecated));
+ (NSString *)customSonglist  __attribute__((deprecated));
+ (NSString *)userCreatedSongListIcon  __attribute__((deprecated));

+ (NSString *)slidingDrawerMenu  __attribute__((deprecated));

+ (NSString *)listenCount  __attribute__((deprecated));
+ (NSString *)playCount  __attribute__((deprecated));
+ (NSString *)mvDanmakuCount  __attribute__((deprecated));
+ (NSString *)commentCount  __attribute__((deprecated));
+ (NSString *)commentCountWithNumber  __attribute__((deprecated));
+ (NSString *)changeButton  __attribute__((deprecated));

+ (NSString *)recommendExpand  __attribute__((deprecated));

+ (NSString *)addToSonglist  __attribute__((deprecated));

+ (NSString *)deleteStyle1  __attribute__((deprecated));
+ (NSString *)deleteStyle2  __attribute__((deprecated));

+ (NSString *)unSelect  __attribute__((deprecated));
+ (NSString *)didSelect  __attribute__((deprecated));

+ (NSString *)moreStyle1  __attribute__((deprecated));
+ (NSString *)moreStyle2  __attribute__((deprecated));
+ (NSString *)moreStyle3  __attribute__((deprecated));

+ (NSString *)mvTypeSelected  __attribute__((deprecated));

+ (NSString *)editNormal  __attribute__((deprecated));
+ (NSString *)editSelected  __attribute__((deprecated));

+ (NSString *)smallCheckMark  __attribute__((deprecated)); //小√
+ (NSString *)bigCheckMark  __attribute__((deprecated)); //大√
+ (NSString *)selectedBox  __attribute__((deprecated));


+ (NSString *)songLocationiPod  __attribute__((deprecated));
+ (NSString *)songLocationTTPod  __attribute__((deprecated));
+ (NSString *)songLocationDownloading  __attribute__((deprecated));
+ (NSString *)songLocationWaiting  __attribute__((deprecated));
+ (NSString *)songLocationDownloadFail  __attribute__((deprecated));

+ (NSString *)emoticon  __attribute__((deprecated));
+ (NSString *)keyboard  __attribute__((deprecated));

+ (NSString *)importViaWifi  __attribute__((deprecated)); //导入歌曲wifi图标
+ (NSString *)wifiDisable  __attribute__((deprecated)); //wifi 无效

#pragma mark 付费相关
+ (NSString *)puchased  __attribute__((deprecated));
+ (NSString *)NeedBuy  __attribute__((deprecated)); //付费icon
+ (NSString *)needBuyForRightMenu  __attribute__((deprecated));

+ (NSString *)UGCSyn  __attribute__((deprecated));

#pragma mark 个人中心
+ (NSString *)userHeaderImage  __attribute__((deprecated));
+ (NSString *)nicknameFilled  __attribute__((deprecated));
+ (NSString *)sexMan  __attribute__((deprecated));
+ (NSString *)sexWoman  __attribute__((deprecated));
+ (NSString *)sexSecret  __attribute__((deprecated));
+ (NSString *)sexSelected  __attribute__((deprecated));
+ (NSString *)sexUnselected  __attribute__((deprecated));
+ (NSString *)weiboLogin  __attribute__((deprecated));
+ (NSString *)weixinLogin  __attribute__((deprecated));
+ (NSString *)qqLogin  __attribute__((deprecated));
+ (NSString *)genderMan  __attribute__((deprecated));
+ (NSString *)genderWoman  __attribute__((deprecated));

#pragma mark IconFont+SongList
+ (NSString *)listInfo  __attribute__((deprecated));
+ (NSString *)listEdit  __attribute__((deprecated));
+ (NSString *)nextPlay  __attribute__((deprecated)); //插队播放
+ (NSString *)globalIcon  __attribute__((deprecated));
+ (NSString *)exclusive  __attribute__((deprecated)); //独家标识

#pragma mark CurrentPlaylist
+ (NSString *)fromPriorityMediaItemsQueue  __attribute__((deprecated));

#pragma mark PlayerBar
+ (NSString *)bar_currentPlaylist  __attribute__((deprecated));
+ (NSString *)bar_play  __attribute__((deprecated));
+ (NSString *)bar_pause  __attribute__((deprecated));

#pragma mark PlayerSongDetails
+ (NSString *)disclosureIndicatorSmall  __attribute__((deprecated));

#pragma mark DiscoveryHome
+ (NSString *)disc_rankings  __attribute__((deprecated));
+ (NSString *)disc_singers  __attribute__((deprecated));
+ (NSString *)disc_radio  __attribute__((deprecated));
+ (NSString *)disc_mv  __attribute__((deprecated));

+ (NSString *)disc_calendar  __attribute__((deprecated));
+ (NSString *)disc_popular  __attribute__((deprecated));
+ (NSString *)disc_list  __attribute__((deprecated));
+ (NSString *)disc_gift  __attribute__((deprecated));

#pragma mark DiscoverySongCell
+ (NSString *)dsc_play  __attribute__((deprecated));

#pragma mark RecordImageView
+ (NSString *)headset  __attribute__((deprecated));

#pragma mark DiscoveryZone
+ (NSString *)dz_book  __attribute__((deprecated));
+ (NSString *)dz_people  __attribute__((deprecated));

#pragma mark Mine
+ (NSString *)mineIndividualRecommend  __attribute__((deprecated));
+ (NSString *)mineIndividualCircle  __attribute__((deprecated));
+ (NSString *)mineIndividualLive  __attribute__((deprecated));
+ (NSString *)mineIndividualPurchase  __attribute__((deprecated));
+ (NSString *)folderIcon  __attribute__((deprecated));
#pragma mark fans club
+ (NSString *)fansclubArrowUp  __attribute__((deprecated));
+ (NSString *)fansclubAlbum  __attribute__((deprecated));
+ (NSString *)fansclubSongList  __attribute__((deprecated));
+ (NSString *)fansclubClose  __attribute__((deprecated));

/// 相机
+ (NSString *)camera  __attribute__((deprecated));
/// 照片
+ (NSString *)photoAlbum  __attribute__((deprecated));

/// 暂停，外面有圆圈
+ (NSString *)pauseInCircle  __attribute__((deprecated));

#pragma mark Live House
/**
 *  排行榜图标
 *
 *  @return 返回直播间用户排行榜图标
 */
+ (NSString *)liveHouseRankingList  __attribute__((deprecated));

/**
 *  举报图标
 *
 *  @return 返回直播间举报图标
 */
+ (NSString *)liveHouseReport  __attribute__((deprecated));

/**
 *  关闭弹幕图标
 *
 *  @return 返回直播间关闭弹幕图标
 */
+ (NSString *)liveHouseCloseDanMa  __attribute__((deprecated));

/**
 *  发送弹幕图标
 *
 *  @return 返回直播间发送弹幕图标
 */
+ (NSString *)liveHouseSendDanMa  __attribute__((deprecated));

/**
 *  表情图标
 *
 *  @return 返回直播间表情图标
 */
+ (NSString *)liveHouseEmoji  __attribute__((deprecated));

/**
 *  礼物图标
 *
 *  @return 返回直播间礼物图标
 */
+ (NSString *)liveHouseGift  __attribute__((deprecated));

/**
 *  进入全屏图标
 *
 *  @return 返回进入全屏图标
 */
+ (NSString *)enterFullScreen  __attribute__((deprecated));

/**
 *  退出全屏图标
 *
 *  @return 返回退出全屏图标
 */
+ (NSString *)exitFullScreen  __attribute__((deprecated));

/**
 *  用户详情页玩法弹框无数据的图标
 *
 *  @return 敬请期待图标
 */
+ (NSString *)playPopupEmpty  __attribute__((deprecated));

/**
 *  礼物页面默认图片
 *
 *  @return 礼物页面默认图片
 */
+ (NSString *)giftPlaceholder  __attribute__((deprecated));

@end
