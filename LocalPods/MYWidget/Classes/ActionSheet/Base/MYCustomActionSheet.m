//
//  MYCustomActionSheet.m
//  Pods
//
//  Created by wmy on 2017/3/20.
//
//

#import "MYCustomActionSheet.h"
#import <MYUtils/UIView+MYAdditons.h>
#import <MYUtils/MYSafeUtil.h>
#import "MYActionSheetTitleView.h"
#import "MYActionSheetBottomView.h"

#define kTitleViewHeight 60
#define kBottomViewHeight 60

@interface MYCustomActionSheet ()

@property (nonatomic, weak) UIView *customView;

@property (nonatomic, strong) MYActionSheetTitleView *innerTitleView;
@property (nonatomic, strong) MYActionSheetBottomView *innerBottomView;

@end

@implementation MYCustomActionSheet

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    
}

- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                   customView:(UIView *)customView
                     delegate:(id<MYActionSheetDelegate>)delegate
            cancelButtonTitle:(NSString *)cancelTitle {
    if (self = [super init]) {
        self.delegate = delegate;
        self.width = kScreenWidth;

        if (!isEmptyString(title) ||
            !isEmptyString(subTitle)) {
            [self.titleView setTitle:title];
            [self.titleView setSubTitle:subTitle];
            // 设置长宽
            self.titleView.width = self.width;
            self.titleView.height = kTitleViewHeight;
        }
        
        self.customView = customView;
        
        if (!isEmptyString(cancelTitle)) {
            // 设置长宽
            self.bottomView.width = self.width;
            self.bottomView.height = kBottomViewHeight;
            [self.bottomView setTitle:cancelTitle];
        }
        [MYCustomActionSheet refreshWidthAndHeight:self];
    }
    return self;
}

+ (instancetype)actionSheetWithTitle:(NSString *)title
                            subTitle:(NSString *)subTitle
                          customView:(UIView *)customView
                            delegate:(id<MYActionSheetDelegate>)delegate
                   cancelButtonTitle:(NSString *)cancelTitle {
    MYCustomActionSheet *actionSheet = [[MYCustomActionSheet alloc] initWithTitle:title
                                                                       subTitle:subTitle
                                                                     customView:customView
                                                                       delegate:delegate
                                                              cancelButtonTitle:cancelTitle];
       return actionSheet;
}
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleView.top = 0;
    self.titleView.left = 0;
    
    self.contentView.top = self.titleView.bottom;
    self.contentView.left = 0;
    
    if (self.contentView.height) {
        self.bottomView.top = self.contentView.bottom;
    } else {
        self.bottomView.top = self.titleView.bottom;
    }
    self.bottomView.left = 0;
    
}
- (UIView *)titleView {
    return self.innerTitleView;
}

- (UIView<MYActionSheetBottomViewProtocol> *)bottomView {
    return self.innerBottomView;
}

- (UIView<MYActionSheetContentViewProtocol> *)contentView {
    return self.customView;
}

#pragma mark - --------------------功能函数------------------

+ (void)refreshWidthAndHeight:(MYCustomActionSheet *)actionSheet {
    // 设置actionSheet宽高
    actionSheet.width = kScreenWidth;
    CGFloat actionSheetHeight = 0;
    actionSheetHeight += actionSheet.titleView.height;
    actionSheetHeight += actionSheet.contentView.height;
    actionSheetHeight += actionSheet.bottomView.height;
    actionSheet.height = actionSheetHeight;
    [actionSheet setNeedsLayout];
}

#pragma mark - --------------------手势事件------------------

- (void)onClickCancel {
    if ([self.delegate respondsToSelector:@selector(actionSheet:DidClickWithIndex:)]) {
        [self.delegate actionSheet:self.actionSheet DidClickWithIndex:-1];
    }
}

#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (void)setCustomView:(UIView *)customView {
    if (_customView) {
        [customView removeFromSuperview];
    }
    _customView = customView;
    [self addSubview:customView];
}

- (MYActionSheetBottomView *)innerBottomView {
    if (!_innerBottomView) {
        _innerBottomView = [[MYActionSheetBottomView alloc] init];
        UITapGestureRecognizer *innerBottomTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                        action:@selector(onClickCancel)];
        [_innerBottomView addGestureRecognizer:innerBottomTap];
    }
    return _innerBottomView;
}

- (MYActionSheetTitleView *)innerTitleView {
    if (!_innerTitleView) {
        _innerTitleView = [[MYActionSheetTitleView alloc] init];
    }
    return _innerTitleView;
}

@end
