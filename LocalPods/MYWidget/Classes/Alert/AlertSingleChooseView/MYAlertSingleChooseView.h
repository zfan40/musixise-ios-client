//
//  MYAlertSingleChooseView.h
//  Pods
//
//  Created by wmy on 16/6/14.
//
//

#import <UIKit/UIKit.h>

@protocol MYAlertSingleChooseViewDelegate <NSObject>

- (void)alertSingleChooseViewDidClickClose;

@end

@interface MYAlertSingleChooseView : UIView

@property (nonatomic,weak) id<MYAlertSingleChooseViewDelegate> delegate;


+ (instancetype)AlertSingleChooseViewWithTitle:(NSString *)title
                                   chooseArray:(NSArray<NSString *> *)array
                                 selectedIndex:(NSUInteger)index
                                 completeBlock:(void(^)(NSUInteger buttonIndex,BOOL isSelect))buttonBlock
                                    closeBlock:(void(^)())closeBlock;

@end
