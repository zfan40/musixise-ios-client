//
//  MYActionSheet.m
//  Pods
//
//  Created by wmy on 2017/3/16.
//
//

#import "MYActionSheet.h"
#import <MYUtils/UIView+MYAdditons.h>
#import <libextobjc/EXTScope.h>
#import "MYMaskView.h"
#import "MYBaseActionSheet.h"
#import "MYActionSheetItemModel.h"
#import "MYCustomActionSheet.h"
#import "MYInnerActionSheet.h"

@interface MYActionSheet () <MYMaskViewDelegate>

@property (nonatomic, strong) MYMaskView *maskView;
@property (nonatomic, strong) MYBaseActionSheet *innerActionSheet;
@property(nonatomic, weak) id<MYActionSheetDelegate> delegate;
@property (nonatomic, strong) UIViewController *cusVC;

@end

@implementation MYActionSheet

#pragma mark - --------------------退出清空------------------

- (void)dealloc {
    _maskView = nil;
    _innerActionSheet = nil;
    _cusVC = nil;
}

#pragma mark - --------------------初始化--------------------

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.width = kScreenWidth;
    self.height = kScreenHeight;
    [self addSubview:self.maskView];
    self.autoresizesSubviews = NO;
}


+ (void)refreshInnerActionSheet:(MYInnerActionSheet *)inner
                    actionSheet:(MYActionSheet *)actionSheet {
  actionSheet.innerActionSheet = inner;
    [actionSheet addSubview:inner];
    [actionSheet addToCurrentWindow];
}



/**
 创建一个ActionSheet
 
 @param title 标题
 @param message 内容
 @param delegate 代理
 @param cancelTitle 取消按钮标题
 @param models 中间部分选项
 @return actionSheet
 */
+ (instancetype)actionSheetWithTitle:(NSString *)title
                             message:(NSString *)message
                            delegate:(id<MYActionSheetDelegate>)delegate
                   cancelButtonTitle:(NSString *)cancelTitle
                     titleModelArray:(NSArray<id<MYActionSheetItemModelProtocol>> *)models {
    
    MYActionSheet *actionSheet = [[MYActionSheet alloc] init];
    actionSheet.delegate = delegate;
    MYInnerActionSheet *inner = [MYInnerActionSheet actionSheetWithTitle:title
                                                               message:message
                                                              delegate:delegate
                                                        itemModelArray:models
                                                     cancelButtonTitle:cancelTitle];
    [self refreshInnerActionSheet:inner actionSheet:actionSheet];
    inner.actionSheet = actionSheet;
    return actionSheet;
}



/**
 创建一个元素为button的ActionSheet
 
 @param title 标题
 @param message 内容
 @param delegate 代理
 @param buttonTitleArray button按钮标题
 @param cancelButtonTitle 取消按钮标题
 @return actionSheet
 */
+ (instancetype)actionSheetWithTitle:(NSString *)title
                             message:(NSString *)message
                            delegate:(id<MYActionSheetDelegate>)delegate
                   cancelButtonTitle:(NSString *)cancelButtonTitle
                    buttonTitleArray:(NSArray *)buttonTitleArray {
    MYActionSheet *actionSheet = [[MYActionSheet alloc] init];
    actionSheet.delegate = delegate;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < buttonTitleArray.count; i++) {
        MYActionSheetItemModel *itemModel = [[MYActionSheetItemModel alloc] init];
        itemModel.text = [buttonTitleArray objectAtIndex:i];
        itemModel.textAligement = MYActionSheetItemTextAligement_Left;
        [array addObject:itemModel];
    }
    MYInnerActionSheet *inner = [MYInnerActionSheet actionSheetWithTitle:title
                                                               message:message
                                                              delegate:delegate
                                                        itemModelArray:array
                                                     cancelButtonTitle:cancelButtonTitle];
    [self refreshInnerActionSheet:inner actionSheet:actionSheet];
    inner.actionSheet = actionSheet;
    return actionSheet;
}


/**
 创建一个内容为自定义的ActionSheet
 
 @param title 标题
 @param customView 自定义View
 @param delegate 代理
 @param cancelTitle 取消按钮标题
 @param destructiveTitle 确定按钮标题
 @return actionSheet
 */
