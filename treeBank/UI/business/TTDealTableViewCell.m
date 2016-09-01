//
//  TTDealTableViewCell.m
//  treeBank
//
//  Created by kebi on 16/5/13.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTDealTableViewCell.h"
#import "TTUIViewAdditons.h"
#import "TTUtility.h"

@implementation TTDealTableViewCell{
    UILabel *_dealTypeLab;
    UILabel *_deaMoneyLab;
    UILabel *_dealPayStateLab;
    UILabel *_dealAuditStateLab;

}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _dealTypeLab =  [self createDealLab];
    _deaMoneyLab = [self createDealLab];
    _dealPayStateLab = [self createDealLab];
    _dealAuditStateLab = [self createDealLab];
//    _dealAuditStateLab.textAlignment = NSTextAlignmentRight;
//    _deaMoneyLab.textAlignment  = NSTextAlignmentCenter;
//    _dealPayStateLab.textAlignment = NSTextAlignmentCenter;
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat margin = 0;
    CGFloat itemWidth = (self.width - margin*2)/4.0;
    _dealTypeLab.frame = CGRectMake(margin, 0, itemWidth, self.height);
    _deaMoneyLab.frame = CGRectMake(_dealTypeLab.right, 0, itemWidth, self.height);
    _dealPayStateLab.frame = CGRectMake(_deaMoneyLab.right, 0, itemWidth, self.height);
    _dealAuditStateLab.frame = CGRectMake(_dealPayStateLab.right, 0, itemWidth, self.height);
}


-(void)setModel:(TTDealItemModel *)model{
    if( model.dealType == TTDealType_CollectMoney ){
        _dealTypeLab.text = @"上门收款";
    }else{
        _dealTypeLab.text = @"即时提现";
    }
    
    NSString *money =[NSString stringWithFormat:@"%@ 元",model.money];
    
    NSMutableAttributedString *attribute= [[NSMutableAttributedString alloc ]initWithString:money];
    [attribute setAttributes:@{NSForegroundColorAttributeName:RGB(94, 94, 95)} range:NSMakeRange(money.length-2, 2)];
    [attribute setAttributes:@{NSForegroundColorAttributeName:RGB(193, 46, 54)} range:NSMakeRange(0, money.length-2)];
    _deaMoneyLab.attributedText = attribute;
    
    
    if( model.dealPayState == TTDealPayState_Preparing  ){
        _dealPayStateLab.text = @"待支付";
    }else if (model.dealPayState == TTDealPayState_Paying ){
        _dealPayStateLab.text = @"支付中";
    }else if (model.dealPayState == TTDealPayState_PaySuccess ){
        _dealPayStateLab.text = @"支付成功";
    }else if (model.dealPayState == TTDealPayState_PayFaild ){
        _dealPayStateLab.text = @"支付失败";
    }
    
    if( model.dealAuditState == TTDealAuditState_NoAudit  ){
        _dealAuditStateLab.text = @"未审核";
    }else if (model.dealAuditState == TTDealAuditState_Auditding ){
        _dealAuditStateLab.text = @"审核中";
    }else if (model.dealAuditState == TTDealAuditState_Resign ){
        _dealAuditStateLab.text = @"重新签名";
    }else if (model.dealAuditState == TTDealAuditState_RePhoto ){
        _dealAuditStateLab.text = @"重新拍照";
    }else if (model.dealAuditState == TTDealAuditState_AuditFaild ){
        _dealAuditStateLab.text = @"审核拒绝";
    }
    
    [self setNeedsLayout];
    
}

-(UILabel*)createDealLab{
    UILabel *lab =[UILabel new];
    lab.textColor = RGB(94, 94, 95);
    lab.textAlignment= NSTextAlignmentCenter;
    lab.font =[UIFont systemFontOfSize:10];
    [self addSubview:lab];
    return lab;
}


@end
