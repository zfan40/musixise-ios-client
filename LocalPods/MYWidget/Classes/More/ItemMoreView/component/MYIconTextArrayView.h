//
//  MYIconTextArrayView.h
//  Pods
//
//  Created by wmy on 16/4/13.
//
//

#import <UIKit/UIKit.h>

#import "MYItemMoreViewModel.h"

@interface MYIconTextArrayView : UIView


+ (instancetype)iconTextArrayViewWithArray:(NSArray <MYItemMoreViewModel>*)array column:(NSInteger)column;
/**
 *   更新某个iconfont
 *
 *  @param iconFont iconFont
 *  @param index    index
 */
- (void)updateIcon:(NSString *)iconFont withIndex:(NSInteger)index;

@end
