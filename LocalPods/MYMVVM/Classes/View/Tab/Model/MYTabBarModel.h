//
//  MYTabBarModel.h
//  Pods
//
//  Created by wmy on 2016/11/29.
//
//

#ifndef MYTabBarModel_h
#define MYTabBarModel_h

@class MYBaseViewController;

@protocol MYTabBarModel <NSObject>

@property(nonatomic, strong) UIColor *normalColor;
@property(nonatomic, strong) UIColor *selectColor;
@property(nonatomic, strong) NSString *iconName;
@property(nonatomic, assign) CGFloat iconWidth;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, assign) CGFloat fontSize;
@property(nonatomic, strong) MYBaseViewController *vc;

@end


#endif /* MYTabBarModel_h */
