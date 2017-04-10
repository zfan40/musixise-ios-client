//
//  XLeftActionSheetItemView.m
//  Pods
//
//  Created by wmy on 2017/4/5.
//
//

#import "XLeftActionSheetItemView.h"
#import <MYUtils/UIView+MYAdditons.h>

#define kLeft 15

@implementation XLeftActionSheetItemView

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconBtn.left = kLeft;
    self.iconBtn.centerY = self.height * 0.5;
    
    if (self.iconBtn.width) {
        self.titleLabel.left = self.iconBtn.right + 12;
    } else {
        self.titleLabel.left = kLeft;
    }
    self.titleLabel.centerY = self.height * 0.5;
}

@end
