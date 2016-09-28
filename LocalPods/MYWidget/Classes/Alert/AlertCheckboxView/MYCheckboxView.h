//
//  MYCheckboxView.h
//  Pods
//
//  Created by wmy on 16/2/2.
//
//  带checkbox的view

#import <UIKit/UIKit.h>

@protocol MYCheckboxViewDelegate <NSObject>

- (void)checkboxViewDidClick:(BOOL)isSelected;

@end

@interface MYCheckboxView : UIView

@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,weak) id<MYCheckboxViewDelegate> delegate;

/**
 *  创建带checkbox的View
 *
 *  @param message 内容
 *
 *  @return 带checkbox的view
 */
+ (MYCheckboxView *)checkboxViewWith:(NSString *)message;

+ (MYCheckboxView *)checkboxView;

/**
 *  设置消息
 *
 *  @param message 消息
 */
- (void)setMessage:(NSString *)message;

@end
