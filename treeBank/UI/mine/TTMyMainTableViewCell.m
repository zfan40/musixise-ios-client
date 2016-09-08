//
//  TTMyMainTableViewCell.m
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTMyMainTableViewCell.h"
#import "TTUIViewAdditons.h"
#import "TTUtility.h"

@implementation TTMyMainTableViewCell {
    UIImageView *_logoImageView;
    UILabel *_titleLab;
    UILabel *_detailLab;
    UIImageView *_indicatorImageview;
    UIView *_line1;
    UIView *_line2;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _logoImageView = [UIImageView new];
        _titleLab = [UILabel new];
        _detailLab = [UILabel new];
        _titleLab.font = [UIFont systemFontOfSize:10];
        _detailLab.font = [UIFont systemFontOfSize:10];

        _indicatorImageview = [UIImageView new];
        [self addSubview:_logoImageView];
        [self addSubview:_titleLab];
        [self addSubview:_detailLab];
        [self addSubview:_indicatorImageview];
        _indicatorImageview.image = [UIImage imageNamed:@"indicator"];
        _titleLab.textColor = RGB(94, 94, 95);
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _detailLab.textAlignment = NSTextAlignmentRight;
        _detailLab.textColor = RGB(167, 167, 167);
        _line2 = [UIView new];
        _line1 = [UIView new];
        _line1.backgroundColor = RGB(197, 197, 197);
        _line2.backgroundColor = RGB(197, 197, 197);
        [self addSubview:_line1];
        [self addSubview:_line2];
    }

    return self;
}

- (void)setLogoUrl:(NSString *)logoUrl {
    _logoImageView.image = [UIImage imageNamed:logoUrl];
}

- (void)setTitle:(NSString *)title {
    _titleLab.text = title;
}

- (void)setShowIndicator:(BOOL)showIndicator {
    _indicatorImageview.hidden = !showIndicator;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize size = self.size;
    CGFloat margin = 20;
    CGSize imageSize = _logoImageView.image.size;
    _logoImageView.frame =
        CGRectMake(margin, (size.height - imageSize.height) / 2.0, imageSize.width, imageSize.height);
    _titleLab.frame = CGRectMake(_logoImageView.right + 10, 0, 200, size.height);

    CGSize indicatorImageSize = _indicatorImageview.image.size;
    _indicatorImageview.frame =
        CGRectMake(size.width - margin - indicatorImageSize.width, (size.height - indicatorImageSize.height) / 2.0,
                   indicatorImageSize.width, indicatorImageSize.height);
    _detailLab.frame = CGRectMake(_indicatorImageview.left - 210, 0, 200, size.height);
    CGFloat lineW = 0.5;
    _line2.frame = CGRectMake(0, self.height - lineW, self.width, lineW);
    _line1.frame = CGRectMake(0, 0, self.width, lineW);
}

@end
