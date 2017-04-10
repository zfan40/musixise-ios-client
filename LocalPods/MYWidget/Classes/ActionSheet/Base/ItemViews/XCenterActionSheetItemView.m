//
//  XCenterActionSheetItemView.m
//  Pods
//
//  Created by wmy on 2017/4/5.
//
//

#import "XCenterActionSheetItemView.h"
#import <MYUtils/UIView+MYAdditons.h>

@implementation XCenterActionSheetItemView

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.iconBtn.width) {
        CGFloat left;
        left = (self.width - (self.iconBtn.width + self.titleLabel.width + 12))/2;
        self.iconBtn.left = left;
        self.titleLabel.left = self.iconBtn.right + 12;
    } else {
        self.titleLabel.centerX = self.width * 0.5;
    }
    self.iconBtn.centerY = self.height * 0.5;
    self.titleLabel.centerY = self.height * 0.5;
}

@end
