//
//  TTAuthTableViewCell.m
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTAuthTableViewCell.h"
#import "TTUIViewAdditons.h"
#import "TTUtility.h"

@implementation TTAuthTableViewCell{
    UILabel *_titelLab;
    UILabel *_detailLab;
    UIImageView *_indicatorImageview;
    UIView *_line1;
    UIView *_line2;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if( self ){
        _titelLab =[UILabel new];
        _titelLab.font =[UIFont systemFontOfSize:13];
        _titelLab.textColor = RGB(94, 94, 94);
        _detailLab = [UILabel new];
        _titelLab.textAlignment = NSTextAlignmentLeft;
        _detailLab.textAlignment = NSTextAlignmentRight;
        _titelLab.font =[UIFont systemFontOfSize:12];
        _titelLab.textColor = RGB(94, 94, 94);
        _indicatorImageview =[UIImageView new];
        _indicatorImageview.image = [UIImage imageNamed:@"indicator"];
        [self addSubview:_titelLab];
        [self addSubview:_detailLab];
        [self addSubview:_indicatorImageview];
        
        _textFiled =[UITextField new];
        [self addSubview:_textFiled];
        _textFiled.font = [UIFont systemFontOfSize:13];
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
    _titelLab.text = title;
    _title =title;
}
-(void)setDetailTitle:(NSString *)detailTitle{
    _detailLab.text = detailTitle;
    _detailTitle = detailTitle;
}


-(void)setShowIndicator:(BOOL)showIndicator{
    _showIndicator = showIndicator;
    _indicatorImageview.hidden = !showIndicator;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat margin = 25;
    CGFloat titleW  =[_titelLab.text boundingRectWithSize:CGSizeMake( INT16_MAX, self.height) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_titelLab.font} context:nil].size.width;
    _titelLab.frame = CGRectMake(margin, 0, titleW, self.height);
    
    _textFiled.frame = CGRectMake(_titelLab.right+10, 0, self.width-_titelLab.right-margin, self.height);

    CGSize indicatorImageSize = _indicatorImageview.image.size;
    _indicatorImageview.frame = CGRectMake(self.width-indicatorImageSize.width-20, (self.height - indicatorImageSize.height)/2.0, indicatorImageSize.width, indicatorImageSize.height);
    _detailLab.frame = CGRectMake( _indicatorImageview.left-220, 0, 200, self.height);
    
    _line1.frame = CGRectMake(0, 0, self.width, 0.5);
    _line2.frame = CGRectMake(0, self.height-0.5, self.width, 0.5);
    
}

@end
