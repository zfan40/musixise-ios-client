//
//  MYNoDataView.m
//  Pods
//
//  Created by wmy on 16/8/28.
//
//

#import "MYNoDataView.h"
#import "MYWidget.h"
#import "UILabel+MYStyle.h"

@implementation MYNodataViewModel
@end

@interface MYNoDataView ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *descLabel;
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,weak) MYNodataViewModel *noDataViewModel;

@end

@implementation MYNoDataView

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
    [self addSubview:self.titleLabel];
    [self addSubview:self.descLabel];
    [self addSubview:self.iconImageView];
    self.backgroundColor = theMYWidget.backgroundColor;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                              action:@selector(onClickSelf)];
    [self addGestureRecognizer:tap];
#if DEBUG
    self.iconImageView.layer.borderWidth = 5;
    self.iconImageView.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 5;
    self.layer.borderColor = [UIColor blueColor].CGColor;
#endif
}

+ (instancetype)noDataView {
    MYNoDataView *noDataView = [[MYNoDataView alloc] init];
    return noDataView;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat top = (self.height - self.iconImageView.height - self.titleLabel.height - self.descLabel.height - theMYWidget.m5 - theMYWidget.m2)/2;
    self.iconImageView.top = top;
    self.iconImageView.width = self.width / 3;
    self.iconImageView.height = self.width / 3;
    self.iconImageView.centerX = self.width * 0.5;
    self.iconImageView.top = 100;
    
    self.titleLabel.top = self.iconImageView.bottom + theMYWidget.m5;
    self.titleLabel.centerX = self.width * 0.5;
    
    self.descLabel.top = self.titleLabel.bottom + theMYWidget.m2;
    self.descLabel.centerX = self.width * 0.5;
}

#pragma mark - --------------------功能函数------------------

- (void)setImage:(UIImage *)image {
    self.iconImageView.image = image;
}
- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
    [self setNeedsLayout];
}

- (void)setDesc:(NSString *)desc {
    self.descLabel.text = desc;
    [self.descLabel sizeToFit];
    [self setNeedsLayout];
}

#pragma mark - --------------------手势事件------------------

- (void)onClickSelf {
    if ([self.delegate respondsToSelector:@selector(noDataViewDidClick)]) {
        [self.delegate noDataViewDidClick];
    }
}

#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (void)setNoDataViewModel:(MYNodataViewModel *)noDataViewModel {
    _noDataViewModel = noDataViewModel;
    self.titleLabel.text = noDataViewModel.title;
    [self.titleLabel sizeToFit];
    self.descLabel.text = noDataViewModel.desc;
    [self.descLabel sizeToFit];
    self.iconImageView.image = noDataViewModel.image;
    [self setNeedsLayout];
}

newInstanceUILabel1(titleLabel, MYWidgetStyle_MYWidget_tt_c2_f3_a50)
newInstanceUILabel1(descLabel, MYWidgetStyle_MYWidget_tt_c2_f3_a50)

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

@end
