//
//  MYCollectionViewCell.m
//  Pods
//
//  Created by wmy on 16/6/16.
//
//

#import "MYCollectionViewCell.h"
#import <MYWidget/MYWidget.h>

@implementation MYCollectionViewCell

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithItemView:(MYBaseItemView *)itemView reuseIdentifier:(NSString *)string {
    if (self = [super init]) {
        self.itemView = itemView;
        for (UIView *subView in self.contentView.subviews) {
            [subView removeFromSuperview];
        }
        [self.contentView addSubview:itemView];
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
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setBackgroundView:nil];
}

- (void)setItemView:(MYBaseItemView *)itemView {
    _itemView = itemView;
    for (UIView *subView in self.contentView.subviews) {
        [subView removeFromSuperview];
    }
    [self.contentView addSubview:itemView];
    [self setNeedsLayout];
}
- (instancetype)initWithFrame:(CGRect)rect itemView:(MYBaseItemView *)itemView {
    if (self = [super initWithFrame:rect]) {
        self.itemView = itemView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize size = self.size;
    self.contentView.size = size;
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

@end
