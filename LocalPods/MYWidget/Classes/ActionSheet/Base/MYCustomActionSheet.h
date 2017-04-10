//
//  MYCustomActionSheet.h
//  Pods
//
//  Created by wmy on 2017/3/20.
//
//

#import "MYBaseActionSheet.h"



@interface MYCustomActionSheet : MYBaseActionSheet

@property(nonatomic, weak) MYActionSheet *actionSheet;

/**
 创建一个自定义内容View的ActionSheet

 @param title 标题，当标题和副标题均没有传入值时，默认不会有头部的View
 @param subTitle 副标题
 @param customView 内容View
 @param delegate 代理
 @param cancelTitle 底部按钮标题
 @return actionSheet
 */
+ (instancetype)actionSheetWithTitle:(NSString *)title
                            subTitle:(NSString *)subTitle
                          customView:(UIView *)customView
                            delegate:(id<MYActionSheetDelegate>)delegate
                   cancelButtonTitle:(NSString *)cancelTitle;


- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                   customView:(UIView *)customView
                     delegate:(id<MYActionSheetDelegate>)delegate
            cancelButtonTitle:(NSString *)cancelTitle;

+ (void)refreshWidthAndHeight:(MYCustomActionSheet *)actionSheet;

@end
