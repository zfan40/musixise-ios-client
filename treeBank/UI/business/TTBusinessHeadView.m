//
//  TTBusinessHeadView.m
//  treeBank
//
//  Created by kebi on 16/5/12.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTBusinessHeadView.h"
#import "TTUIViewAdditons.h"
#import "TTUtility.h"

@interface TTBusinessHeadButton : UIButton
@property (nonatomic, assign) BOOL buttonSelected;
@end

@implementation TTBusinessHeadButton {
    UIView *_lineView;
    UIImageView *_imageView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _lineView = [UIView new];
    [self addSubview:_lineView];
    _lineView.backgroundColor = RGB(189, 189, 189);
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:10];
    _imageView = [[UIImageView alloc] init];
    _imageView.image = [UIImage imageNamed:@"business_angle"];
    [self addSubview:_imageView];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _lineView.frame = CGRectMake(self.width - 0.5, 7.5, 0.5, 25);
    CGSize imageSize = _imageView.image.size;
    _imageView.frame = CGRectMake(self.width - 10 - imageSize.width, (self.height - imageSize.height) / 2.0,
                                  imageSize.width, imageSize.height);
}

- (void)setButtonSelected:(BOOL)selected {
    _buttonSelected = selected;
    _lineView.hidden = selected;
    if (selected) {
        //        self.backgroundColor = RGB(26, 132, 209);
        self.backgroundColor = RGB(206, 132, 20);
        [self setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    } else {
        self.backgroundColor = [UIColor whiteColor];
        //        [self setTitleColor:RGB(26, 132, 209) forState:UIControlStateNormal];
        [self setTitleColor:RGB(206, 132, 20) forState:UIControlStateNormal];
    }
}

@end

@implementation TTBusinessHeadView {
    TTBusinessHeadButton *_dealTypeBtn;
    TTBusinessHeadButton *_dealPayBtn;
    TTBusinessHeadButton *_payStateBtn;
    TTBusinessHeadButton *_auditStateBtn;
    UIView *_lineView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _dealTypeBtn = [TTBusinessHeadButton buttonWithType:UIButtonTypeCustom];
    _dealPayBtn = [TTBusinessHeadButton buttonWithType:UIButtonTypeCustom];
    _payStateBtn = [TTBusinessHeadButton buttonWithType:UIButtonTypeCustom];
    _auditStateBtn = [TTBusinessHeadButton buttonWithType:UIButtonTypeCustom];
    [_dealTypeBtn setTitle:@"交易类型" forState:UIControlStateNormal];
    [_dealPayBtn setTitle:@"交易金额" forState:UIControlStateNormal];
    [_payStateBtn setTitle:@"支付状态" forState:UIControlStateNormal];
    [_auditStateBtn setTitle:@"审核状态" forState:UIControlStateNormal];
    _lineView = [UIView new];
    [self addSubview:_lineView];
    _lineView.backgroundColor = RGB(189, 189, 189);

    [self addSubview:_dealTypeBtn];
    [self addSubview:_dealPayBtn];
    [self addSubview:_payStateBtn];
    [self addSubview:_auditStateBtn];
    _dealTypeBtn.buttonSelected = NO;
    _dealPayBtn.buttonSelected = NO;
    _payStateBtn.buttonSelected = NO;
    _auditStateBtn.buttonSelected = NO;

    [_dealTypeBtn addTarget:self action:@selector(onDealType) forControlEvents:UIControlEventTouchUpInside];
    [_dealPayBtn addTarget:self action:@selector(onDealPay) forControlEvents:UIControlEventTouchUpInside];
    [_payStateBtn addTarget:self action:@selector(onPayState) forControlEvents:UIControlEventTouchUpInside];
    [_auditStateBtn addTarget:self action:@selector(onAuditState) forControlEvents:UIControlEventTouchUpInside];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _lineView.frame = CGRectMake(0, 0, self.width, 0.5);
    CGFloat margin = 0.0;
    CGFloat itemWidth = (self.width - margin * 2) / 4.0;
    _dealTypeBtn.frame = CGRectMake(margin, _lineView.bottom, itemWidth, self.height);
    _dealPayBtn.frame = CGRectMake(_dealTypeBtn.right, _lineView.bottom, itemWidth, self.height);
    _payStateBtn.frame = CGRectMake(_dealPayBtn.right, _lineView.bottom, itemWidth, self.height);
    _auditStateBtn.frame = CGRectMake(_payStateBtn.right, _lineView.bottom, itemWidth, self.height);
}

- (void)onDealType {
    _dealTypeBtn.buttonSelected = !_dealTypeBtn.buttonSelected;
    _dealPayBtn.buttonSelected = NO;
    _payStateBtn.buttonSelected = NO;
    _auditStateBtn.buttonSelected = NO;

    if (self.eventDelegate) {
        [self.eventDelegate onEvent:kClickDealResultSort
                               view:nil
                          parameter:@{
                              @"datas": @[@"全部", @"上门收款", @"即时提现"],
                              @"open": @(_dealTypeBtn.buttonSelected)
                          }];
    }
}

- (void)onDealPay {
    _dealPayBtn.buttonSelected = !_dealPayBtn.buttonSelected;
    _dealTypeBtn.buttonSelected = NO;
    _payStateBtn.buttonSelected = NO;
    _auditStateBtn.buttonSelected = NO;

    if (self.eventDelegate) {
        [self.eventDelegate onEvent:kClickDealResultSort
                               view:nil
                          parameter:@{
                              @"open": @(_dealPayBtn.buttonSelected)
                          }];
    }
}

- (void)onPayState {
    _dealTypeBtn.buttonSelected = NO;
    _dealPayBtn.buttonSelected = NO;
    _payStateBtn.buttonSelected = !_payStateBtn.buttonSelected;
    _auditStateBtn.buttonSelected = NO;

    if (self.eventDelegate) {
        [self.eventDelegate onEvent:kClickDealResultSort
                               view:nil
                          parameter:@{
                              @"datas": @[@"全部", @"待支付", @"支付中", @"支付失败", @"支付成功"],
                              @"open": @(_payStateBtn.buttonSelected)
                          }];
    }
}

- (void)onAuditState {
    _dealTypeBtn.buttonSelected = NO;
    _dealPayBtn.buttonSelected = NO;
    _payStateBtn.buttonSelected = NO;
    _auditStateBtn.buttonSelected = !_auditStateBtn.buttonSelected;

    if (self.eventDelegate) {
        [self.eventDelegate
              onEvent:kClickDealResultSort
                 view:nil
            parameter:@{
                @"datas": @[@"全部", @"未审核", @"审核中", @"重新签名", @"重新拍照", @"审核拒绝"],
                @"open": @(_auditStateBtn.buttonSelected)
            }];
    }
}

@end
