//
//  UIBarButtonItem+TTConvenientCreator.h
//  Pods
//
//  Created by guanshanliu on 11/24/15.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (TTConvenientCreator)

+ (instancetype)tt_backBarButtonItemWithTarget:(nullable id)target action:(nullable SEL)action;
+ (instancetype)tt_closeBarButtonItemWithTarget:(id)target action:(SEL)action;
+ (instancetype)tt_searchBarButtonItemWithTarget:(id)target action:(SEL)action;
+ (instancetype)tt_messageBarButtonItemWithTarget:(id)target action:(SEL)action;
+ (instancetype)tt_moreBarButtonItemWithTarget:(id)target action:(SEL)action;
+ (instancetype)tt_playerBarButtonItemWithTarget:(id)target action:(SEL)action;
+ (instancetype)tt_barButtonItemWithTitle:(NSString *)title target:(nullable id)target action:(nullable SEL)action;
+ (instancetype)tt_iconBarButtonItemWithTitle:(NSString *)title target:(nullable id)target action:(nullable SEL)action;

@end

NS_ASSUME_NONNULL_END
