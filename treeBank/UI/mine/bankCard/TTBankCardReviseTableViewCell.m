//
//  TTBankCardReviseTableViewCell.m
//  treeBank
//
//  Created by kebi on 16/5/31.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTBankCardReviseTableViewCell.h"
#import "TTUIViewAdditons.h"
#import "TTUtility.h"

@implementation TTBankCardReviseTableViewCell{
    UIButton *_photoButton;
    UILabel *_tipsLab;
    UIView *_headView;
    UIButton *_postButton;
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _postButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _postButton.backgroundColor = RGB(173, 173, 173);
    [_postButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_postButton setTitle:@"提交" forState:UIControlStateNormal];
    _tipsLab =[UILabel new];
    _tipsLab.textColor =[UIColor whiteColor];
    _tipsLab.textAlignment = NSTextAlignmentLeft;
    _tipsLab.font =[UIFont systemFontOfSize:12];
    _tipsLab.text = @"为了您账户资金安全，需要拍摄银行卡证明验证！";
    
    _photoButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_photoButton setImage:[UIImage imageNamed:@"dealBankcard"] forState:UIControlStateNormal];
    [_photoButton setTitle:@"+点击上面图标拍照" forState:UIControlStateNormal];
    [_photoButton setTitleColor:RGB(88, 164, 237) forState:UIControlStateNormal];
    _photoButton.titleEdgeInsets = UIEdgeInsetsMake(30, 0, 0, 0);
    _photoButton.titleLabel.font =[UIFont systemFontOfSize:11];
    
    _headView =[UIView new];
    _headView.backgroundColor = RGB(139, 196, 227);
    [self addSubview:_headView];
    [self addSubview:_tipsLab];
    [self addSubview:_postButton];
    [self addSubview:_photoButton];
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _headView.frame  = CGRectMake(0, 0, self.width, 30);
    _postButton.frame = CGRectMake(20, self.height-40, self.width-20*2, 40);
    CGSize photoButtonSize = CGSizeMake(108, 125);
    _photoButton.frame = CGRectMake((self.width-photoButtonSize.width)/2.0, (self.height-_headView.height-_postButton.height-photoButtonSize.height)/2+25, photoButtonSize.width, photoButtonSize.height);
    _tipsLab.frame = CGRectMake(30, 0, self.width, _headView.height);
}
@end
