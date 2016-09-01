//
//  XBannerScrollView.h
//  xiami
//
//  Created by kebi on 14-11-19.
//
//

#import <UIKit/UIKit.h>

/**
 *XBannerScrollView上添加UIpagecontrol，为uipagecontrol再XBannerScrollView上的位置
 */

typedef NS_ENUM(NSInteger, TTBannerPageIndicatorDirection) {
    TTBannerPageIndicatorDirection_LeftBottom=0,
    TTBannerPageIndicatorDirection_CenterBottom,
    TTBannerPageIndicatorDirection_RightBottom
};


@interface TTBannerItemView : UIView
@property(nonatomic, strong)UIImageView* imageView;
@end

@class TTBannerView;
@protocol TTBannerScrollViewDelegate <NSObject>

/**
 *  XBannerScrollView加载页面的总数
 *
 *  @return 总数
 */
-(NSInteger)numberOfPages;

/**
 *XBannerScrollView上每一个页面的高度
 *
 *  @param scrollView XBannerScrollView
 *  @param indexPath  indexpath
 *
 *  @return 返回的高度
 */
-(CGFloat)bannerScrollView:(TTBannerView*)scrollView heightForPageAtIndexPath:(NSIndexPath*)indexPath;

/**
 *XBannerScrollView上每一个indexpath对应的uiview
 *
 *  @param scrollView XBannerScrollView
 *  @param indexPath  indexpath
 *
 *  @return 返回indexpath对应
 */
-(UIView*)bannerScrollView:(TTBannerView*)scrollView viewForPageAtIndexPath:(NSIndexPath*)indexPath;

/**
 *  是否自动滚动
 *
 *  @return
 */
-(BOOL)autoScorllView;

/**
 *  点击事件
 *
 *  @param scrollView
 *  @param indexPath
 */
-(void)bannerScrollView:(TTBannerView*)scrollView didSeclectAtIndexPath:(NSIndexPath*)indexPath;

-(void)bannerViewDidAppear:(NSIndexPath*)indexPath;
@end

@interface TTBannerView : UIView

@property(nonatomic, weak)id<TTBannerScrollViewDelegate> delegate;
@property(nonatomic, assign) BOOL showPageIndicator; //default YES
@property(nonatomic, assign)TTBannerPageIndicatorDirection pageIndicatorDirection;  //default center
/**
 *  间隔时间
 */
@property (nonatomic,assign) NSTimeInterval time;

-(id)dequeueReusePageViewWithIdentifer:(NSString*)identifer forIndexPath:(NSIndexPath*)indexPath;
-(void)registerClass:(Class)pageClass forPageViewReuseIdentifer:(NSString*)identifer;
-(void)reloadData;
-(void)scrollToNextPage;

@end

