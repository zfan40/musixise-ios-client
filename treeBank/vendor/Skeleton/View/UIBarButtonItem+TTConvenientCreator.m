//
//  UIBarButtonItem+TTConvenientCreator.m
//  Pods
//
//  Created by guanshanliu on 11/24/15.
//
//

#import "UIBarButtonItem+TTConvenientCreator.h"

@implementation UIBarButtonItem (TTConvenientCreator)

+ (instancetype)tt_backBarButtonItemWithTarget:(id)target action:(SEL)action {
    return [self tt_iconBarButtonItemWithTitleExLeft:@"iconFont-quanjufanhui" target:target action:action];
}

+ (instancetype)tt_closeBarButtonItemWithTarget:(id)target action:(SEL)action {
    return [self tt_iconBarButtonItemWithTitleExLeft:@"iconFont-dingbuguanbi" target:target action:action];
}

+ (instancetype)tt_searchBarButtonItemWithTarget:(id)target action:(SEL)action {
    return [self tt_iconBarButtonItemWithTitleExLeft:@"iconFont-sousuo" target:target action:action];
}

+ (instancetype)tt_messageBarButtonItemWithTarget:(id)target action:(SEL)action {
    return [self tt_iconBarButtonItemWithTitleExRight:@"iconFont-zhukesixin" target:target action:action];
}

+ (instancetype)tt_moreBarButtonItemWithTarget:(id)target action:(SEL)action {
    return [self tt_iconBarButtonItemWithTitleExRight:@"iconFont-quanjugengduo" target:target action:action];
}

+ (instancetype)tt_playerBarButtonItemWithTarget:(id)target action:(SEL)action {
    return [self tt_iconBarButtonItemWithTitleExRight:@"iconFont-yinlezantingtingzhi" target:target action:action];
}

+ (instancetype)tt_barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIBarButtonItem *barButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    [barButtonItem setTitleTextAttributes:@{
        NSForegroundColorAttributeName: [UIColor whiteColor],
        NSFontAttributeName: [UIFont systemFontOfSize:14]
    }
                                 forState:UIControlStateNormal];
    return barButtonItem;
}

+ (instancetype)tt_iconBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.titleEdgeInsets = UIEdgeInsetsMake(5, 0, 0, 0);
    button.frame = CGRectMake(0, 0, 32, 32);
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (instancetype)tt_iconBarButtonItemWithTitleExLeft:(NSString *)title target:(id)target action:(SEL)action {
    CGFloat buttonSize = 32;
    CGFloat xOffset = 5;
    if ([title isEqualToString:@"iconFont-quanjufanhui"] || [title isEqualToString:@"iconFont-dingbuguanbi"]) {
        buttonSize = 44;
        xOffset = -2.5f;
    }

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, buttonSize, buttonSize);
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, buttonSize, buttonSize)];

    buttonView.bounds = CGRectOffset(buttonView.bounds, xOffset, 0);
    [buttonView addSubview:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonView];
    return barButtonItem;
}

+ (instancetype)tt_iconBarButtonItemWithTitleExRight:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 32, 32);
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    buttonView.bounds = CGRectOffset(buttonView.bounds, 0, 0);
    [buttonView addSubview:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonView];
    return barButtonItem;
}

@end
