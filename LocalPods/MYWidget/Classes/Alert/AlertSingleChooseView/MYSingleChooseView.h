//
//  MYSingleChooseView.h
//  Pods
//
//  Created by wmy on 16/6/14.
//
//

#import <UIKit/UIKit.h>

@interface MYSingleChooseView : UIView

@property (nonatomic,assign) BOOL isChoose;
@property (nonatomic,assign) BOOL hiddenLine;
+ (instancetype)singleChooseViewWithTitle:(NSString *)title;

@end
