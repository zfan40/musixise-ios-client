//
//  TTAreaTableViewCell.m
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTAreaTableViewCell.h"
#import "TTUIViewAdditons.h"
#import "TTUtility.h"

@implementation TTAreaTableViewCell{
    UILabel *_titleLab;
    UIImageView *_indicatorImageview;
    UIView *_line1;
    UIView *_line2;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[ super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        _titleLab =[UILabel new];
        _titleLab.textColor = RGBA(0, 0, 0, 0.2);
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font =[UIFont systemFontOfSize:13];
        _indicatorImageview= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"indicator"]];
        [self addSubview:_titleLab];
        [self addSubview:_indicatorImageview];
        _line2 =[UIView new];
        _line1 =[UIView new];
        _line1.backgroundColor = RGBA(0, 0, 0, 0.2);
        _line2.backgroundColor = RGBA(0, 0, 0, 0.2);
        [self addSubview:_line1];
        [self addSubview:_line2];
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    _titleLab.text = title;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _titleLab.frame = CGRectMake(20, 0, self.width, self.height);
    CGSize imageSize = _indicatorImageview.image.size;
    _indicatorImageview.frame = CGRectMake(self.width-20-imageSize.width, (self.height-imageSize.height)/2.0, imageSize.width, imageSize.height);
    CGFloat lineW = 0.5;
    _line2.frame = CGRectMake(0, self.height-lineW, self.width, lineW);
    _line1.frame = CGRectMake(0, 0, self.width, lineW);
}

-(void)setShowIndicator:(BOOL)showIndicator{
    _indicatorImageview.hidden = !showIndicator;
}

- (void)awakeFromNib {
    // Initialization code
}


@end
