//
//  MYBaseActionSheet.m
//  Pods
//
//  Created by wmy on 2017/3/20.
//
//

#import "MYBaseActionSheet.h"
#import "MYActionSheetItemModel.h"

@interface MYBaseActionSheet ()

@property (nonatomic, strong) UIView<MYActionSheetTitleViewProtocol>  *titleView;
@property (nonatomic, strong) UIView<MYActionSheetContentViewProtocol> *contentView;
@property (nonatomic, strong) UIView<MYActionSheetBottomViewProtocol> *bottomView;


@end

@implementation MYBaseActionSheet
#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)init {
    if (self = [super init]) {
        [self initBaseView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initBaseView];
    }
    return self;
}

- (void)initBaseView {
    self.backgroundColor = [UIColor whiteColor];
    self.autoresizesSubviews = NO;
    [self addSubview:self.titleView];
    [self addSubview:self.contentView];
    [self addSubview:self.bottomView];
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - --------------------功能函数------------------

+ (MYActionSheetItemModel *)modelWithTitle:(NSString *)title {
    MYActionSheetItemModel *model = [[MYActionSheetItemModel alloc] init];
    model.textAligement = MYActionSheetItemTextAligement_Center;
    model.text = title;
    return model;
}
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------


@end
