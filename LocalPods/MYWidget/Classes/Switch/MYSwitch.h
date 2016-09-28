//
//  MYSwitch.h
//  Pods
//
//  Created by wmy on 16/6/13.
//
//  

#import <UIKit/UIKit.h>

@protocol MYSwitchProtocol <NSObject>

- (void)switchisOn:(BOOL)isOn;

@end


@interface MYSwitch : UIView

@property (nonatomic,assign) BOOL isOn;

@property (nonatomic,weak) id<MYSwitchProtocol> delegate;

/**
 *  工程的Switch 宽高指定好的
 */
+ (instancetype)newSwitchWithBackgroundColor:(UIColor *)backColor foregroundColor:(UIColor *)foreColor;

@end
