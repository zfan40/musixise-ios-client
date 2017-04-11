//
//  MYActionSheetItemView.m
//  Pods
//
//  Created by wmy on 2017/4/5.
//
//

#import "MYActionSheetItemView.h"
#import <MYWidget/MYWidget.h>
#import <MYUtils/MYSafeUtil.h>
#import <MYUtils/UIView+MYAdditons.h>
#import <MYImageService/UIImageView+MYCache.h>
#import <MYIconFont/MYButtonFactory.h>
#import "XLeftActionSheetItemView.h"
#import "XCenterActionSheetItemView.h"

@interface MYActionSheetItemView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *iconBtn;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation MYActionSheetItemView

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initBaseView];
    }
    return self;
}

- (void)initBaseView {
    [self addSubview:self.titleLabel];
    [self addSubview:self.iconBtn];
    [self addSubview:self.lineView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initBaseView];
}


+ (instancetype)actionSheetWithItemModel:(id<MYActionSheetItemModelProtocol>)itemModel {
    MYActionSheetItemView *itemView;
    switch (itemModel.textAligement) {
        case MYActionSheetItemTextAligement_Left:
            itemView = [[XLeftActionSheetItemView alloc] init];
            break;
        case MYActionSheetItemTextAligement_Center:
            itemView = [[XCenterActionSheetItemView alloc] init];
            break;
        default:
            return nil;
    }
    itemView.itemModel = itemModel;
    return itemView;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.lineView.bottom = self.height;
    self.lineView.left = 15;
}

#pragma mark - --------------------功能函数------------------

+ (NSString *)identifyWithTextAligement:(MYActionSheetItemTextAligement)textAligement {
    switch (textAligement) {
        case MYActionSheetItemTextAligement_Left:
            return @"MYActionSheetItemTextAligement_Left";
        case MYActionSheetItemTextAligement_Center:
            return @"MYActionSheetItemTextAligement_Center";
        default:
            return @"";
    }
}

- (void)viewModelDataChanged {
    if ([self.itemModel conformsToProtocol:@protocol(MYActionSheetItemModelProtocol)]) {
        [self setText:self.itemModel.text];
        
        if (!isEmptyString(self.itemModel.imageUrl) ||
            !isEmptyString(self.itemModel.iconFontName)) {
            self.iconBtn.width = 32;
            self.iconBtn.height = 32;
        } else {
            self.iconBtn.width = 0;
            self.iconBtn.height = 0;
        }
        
        if (!isEmptyString(self.itemModel.imageUrl)) {
            [self.iconBtn.imageView setImageWithURL:[NSURL URLWithString:self.itemModel.imageUrl]];
        } else {
            [self setIconfontName:self.itemModel.iconFontName withColor:self.itemModel.iconFontColor];
        }
        [self setNeedsLayout];
    }
}

- (void)setText:(NSString *)text {
    self.titleLabel.text = text;
    [self.titleLabel sizeToFit];
}

- (void)setIconfontName:(NSString *)iconfontName withColor:(UIColor *)color {
    // 设置iconfont名称
    if (!isEmptyString(iconfontName)) {
        self.iconBtn.width = 32;
        self.iconBtn.height = 32;
        if (color) {
            [MYButtonFactory setButtonImage:self.iconBtn
                              WithimageName:iconfontName
                                       size:32
                                      color:color];
        } else {
            [MYButtonFactory setButtonImage:self.iconBtn
                              WithimageName:iconfontName
                                       size:32
                                      color:theMYWidget.c0];
        }
    }
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (void)setItemModel:(id<MYActionSheetItemModelProtocol>)itemModel {
    _itemModel = itemModel;
    // 重新布局
    [self viewModelDataChanged];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 1;
        _titleLabel.textColor = theMYWidget.c2;
        _titleLabel.font = theMYWidget.f3;
    }
    return _titleLabel;
}

- (UIButton *)iconBtn {
    if (!_iconBtn) {
        _iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _iconBtn;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        _lineView.backgroundColor = theMYWidget.c3;
    }
    return _lineView;
}

@end
