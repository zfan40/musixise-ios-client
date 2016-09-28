//
//  MYTableViewCell.m
//  xiaplay
//
//  Created by wmy on 15/11/25.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBaseTableViewCell.h"
#import <MYWidget/MYWidget.h>

@interface MYBaseTableViewCell ()

@end

@implementation MYBaseTableViewCell

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)initWithItemView:(MYBaseItemView *)itemView reuseIdentifier:(NSString *)string {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string]) {
        self.itemView = itemView;
        [self.contentView addSubview:itemView];
        [self initView];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.itemView.center = self.contentView.center;
    self.itemView.left = 0;
    self.itemView.top = 0;
    self.itemView.backgroundColor = theMYWidget.itemViewColor;
    self.backgroundColor = theMYWidget.maskColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setBackgroundView:nil];
    
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize size = self.size;
    if (self.itemView.style == MYBaseItemViewStyleNOTitleBackground) {
        self.itemView.size = CGSizeMake(size.width , self.height);
        self.itemView.top = 0;
        self.itemView.left = 0;
    } else {
        self.itemView.size = CGSizeMake(size.width - theMYWidget.m3 * 2, self.height - theMYWidget.m3);
        self.itemView.top = theMYWidget.m3;
        self.itemView.left = theMYWidget.m3;
    }
}
#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

@end
