//
//  MYBaseViewController.h
//  xiaplay
//
//  Created by wmy on 15/11/23.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYBaseListModel.h"
#import "MYRouter.h"
#import "MYNoDataViewManager.h"
#import <MYUtils/MYDubugLog.h>
#import <MYImageService/UIImageView+MYCache.h>
#import <MYUtils/UIView+MYAdditons.h>
#import <MYWidget/UILabel+MYStyle.h>
#import <MYWidget/UIButton+MYStyle.h>
#import <MYWidget/UITextView+MYStyle.h>
#import <MYWidget/UITextField+MYStyle.h>
#import <MYIconFont/MYButtonFactory.h>

typedef enum {
    MYBaseViewControllerTypePush = 1,
    MYBaseViewControllerTypeModal = 2,
} MYBaseViewControllerType;

typedef enum {
    MYBaseViewControllerModeDefault = 0,
    MYBaseViewControllerModeOnlyOne = 1,
} MYBaseViewControllerMode;

@interface MYBaseViewController : UIViewController

@property (nonatomic,strong) MYBaseViewModel *viewModel;
@property (nonatomic,assign) BOOL isBarAlpha;
/**
 *  当viewModel发生变化时调用此方法
 */
- (void)viewModelDataChanged;
/**
 *  当ViewModel的状态发生变化时
 */
- (void)viewModeStateChanged;
- (MYBaseViewControllerType)inComeType;
- (MYBaseViewControllerMode)mode;
- (BOOL)rightItemHidden;
- (BOOL)leftItemHidden;
- (BOOL)playBarHidden;

- (NSArray *)moreTitleArray;
- (void)clickMoreWithIndex:(NSInteger)index;

/**
 *  用于外部调用viewcontroller更新使用
 */
- (void)update;

- (MYNoDataType)noDataType;
- (MYNoDataEmptyType)noDataEmptyType;

- (void)showTip:(NSString *)string;
- (void)showNoData;

@property (nonatomic,assign) NSInteger index;


@end
