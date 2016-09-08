//
//  TTMainBottomView.m
//  treeBank
//
//  Created by kebi on 16/3/22.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTMainBottomView.h"
#import "TTUIViewAdditons.h"
#import "TTUtility.h"

@implementation TTMainBottomView {
    UIView *_verticalLine1;
    UIView *_verticalLine2;
    UIView *_verticalLine3;
    UIView *_verticalLine4;
    UIView *_horLine;
    UIView *_selectedLine;
    NSInteger _index;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
        self.backgroundColor = RGB(226, 228, 228);
        _verticalLine1 = [UIView new];
        _verticalLine2 = [UIView new];
        _verticalLine3 = [UIView new];
        _verticalLine4 = [UIView new];
        _verticalLine2.backgroundColor = [UIColor whiteColor];
        _verticalLine1.backgroundColor = RGB(165, 166, 169);
        _verticalLine4.backgroundColor = [UIColor whiteColor];
        _verticalLine3.backgroundColor = RGB(165, 166, 169);
        _selectedLine = [UIView new];
        [self addSubview:_selectedLine];
        _selectedLine.backgroundColor = RGB(72, 145, 232);
        _horLine = [UIView new];
        [self addSubview:_horLine];
        _horLine.backgroundColor = RGB(199, 201, 203);
        [self addSubview:_verticalLine2];
        [self addSubview:_verticalLine1];
        [self addSubview:_verticalLine3];
        [self addSubview:_verticalLine4];
    }
    return self;
}

- (void)updateButton:(TTMainButton *)button selected:(BOOL)selected {
    UIColor *normalColor = RGB(111, 113, 117);
    UIColor *hightlightColor = RGB(72, 145, 232);
    if (button == _mainButton) {
        _mainButton.mainImageView.image =
            selected ? [UIImage imageNamed:@"myMainSelected"] : [UIImage imageNamed:@"myMain"];
        _mainButton.label.textColor = selected ? hightlightColor : normalColor;
        selected = NO;
        _mineButton.mainImageView.image =
            selected ? [UIImage imageNamed:@"myCountSelected"] : [UIImage imageNamed:@"myCount"];
        _mineButton.label.textColor = selected ? hightlightColor : normalColor;

        _businessButton.mainImageView.image =
            selected ? [UIImage imageNamed:@"dealProgressSelected"] : [UIImage imageNamed:@"dealProgress"];
        _businessButton.label.textColor = selected ? hightlightColor : normalColor;
        _index = 0;
    } else if (button == _mineButton) {
        _mineButton.mainImageView.image =
            selected ? [UIImage imageNamed:@"myCountSelected"] : [UIImage imageNamed:@"myCount"];
        _mineButton.label.textColor = selected ? hightlightColor : normalColor;
        selected = NO;
        _mainButton.mainImageView.image =
            selected ? [UIImage imageNamed:@"myMainSelected"] : [UIImage imageNamed:@"myMain"];
        _mainButton.label.textColor = selected ? hightlightColor : normalColor;

        _businessButton.mainImageView.image =
            selected ? [UIImage imageNamed:@"dealProgressSelected"] : [UIImage imageNamed:@"dealProgress"];
        _businessButton.label.textColor = selected ? hightlightColor : normalColor;
        _index = 2;
    } else if (button == _businessButton) {
        _businessButton.mainImageView.image =
            selected ? [UIImage imageNamed:@"dealProgressSelected"] : [UIImage imageNamed:@"dealProgress"];
        _businessButton.label.textColor = selected ? hightlightColor : normalColor;
        selected = NO;
        _mainButton.mainImageView.image =
            selected ? [UIImage imageNamed:@"myMainSelected"] : [UIImage imageNamed:@"myMain"];
        _mainButton.label.textColor = selected ? hightlightColor : normalColor;

        _mineButton.mainImageView.image =
            selected ? [UIImage imageNamed:@"myCountSelected"] : [UIImage imageNamed:@"myCount"];
        _mineButton.label.textColor = selected ? hightlightColor : normalColor;
        _index = 1;
    }
    [self setNeedsLayout];
}

- (void)initSubViews {
    _mainButton = [[TTMainButton alloc] initWithFrame:CGRectZero];
    _mineButton = [[TTMainButton alloc] initWithFrame:CGRectZero];
    _businessButton = [[TTMainButton alloc] initWithFrame:CGRectZero];
    [self addSubview:_businessButton];
    [self addSubview:_mainButton];
    [self addSubview:_mineButton];
    _mainButton.label.text = @"首页";
    _mainButton.label.font = [UIFont systemFontOfSize:10];
    _mainButton.mainImageView.image = [UIImage imageNamed:@"myMain"];

    _mineButton.label.text = @"我的";
    _mineButton.mainImageView.image = [UIImage imageNamed:@"myCount"];
    _mineButton.label.font = [UIFont systemFontOfSize:10];

    _businessButton.label.text = @"MusicList";
    _businessButton.label.font = [UIFont systemFontOfSize:10];
    _businessButton.mainImageView.image = [UIImage imageNamed:@"dealProgress"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.width / 3.0;
    _horLine.frame = CGRectMake(0, 0, self.width, 0.5);
    _mainButton.frame = CGRectMake(0, _horLine.bottom, width, self.height);
    _mineButton.frame = CGRectMake(width * 2, _horLine.bottom, width, self.height);
    _businessButton.frame = CGRectMake(width, _horLine.bottom, width, self.height);
    _verticalLine1.frame = CGRectMake(width, _horLine.bottom, 0.5, self.height);
    _verticalLine2.frame = CGRectMake(_verticalLine1.right, _horLine.bottom, 1, self.height);
    _verticalLine3.frame = CGRectMake(width * 2, _horLine.bottom, 0.5, self.height);
    _verticalLine4.frame = CGRectMake(_verticalLine3.right, _horLine.bottom, 1, self.height);
    if (0 == _index) {
        _selectedLine.frame = CGRectMake(0, 0, _verticalLine1.left, 2);
    } else if (1 == _index) {
        _selectedLine.frame = CGRectMake(_verticalLine2.right, 0, width, 2);
    } else {
        _selectedLine.frame = CGRectMake(_verticalLine4.right, 0, width, 2);
    }
}

@end
