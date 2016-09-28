//
//  MYMoreView.h
//  Pods
//
//  Created by wmy on 16/2/22.
//
//

#import <UIKit/UIKit.h>
@class MYMoreView;

@protocol MYMoreViewDelegate <NSObject>

/**
 *  点击了某个item
 *
 *  @param moreView moreView
 *  @param index    index
 */
- (void)moreView:(MYMoreView *)moreView didClickIndex:(NSInteger)index;

@end

@interface MYMoreView : UIView

/**
 *  设置title
 */
@property (nonatomic,strong) NSArray *titleArray;

@property (nonatomic,weak) id<MYMoreViewDelegate> delegate;

+ (MYMoreView *)moreViewWithTitleArray:(NSArray *)titleArray top:(CGFloat)top;
- (void)moreViewHidden;
- (void)show;

@end
