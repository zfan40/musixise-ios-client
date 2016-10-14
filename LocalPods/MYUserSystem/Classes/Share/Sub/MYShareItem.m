//
//  MYShareItem.m
//  Pods
//
//  Created by wmy on 16/10/10.
//
//

#import "MYShareItem.h"
#import <MYIconFont/MYButtonFactory.h>
#import "UILabel+MYStyle.h"
#import "MYShareModel.h"
#import "MYWidget.h"

@interface MYShareItem ()

@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) MYShareModel *shareModel;

@end

@implementation MYShareItem

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

- (void)initView {
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLabel];
}

+ (instancetype)shareItemWithShareModel:(MYShareModel *)shareModel {
    MYShareItem *item = [[MYShareItem alloc] init];
    item.shareModel = shareModel;
    return item;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconImageView.width = 50;
    self.iconImageView.height = 50;
    self.iconImageView.centerX = self.width * 0.5;
    self.iconImageView.top = theMYWidget.m3;
    
    self.titleLabel.bottom = self.height - theMYWidget.m3;
    self.titleLabel.centerX = self.width * 0.5;
}

#pragma mark - --------------------功能函数------------------

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
    [self setNeedsLayout];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

newInstanceUIImageView1(iconImageView)

- (void)setShareModel:(MYShareModel *)shareModel {
    if (shareModel) {
        _shareModel = shareModel;
        self.iconImageView.image = shareModel.image;
        [self setTitle:shareModel.name];
    }
}

newInstanceUILabel1(titleLabel, MYWidgetStyle_MYWidget_tt_c2_f2_a80)


@end
