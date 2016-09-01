//
//  TTMainGridView.m
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTMainGridView.h"
#import "TTUIViewAdditons.h"
#import "TTUtility.h"

@implementation TTMainGridView{
    UIView *_verticalLine1;
    UIView *_verticalLine2;
    UIView *_horizontalLine1;
    UIView *_horizontalLine2;
    UIView *_horizontalLine3;
}
-(id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if( self ){
        _transferButton =[self createMainButton:@"transfer" text:@"转账"];
        _creditPayButton =[self createMainButton:@"creditPay" text:@"信用卡还款"];
        _lifePayButton =[self createMainButton:@"lifePay" text:@"水电煤"];
        _cardPayButton =[self createMainButton:@"cardPay" text:@"点卡充值"];
        _mobilePayButton =[self createMainButton:@"mobilePay" text:@"话费充值"];
        _leftSearchButton =[self createMainButton:@"leftSearch" text:@"余额查询"];
        _verticalLine1 =[self createLineView];
        _verticalLine2 =[self createLineView];
        _horizontalLine1 =[self createLineView];
        _horizontalLine2 =[self createLineView];
        _horizontalLine3 =[self createLineView];
        _horizontalLine1.backgroundColor =RGB(235, 237, 240);
        
    }
    return self;
}

-(UIView*)createLineView{
    UIView *view =[UIView new];
    view.backgroundColor = RGB(223, 225, 228);
    [self addSubview:view];
    return view;
}

-(TTMainButton*)createMainButton:(NSString*)logo text:(NSString*)text{
    TTMainButton *button =[TTMainButton new];
    button.mainImageView.image = [UIImage imageNamed:logo];
    button.label.textColor =[UIColor grayColor];
    button.label.text = text;
    button.label.font =[UIFont systemFontOfSize:12];
    [self addSubview:button];
    return button;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = self.bounds.size;
    CGFloat cellH = 80;
    CGFloat cellW = size.width/3.0;
    _transferButton.frame = CGRectMake(0, 0, cellW, cellH);
    _creditPayButton.frame = CGRectMake(_transferButton.right, 0, cellW, cellH);
    _lifePayButton.frame = CGRectMake(_creditPayButton.right, 0, cellW, cellH);
    
    _cardPayButton.frame = CGRectMake(0, cellH, cellW, cellH);
    _mobilePayButton.frame = CGRectMake(_cardPayButton.right, cellH, cellW, cellH);
    _leftSearchButton.frame = CGRectMake(_mobilePayButton.right, cellH, cellW, cellH);
    
    CGFloat lineW = 0.5;
    _verticalLine1.frame = CGRectMake(cellW, 0, lineW, size.height);
    _verticalLine2.frame = CGRectMake(cellW*2, 0, lineW, size.height);
    _horizontalLine1.frame = CGRectMake(0, 0, size.width, lineW);
    _horizontalLine2.frame = CGRectMake(0, cellH, size.width, lineW);
    _horizontalLine3.frame = CGRectMake(0, cellH*2-lineW, size.width, lineW);
}


@end