+ (instancetype)actionSheetWithTitle:(NSString *)title
                            subTitle:(NSString *)subTitle
                          customView:(UIView *)customView
                            delegate:(id<MYActionSheetDelegate>)delegate
                   cancelButtonTitle:(NSString *)cancelTitle {
    MYActionSheet *actionSheet = [[MYActionSheet alloc] init];
    actionSheet.delegate = delegate;
    MYCustomActionSheet *inner = [MYCustomActionSheet actionSheetWithTitle:title
                                                                subTitle:subTitle
                                                              customView:customView
                                                                delegate:delegate
                                                       cancelButtonTitle:cancelTitle];
    [self refreshInnerActionSheet:inner actionSheet:actionSheet];
    inner.actionSheet = actionSheet;
    return actionSheet;
}

/**
 创建一个自定义的actionSheet
 
 @param customView 自定义View
 @return actionSheet
 */
+ (instancetype)actionSheetWithView:(UIView *)customView delegate:(id<MYActionSheetDelegate>)delegate {
    MYActionSheet *actionSheet = [[MYActionSheet alloc] init];
    actionSheet.delegate = delegate;
    MYCustomActionSheet *inner = [MYCustomActionSheet actionSheetWithTitle:nil
                                                                subTitle:nil
                                                              customView:customView
                                                                delegate:delegate
                                                       cancelButtonTitle:nil];
    [self refreshInnerActionSheet:inner actionSheet:actionSheet];
    inner.actionSheet = actionSheet;
    return actionSheet;
}

/**
 自定义customView
 
 @param customViewController ViewController
 @param delegate 代理
 @return actionSheet
 */
+ (instancetype)actionSheetWithViewController:(UIViewController *)customViewController
                                     delegate:(id<MYActionSheetDelegate>)delegate {
    MYActionSheet *actionSheet = [[MYActionSheet alloc] init];
    actionSheet.delegate = delegate;
    actionSheet.cusVC = customViewController;
    MYCustomActionSheet *inner = [MYCustomActionSheet actionSheetWithTitle:nil
                                                                subTitle:nil
                                                              customView:customViewController.view
                                                                delegate:delegate
                                                       cancelButtonTitle:nil];
    [self refreshInnerActionSheet:inner actionSheet:actionSheet];
    inner.actionSheet = actionSheet;
    return actionSheet;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
}



#pragma mark - --------------------功能函数------------------

- (void)addToCurrentWindow {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)show {
    // 动画进入
    self.innerActionSheet.top = kScreenHeight;
    if ([self.delegate respondsToSelector:@selector(willPresentActionSheet:)]) {
        [self.delegate willPresentActionSheet:self];
    }
    [UIView animateWithDuration:0.3f animations:^{
        self.maskView.alpha = 1;
        self.innerActionSheet.bottom = kScreenHeight;
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(didPresentActionSheet:)]) {
            [self.delegate didPresentActionSheet:self];
        }
    }];
}

- (void)dismiss {
    // 动画退出
    if ([self.delegate respondsToSelector:@selector(willDismissActionSheet:)]) {
        [self.delegate willDismissActionSheet:self];
    }
    [UIView animateWithDuration:0.3f animations:^{
        self.maskView.alpha = 0;
        self.innerActionSheet.top = kScreenHeight;
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(didDismissActionSheet:)]) {
            [self.delegate didDismissActionSheet:self];
        }
        [self removeFromSuperview];
    }];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------

#pragma mark MYMaskViewDelegate

- (void)maskViewDidClick {
    [self dismiss];
}

#pragma mark - --------------------属性相关------------------

- (MYMaskView *)maskView {
    if (!_maskView) {
        _maskView = [[MYMaskView alloc] init];
        _maskView.alpha = 0;
        _maskView.width = kScreenWidth;
        _maskView.height = kScreenHeight;
        _maskView.backgroundColor = RGBA(0, 0, 0, 0.5);
        _maskView.delegate = self;
    }
    return _maskView;
}

@end
