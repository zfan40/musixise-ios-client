//
//  MYLoginIconView.m
//  musixise
//
//  Created by wmy on 16/9/28.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYLoginIconView.h"
#import <MYIconFont/MYButtonFactory.h>
#import <MYUtils/UIView+MYAdditons.h>
#import "MYLoginItem.h"

#define kButtonWidth 64
#define kQQTag 100
#define kTaobaoTag 101
#define kWeiboTag 102
#define kWeixinTag 103


@interface MYLoginIconView ()

@property (strong, nonatomic) MYLoginItem *weiboBtn;
@property (strong, nonatomic) MYLoginItem *weixinBtn;
@property (strong, nonatomic) MYLoginItem *taobaoBtn;
@property (strong, nonatomic) MYLoginItem *qqBtn;
@property (strong, nonatomic) NSMutableArray<MYLoginItem *> *itemArray;

@end

@implementation MYLoginIconView


#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.qqBtn];
    [self addSubview:self.taobaoBtn];
    [self addSubview:self.weixinBtn];
    [self addSubview:self.weiboBtn];
    self.userInteractionEnabled = YES;
}

+ (instancetype)loginIconView {
    MYLoginIconView *iconView = [[MYLoginIconView alloc] init];
    return iconView;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat space = (self.width - kButtonWidth * 4) / 3;
    for (int i = 0; i < self.itemArray.count; i++) {
        MYLoginItem *item = [self.itemArray objectAtIndex:i];
        item.left = i * item.width + space * i;
        item.top = 0;
    }
}

#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------

- (void)onClickIcon:(UITapGestureRecognizer *)obj {
    UIView *view = obj.view;
    if ([self.delegate respondsToSelector:@selector(loginIconViewDidClickIconWithTag:)]) {
        [self.delegate loginIconViewDidClickIconWithTag:view.tag];
    }
}

#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (NSMutableArray<MYLoginItem *> *)itemArray {
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

- (MYLoginItem *)qqBtn {
    if (!_qqBtn) {
        _qqBtn = [MYLoginItem loginItemWithButtonName:@"iconFont-dengluqq" withTitle:@"QQ" color:ColorWithHex(0x99CCFFFF)];;
        _qqBtn.tag = kQQTag;
        UITapGestureRecognizer *qqTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(onClickIcon:)];
        [_qqBtn addGestureRecognizer:qqTap];
        [self.itemArray addObject:_qqBtn];
    }
    return _qqBtn;
}

- (MYLoginItem *)taobaoBtn {
    if (!_taobaoBtn) {
        _taobaoBtn = [MYLoginItem loginItemWithButtonName:@"iconFont-denglutaobao" withTitle:@"淘宝" color:ColorWithHex(0xFF9900FF)];
        _taobaoBtn.tag = kTaobaoTag;
        UITapGestureRecognizer *taobaoTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(onClickIcon:)];
        [_taobaoBtn addGestureRecognizer:taobaoTap];
        [self.itemArray addObject:_taobaoBtn];
    }
    return _taobaoBtn;
}

- (MYLoginItem *)weixinBtn {
    if (!_weixinBtn) {
        _weixinBtn = [MYLoginItem loginItemWithButtonName:@"iconFont-dengluweixin" withTitle:@"微信" color:ColorWithHex(0x99CC99FF)];
        _weixinBtn.tag = kWeixinTag;
        UITapGestureRecognizer *weixinTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(onClickIcon:)];
        [_weixinBtn addGestureRecognizer:weixinTap];
        [self.itemArray addObject:_weixinBtn];
    }
    return _weixinBtn;
}

- (MYLoginItem *)weiboBtn {
    if (!_weiboBtn) {
        _weiboBtn = [MYLoginItem loginItemWithButtonName:@"iconFont-dengluweibo" withTitle:@"微博" color:ColorWithHex(0xFF6666FF)];
        _weiboBtn.tag = kWeiboTag;
        UITapGestureRecognizer *weiboTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(onClickIcon:)];
        [_weiboBtn addGestureRecognizer:weiboTap];
        [self.itemArray addObject:_weiboBtn];
    }
    return _weiboBtn;
}


@end
