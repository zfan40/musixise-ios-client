//
//  MYBaseActionSheet.h
//  Pods
//
//  Created by wmy on 2017/3/20.
//
//

#import <UIKit/UIKit.h>
#import "MYActionSheetDelegate.h"

#define kTitleMarginTop 10
#define kBtnMarginTop 10

@class MYActionSheetItemModel;

@interface MYBaseActionSheet : UIView

@property(nonatomic, weak) id<MYActionSheetDelegate> delegate;

- (UIView<MYActionSheetTitleViewProtocol> *)titleView;

- (UIView<MYActionSheetContentViewProtocol> *)contentView;

- (UIView<MYActionSheetBottomViewProtocol> *)bottomView;

+ (MYActionSheetItemModel *)modelWithTitle:(NSString *)title;

@end
