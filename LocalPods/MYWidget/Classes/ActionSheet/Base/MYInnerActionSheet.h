//
//  MYInnerActionSheet.h
//  Pods
//
//  Created by wmy on 2017/3/16.
//
//

#import "MYCustomActionSheet.h"
#import "MYActionSheetDelegate.h"

@interface MYInnerActionSheet : MYCustomActionSheet



/**
 创建一个元素为button的ActionSheet

 @param title 标题
 @param message 副标题
 @param delegate 代理
 @param itemModelArray customView的数据Model
 @param cancelButtonTitle 底部按钮
 @return actionSheet
 */
+ (instancetype)actionSheetWithTitle:(NSString *)title
                             message:(NSString *)message
                            delegate:(id<MYActionSheetDelegate>)delegate
                      itemModelArray:(NSArray<id<MYActionSheetItemModelProtocol>> *)itemModelArray
                   cancelButtonTitle:(NSString *)cancelButtonTitle;


@end
