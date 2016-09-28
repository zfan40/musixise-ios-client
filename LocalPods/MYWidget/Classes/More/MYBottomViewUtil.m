//
//  MYBottomViewUtil.m
//  Pods
//
//  Created by wmy on 16/4/13.
//
// 底部弹窗工具类

#import "MYBottomViewUtil.h"
#import "MYBottomWithIconView.h"


@implementation MYBottomViewUtil

+ (void)buttonViewWithTitle:(NSString *)title iconArray:(NSArray <MYItemMoreViewModel>*)iconArray column:(NSInteger)column {
    MYBottomWithIconView *bottomWithIconView = [MYBottomWithIconView bottomViewWithArray:iconArray withTitle:title column:column];
    [bottomWithIconView show];
}

@end

