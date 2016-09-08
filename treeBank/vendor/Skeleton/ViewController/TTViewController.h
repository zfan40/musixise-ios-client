//
//  TTViewController.h
//  Pods
//
//  Created by guanshanliu on 11/20/15.
//
//

#import "TTNavigationBar.h"
#import "TTRouting.h"
#import "TTViewControllerPresentStyle.h"

@protocol TTViewControllerNavigatingStyle <NSObject>

@property (nonatomic, readonly) TTViewControllerPresentStyle presentStyle;

@property (nonatomic, assign) BOOL shouldHideNavigationBar;

@property (nonatomic, assign) NavigationBarLeftButtonStyle navigationBarLeftButtonStyle;
@property (nonatomic, assign) NavigationBarTitleViewStyle navigationBarTitleViewStyle;
@property (nonatomic, assign) NavigationBarRightButtonStyle navigationBarRightButtonStyle;
@property (nonatomic, assign) CGFloat searchBarWidth;  // 搜索栏宽度
@property (nonatomic, assign) BOOL bShowRedPoint;      // 是否显示消息红点
@property (nonatomic, strong) TTNavigationBar *customNavigationBar;
@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;
@property (nonatomic, strong) NSArray<UIBarButtonItem *> *rightBarButtonItems;

//自定义手势返回的手势，目前只支持scrlloview第一页手势返回
//用法如：self.customBackGesture = self.scrollView.panGestureRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer *customBackGesture;

/// 返回相关逻辑
- (UIBarButtonItem *)backItem;
- (BOOL)canDismissWithGesture;
- (IBAction)goBack:(id)sender;
- (void)doSearch:(id)sender;
- (void)showMore:(id)sender;
- (void)showMessage:(id)sender;
- (void)optionSelectedAction:(NSInteger)buttonIndex;
@end

@interface TTViewController : UIViewController <TTRouting, TTViewControllerNavigatingStyle, UISearchBarDelegate>

@property (nonatomic, assign) BOOL shouldHideBackgroundImage;
@property (nonatomic, strong) NSMutableArray *moreOptions;  // 更多点击后的选项，可配置
@property (nonatomic, assign) NSInteger moreButtonIndex;
@property (nonatomic, assign) CGPoint moreActionSheetPoint;  // 更多弹窗的位置

- (void)viewWillFirstAppear;
- (void)viewDidFirstAppear;

@end

extern const CGFloat TTViewControllerNavigationBarHeight;