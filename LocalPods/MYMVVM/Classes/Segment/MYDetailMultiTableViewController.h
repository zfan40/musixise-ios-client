//
//  MYDetailMultiTableViewController.h
//  Pods
//
//  Created by wmy on 16/7/26.
//
//  用于精选集、专辑详情等的多个tab页面

#import "MYTableViewController.h"
#import "MYSegmentViewController.h"

@interface MYDetailMultiTableViewController : MYTableViewController
/**
 *  添加子ViewController
 *
 *  @param vierControllers viewcontrollers
 */
- (void)addViewControllers:(NSArray <MYSegmentModel *> *)viewControllers;
/**
 *  点击第(index - 1)个tab回调
 *
 *  @param index index
 */
//- (void)detailMultiTableViewControllerDidClickIndex:(NSInteger)index;
/**
 *  双击第(index - 1)个回调
 *
 *  @param index index
 */
//- (void)detailMultiTableViewControllerDidDoubleClickIndex:(NSInteger)index;
- (CGFloat)headerHeight;
- (UIView *)headerView;
- (NSDictionary *)addKeyValues;

@end
