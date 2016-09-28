//
//  MYBottomViewUtil.h
//  Pods
//
//  Created by wmy on 16/4/13.
//
//

#import <Foundation/Foundation.h>

#import "MYItemMoreViewModel.h"

@interface MYBottomViewUtil : NSObject


/**
 *  底部弹窗 带标题 icon text array
 *
 *  @param title     title
 *  @param iconArray iconArray
 *  @param column    列数
 *
 */
+ (void)buttonViewWithTitle:(NSString *)title iconArray:(NSArray <MYItemMoreViewModel>*)iconArray column:(NSInteger)column;

@end
