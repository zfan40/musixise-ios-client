//
//  MYSegmentViewController.h
//  xiaplay
//
//  Created by wmy on 15/12/11.
//  Copyright © 2015年 wmy. All rights reserved.
//  首页的滑动块

#import <UIKit/UIKit.h>
#import "MYTableViewController.h"

@class MYSegmentModel;

typedef NSDictionary *(^AddValueKeyBlock)();

@interface MYSegmentViewController : MYBaseViewController

//-----------------必须设置的参数 begin-------------------

@property (nonatomic,strong) NSArray<MYSegmentModel *> *array;
//-----------------必需设置的参数 end-------------------

@property (nonatomic,copy) AddValueKeyBlock block;

/**
 *  小的标题的高度
 */
@property (nonatomic,assign) CGFloat smallScrollViewHeight;
/**
 *  小标题与内容之间的间隙
 */
@property (nonatomic,assign) CGFloat space;
- (void)scrollToIndex:(NSInteger)index;

@end

@interface MYSegmentModel : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *viewController;
@property (nonatomic,strong) NSString *subTitle;
@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic,weak) MYBaseViewController *vc;

- (void)refresh;
- (void)backToTop;


@end
