//
//  MYTipsView.h
//  Pods
//
//  Created by wmy on 16/2/2.
//
//

#import <UIKit/UIKit.h>

@interface MYTipsView : UIView

+ (MYTipsView *)tipsViewWithTitle:(NSString *)text;
- (void)setText:(NSString *)text;
@end
