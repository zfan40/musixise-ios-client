//
//  MYItemMoreView.h
//  Pods
//
//  Created by wmy on 16/4/13.
//
//

#import <UIKit/UIKit.h>
@protocol MYItemMoreViewModel;


@protocol MYItemMoreViewDelegate <NSObject>

- (void)itemModreViewDidClickWithIndex:(NSInteger)index;

@end



@interface MYBottomWithIconView : UIView

@property (nonatomic,weak) id<MYItemMoreViewDelegate> delegate;

/**
 *  创建ItemMoreView
 *
 *  @param array  数据
 *  @param title  标题
 *  @param column 列数
 *
 *  @return ItemMoreView
 */
+ (instancetype)bottomViewWithArray:(NSArray <MYItemMoreViewModel>*)array withTitle:(NSString *)title column:(NSInteger)column;

- (void)show;
- (void)dismiss;

/**
 *   更新某个iconfont
 *
 *  @param iconFont iconFont
 *  @param index    index
 */
- (void)updateIcon:(NSString *)iconFont withIndex:(NSInteger)index;

@end
