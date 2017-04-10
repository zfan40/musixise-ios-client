//
//  MYActionSheetBottomView.h
//  Pods
//
//  Created by wmy on 2017/4/5.
//
//

#import <UIKit/UIKit.h>
#import "MYActionSheetDelegate.h"
@interface MYActionSheetBottomView : UIView <MYActionSheetBottomViewProtocol>

+ (instancetype)actionSheetBottomViewWithTitle:(NSString *)title;

@end
