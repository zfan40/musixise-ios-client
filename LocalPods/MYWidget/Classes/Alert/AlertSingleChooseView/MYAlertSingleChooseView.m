//
//  MYAlertSingleChooseView.m
//  Pods
//
//  Created by wmy on 16/6/14.
//
//

#import "MYAlertSingleChooseView.h"
#import <MYUtils/MYDubugLog.h>
#import <MYIconFont/MYButtonFactory.h>
#import "MYSingleChooseView.h"
#import "UILabel+MYStyle.h"

#define kChooseViewTag 100
#define kChooseViewHeight 55

typedef void(^clickBlock)(NSUInteger index,BOOL isSelect);
typedef void(^closeBlock)();
@interface MYAlertSingleChooseView ()


@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) NSMutableArray<MYSingleChooseView *> *chooseArray;
@property (nonatomic,copy) clickBlock block;
@property (nonatomic,copy) closeBlock closeBlock;

@property (nonatomic,strong) NSArray<NSString *> *array;
@property (nonatomic,strong) UIButton *closeButton;
@property (nonatomic,assign) NSUInteger selectIndex;
@end

@implementation MYAlertSingleChooseView

#pragma mark - --------------------退出清空------------------
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


- (void) initView {
    [self addSubview:self.closeButton];
    [self addSubview:self.titleLabel];
}

+ (instancetype)AlertSingleChooseViewWithTitle:(NSString *)title
                                   chooseArray:(NSArray<NSString *> *)array
                                 selectedIndex:(NSUInteger)index
                                 completeBlock:(void(^)(NSUInteger buttonIndex,BOOL isSelect))buttonBlock
                                    closeBlock:(void(^)())closeBlock {
    MYAlertSingleChooseView *chooseView = [[MYAlertSingleChooseView alloc] init];
    chooseView.titleLabel.text = title;
    [chooseView.titleLabel sizeToFit];
    chooseView.selectIndex = index;
    chooseView.array = array;
    chooseView.block = buttonBlock;
    chooseView.closeBlock = closeBlock;
    chooseView.width = kScreenWidth;
    chooseView.height = array.count * kChooseViewHeight + 62;
    return chooseView;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.closeButton.left = theMYWidget.m4;
    self.closeButton.top = theMYWidget.m4;
    
    self.titleLabel.centerX = self.width * 0.5;
    self.titleLabel.top = theMYWidget.m5;
    
    for (int i = 0; i < self.chooseArray.count; i++) {
        MYSingleChooseView *chooseView = [self.chooseArray objectAtIndex:i];
        chooseView.width = self.width;
        chooseView.height = kChooseViewHeight;
        chooseView.top = kChooseViewHeight * i + 62;
    }

}

#pragma mark - --------------------功能函数------------------

#pragma mark - --------------------手势事件------------------

- (void)onClickChooseView:(UIGestureRecognizer *)recognize {
    MYSingleChooseView *chooseView = (MYSingleChooseView *)recognize.view;
    NSUInteger index = chooseView.tag - kChooseViewTag;
    if (self.block) {
        self.block(index,YES);
    }
    if ([self.delegate respondsToSelector:@selector(alertSingleChooseViewDidClickClose)]) {
        [self.delegate alertSingleChooseViewDidClickClose];
    }
    InfoLog(@"onClickChooseView");
}

#pragma mark - --------------------按钮事件------------------

- (void)onClickClose {
    InfoLog(@"点击关闭");
    if ([self.delegate respondsToSelector:@selector(alertSingleChooseViewDidClickClose)]) {
        [self.delegate alertSingleChooseViewDidClickClose];
    }
}

#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [MYButtonFactory buttonWithImageName:@"iconFont-guanbi" size:16 color:theMYWidget.c2_a20];
        _closeButton.width = 24;
        _closeButton.height = 24;
        [_closeButton addTarget:self action:@selector(onClickClose) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (void)setArray:(NSArray<NSString *> *)array {
    if (array.count) {
        _array = array;
        NSUInteger i = 0;
        for (NSString *chooseStr in array) {
            MYSingleChooseView *chooseView = [MYSingleChooseView singleChooseViewWithTitle:chooseStr];
            [self.chooseArray addObject:chooseView];
            chooseView.isChoose = (self.selectIndex == i);
            chooseView.tag = kChooseViewTag + i++;
            UITapGestureRecognizer *chooseTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                       action:@selector(onClickChooseView:)];
            [chooseView addGestureRecognizer:chooseTap];
            [self addSubview:chooseView];
        }
    } else {
        WarnLog(@"array 没有数据");
        NSAssert(array.count == 0, @"array没有数据");
    }
    
}

- (NSMutableArray<MYSingleChooseView *> *)chooseArray {
    if (!_chooseArray) {
        _chooseArray = [NSMutableArray<MYSingleChooseView *> array];
    }
    return _chooseArray;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f4_a100 withTextAligment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}


@end
