//
//  MYWorkItemView.m
//  musixise
//
//  Created by wmy on 2016/12/25.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYWorkItemView.h"
#import "MYWorkViewModel.h"

#define kImageWidth 40
#define kLeftSpace theMYWidget.m3
#define kInnerSpace theMYWidget.m2

@interface MYWorkItemView ()

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *detailLabel;
@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *timeLabel;

@end

@implementation MYWorkItemView



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
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.iconImageView];
    
    self.iconImageView.width = kImageWidth;
    self.iconImageView.height = kImageWidth;
    
    [self addSubview:self.timeLabel];
    
#if DEBUG
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.iconImageView.layer.borderWidth = 1;
    self.iconImageView.layer.borderColor = [UIColor redColor].CGColor;
#endif
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

+ (CGFloat)heightForViewModel:(MYBaseViewModel *)baseViewModel {
    //TODO: wmy UI
    return 60;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconImageView.left = kLeftSpace;
    self.iconImageView.centerY = self.height * 0.5;
    self.titleLabel.left = self.iconImageView.right + theMYWidget.m2;
    
    self.detailLabel.left = self.titleLabel.left;
    CGFloat space = (self.height - (self.titleLabel.height + self.detailLabel.height + kInnerSpace))/2;
    self.titleLabel.top = space;
    self.titleLabel.left = self.iconImageView.right + theMYWidget.m2;
    self.detailLabel.top = self.titleLabel.bottom + kInnerSpace;
    self.detailLabel.left = self.titleLabel.left;
    self.timeLabel.right = self.width - theMYWidget.m2;
    self.timeLabel.bottom = self.height - theMYWidget.m2;
    
}

- (void)viewModelDataChanged {
    if ([self.viewModel isKindOfClass:[MYWorkViewModel class]]) {
        MYWorkViewModel *viewModel = (MYWorkViewModel *)self.viewModel;
        [self setTitle:viewModel.title];
        [self setDetail:viewModel.detail];
        //TODO: wmy UI
//        NSString *imageUrl = @"http://4493bz.1985t.com/uploads/allimg/150127/4-15012G52133.jpg";
        NSString *imageUrl = viewModel.cover;
        [self.iconImageView my_setImageWithURL:imageUrl];
        [self setTime:[viewModel createdDate]];
    }
}

#pragma mark - --------------------功能函数------------------

- (void)setTime:(NSString *)time {
    if (isEmptyString(time)) {
        //TODO: wmy
        time = @"12月25日 99";
    }
    self.timeLabel.text = time;
    [self.timeLabel sizeToFit];
}

- (void)setTitle:(NSString *)title {
    if (isEmptyString(title)) {
        //TODO: wmy
        title = @"标题";
    }
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
}

- (void)setDetail:(NSString *)detail {
    if (isEmptyString(detail)) {
        //TODO: wmy
        detail = @"副标题";
    }
    self.detailLabel.text = detail;
    [self.detailLabel sizeToFit];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

newInstanceUILabel1(titleLabel, MYWidgetStyle_MYWidget_tt_c2_f3_a80)
newInstanceUILabel1(detailLabel, MYWidgetStyle_MYWidget_tt_c2_f2_a50)
newInstanceUILabel1(timeLabel, MYWidgetStyle_MYWidget_tt_c2_f1_a20)
newInstanceUIImageView1(iconImageView)

@end
