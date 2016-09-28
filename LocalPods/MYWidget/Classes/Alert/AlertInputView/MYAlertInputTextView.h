//
//  MYAlertInputTextView.h
//  Pods
//
//  Created by wmy on 16/1/29.
//
// alert的输入框

#import <UIKit/UIKit.h>

@protocol MYAlertInputTextViewDelegate <NSObject>

- (void)alertInputTextViewTextDidChange:(NSString *)text;

@end

@interface MYAlertInputTextView : UIView

@property (nonatomic,strong) NSString *text;
@property (nonatomic,weak) id <MYAlertInputTextViewDelegate> delegate;


+ (MYAlertInputTextView *)alertInputTextViewWithplaceholderTitle:(NSString *)title;
+ (MYAlertInputTextView *)alertInputTextView;

/**
 *  设置提示语
 *
 *  @param placeholder 提示语
 */
- (void)setPlaceholderTitle:(NSString *)placeholder;



@end
