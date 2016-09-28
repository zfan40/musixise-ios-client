//
//  MYBaseItemView.h
//  xiaplay
//
//  Created by wmy on 15/11/25.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MYUtils/MYDubugLog.h>
#import <MYWidget/MYWidget.h>
#import <MYWidget/UILabel+MYStyle.h>
#import <MYWidget/UIButton+MYStyle.h>
#import <MYIconFont/MYButtonFactory.h>
#import <MYImageService/UIImageView+MYCache.h>

@class MYBaseViewModel;

@protocol MYBaseViewModelDelegate <NSObject>

@optional
- (void)onEvent:(NSString *)name param:(NSDictionary *)dict;

@end

typedef enum {
    MYBaseItemViewStyleDefault = 1,
    MYBaseItemViewStyleLocal = 2,
    MYBaseItemViewStyleNOTitleBackground = 3,
    
} MYBaseItemViewStyle;

@interface MYBaseItemView : UIView

@property (nonatomic,assign) MYBaseItemViewStyle style;
@property(nonatomic, assign)BOOL autoUpdate;//model 变 刷新界面吗
@property (nonatomic,strong) MYBaseViewModel *viewModel;
@property (nonatomic,weak) id<MYBaseViewModelDelegate> delegate;

/**
 *  cell的高度
 *
 *  @param indexPath indexPath
 *
 *  @return cell的高度
 */
+ (CGFloat)heightForViewModel:(MYBaseViewModel *)baseViewModel;
- (instancetype)initWithItemStyle:(MYBaseItemViewStyle)style viewModel:(MYBaseViewModel *)viewModel;
/**
 *  当viewModel发生变化时，会调用此方法
 */
- (void)viewModelDataChanged;
- (void)viewModelStateChanged;

@end
