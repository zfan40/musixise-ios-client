//
//  TTMainHeadView.m
//  treeBank
//
//  Created by kebi on 16/3/22.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTMainHeadView.h"
#import "TTUIViewAdditons.h"


@implementation TTMainButton

-(id)initWithCoder:(NSCoder *)aDecoder{
    self =[super initWithCoder:aDecoder];
    if(self){
        [self initViews];
    }
    return self;
}


-(void)initViews{
    self.label =[ UILabel new];
    self.label.backgroundColor =[UIColor clearColor];
    self.mainImageView =[UIImageView new];
    [self addSubview:_label];
    [self addSubview:self.mainImageView];
    _label.font =[UIFont systemFontOfSize:10];

}
-(id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if(self){
        [self initViews];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = self.bounds.size;
    CGSize imageSize = self.mainImageView.image.size;
    CGFloat margin = 10;
    CGSize textSize =[_label.text boundingRectWithSize:CGSizeMake( INT16_MAX, self.height) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_label.font?_label.font:[UIFont systemFontOfSize:12]} context:nil].size;
    self.mainImageView.frame = CGRectMake( (size.width-imageSize.width)/2.0, (self.height-imageSize.height-margin-textSize.height)/2.0, imageSize.width, imageSize.height);
    _label.frame = CGRectMake( (self.width-textSize.width)/2.0, self.mainImageView.bottom+margin, textSize.width, textSize.height);
}

@end

@implementation TTMainHeadView{
    UIImageView *_imageView;
}


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initSubViews];
    }
    return self;
}


-(void)initSubViews{
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _titleLab = [UILabel new];
    _imageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backgroud"]];
    [self addSubview:_imageView];
    
    [self addSubview:_titleLab];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.textColor =[UIColor whiteColor];
    [self addSubview:_leftButton];
    [self addSubview:_rightButton];
    [_rightButton setTitle:@"帮助" forState:UIControlStateNormal];
    [_leftButton setTitle:@"杭州" forState:UIControlStateNormal];
    _rightButton.titleLabel.font =[UIFont systemFontOfSize:12];
    _leftButton.titleLabel.font =[UIFont systemFontOfSize:12];
    
    _collectionMoney =[TTMainButton buttonWithType:UIButtonTypeCustom];
    _getMoney =[TTMainButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_collectionMoney];
    [self addSubview:_getMoney];
    _collectionMoney.mainImageView.image = [UIImage imageNamed:@"colletionMoney"];
    _getMoney.mainImageView.image = [UIImage imageNamed:@"getMoney"];
    _collectionMoney.label.text = @"上门收款";
    _getMoney.label.text = @"即时提现";
    _collectionMoney.label.textColor = [UIColor whiteColor];
    _getMoney.label.textColor = [UIColor whiteColor];
    _collectionMoney.label.font =[UIFont systemFontOfSize:14];
    _getMoney.label.font =[UIFont systemFontOfSize:14];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    CGFloat margin = 15;
    _leftButton.frame = CGRectMake( 10, margin, 50, 50);
    _rightButton.frame = CGRectMake(self.width-55, margin, 50, 50);
    _titleLab.frame = CGRectMake(0, 0, self.width, 80);
    
    CGSize buttonSize = CGSizeMake(75, 70);
    _collectionMoney.frame = CGRectMake(50, self.height-buttonSize.height-20, buttonSize.width, buttonSize.height);
    _getMoney.frame= CGRectMake(self.width-buttonSize.width-50, self.height-buttonSize.height-20, buttonSize.width,buttonSize.height);
    
}


@end
