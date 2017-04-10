//
//  MYActionSheetItemView.h
//  Pods
//
//  Created by wmy on 2017/4/5.
//
//

#import <UIKit/UIKit.h>
#import "MYActionSheetDelegate.h"

@interface MYActionSheetItemView : UIView

@property (nonatomic, strong) id<MYActionSheetItemModelProtocol> itemModel;

- (UILabel *)titleLabel;

- (UIButton *)iconBtn;

+ (NSString *)identifyWithTextAligement:(MYActionSheetItemTextAligement)textAligement;

+ (instancetype)actionSheetWithItemModel:(id<MYActionSheetItemModelProtocol>)itemModel;

@end
