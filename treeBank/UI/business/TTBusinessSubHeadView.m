//
//  TTBusinessSubHeadView.m
//  treeBank
//
//  Created by kebi on 16/5/12.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTBusinessSubHeadView.h"
#import "TTUIViewAdditons.h"
#import "TTUtility.h"
#import "NSArray+safe.h"

@implementation TTBusinessSubHeadView{
    UIButton *_allButton;
    UIButton *_allButton1;
    UIButton *_allButton2;
    UIButton *_allButton3;
    UIButton *_allButton4;
    UIButton *_allButton5;
}

-(id)initWithFrame:(CGRect)frame{
    self = [ super initWithFrame:frame];
//    self.backgroundColor = RGB(26, 132, 209);
    self.backgroundColor = RGB(206, 132, 20);
    _allButton =[self createButton];
    _allButton1 =[self createButton];
    _allButton2 =[self createButton];
    _allButton3 =[self createButton];
    _allButton4 =[self createButton];
    _allButton5 =[self createButton];
    return self;
}


-(void)onClick:(UIButton*)button{
    [self updateButtonBackgroudColor:_allButton selected:NO];
    [self updateButtonBackgroudColor:_allButton1 selected:NO];
    [self updateButtonBackgroudColor:_allButton2 selected:NO];
    [self updateButtonBackgroudColor:_allButton3 selected:NO];
    [self updateButtonBackgroudColor:_allButton4 selected:NO];
    [self updateButtonBackgroudColor:_allButton5 selected:NO];
    [self updateButtonBackgroudColor:button selected:YES];
    if( self.eventDelegate ){
        [self.eventDelegate onEvent:kClickDealResultSubSort view:nil parameter:@{@"text":button.titleLabel.text}];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat itemWidth = self.width/6.0;
    _allButton.frame = CGRectMake(0, 0, itemWidth, self.height);
    _allButton1.frame = CGRectMake(_allButton.right, 0, itemWidth, self.height);
    _allButton2.frame = CGRectMake(_allButton1.right, 0, itemWidth, self.height);
    _allButton3.frame = CGRectMake(_allButton2.right, 0, itemWidth, self.height);
    _allButton4.frame = CGRectMake(_allButton3.right, 0, itemWidth, self.height);
    _allButton5.frame = CGRectMake(_allButton4.right, 0, itemWidth, self.height);
}

-(void)updateButtonBackgroudColor:(UIButton*)button selected:(BOOL)selected{
    if(selected){
        button.backgroundColor =RGB(140, 196, 227);
    }else{
//        button.backgroundColor = RGB(26, 132, 209);
        button.backgroundColor = RGB(206, 132, 20);
    }
    button.selected = selected;
}


-(void)setDatas:(NSArray *)datas{
    [_allButton setTitle:[datas objectAtIndexForX:0 ] forState:UIControlStateNormal];
    [_allButton setTitle:[datas objectAtIndexForX:0 ] forState:UIControlStateSelected];
    [self updateButtonBackgroudColor:_allButton selected:YES];
    [self updateButtonBackgroudColor:_allButton1 selected:NO];
    [self updateButtonBackgroudColor:_allButton2 selected:NO];
    [self updateButtonBackgroudColor:_allButton3 selected:NO];
    [self updateButtonBackgroudColor:_allButton4 selected:NO];
    [self updateButtonBackgroudColor:_allButton5 selected:NO];

    [_allButton1 setTitle:[datas objectAtIndexForX:1] forState:UIControlStateNormal];
    [_allButton1 setTitle:[datas objectAtIndexForX:1 ] forState:UIControlStateSelected];
    
    [_allButton2 setTitle:[datas objectAtIndexForX:2 ] forState:UIControlStateNormal];
    [_allButton2 setTitle:[datas objectAtIndexForX:2 ] forState:UIControlStateSelected];
    
    [_allButton3 setTitle:[datas objectAtIndexForX:3 ] forState:UIControlStateNormal];
    [_allButton3 setTitle:[datas objectAtIndexForX:3 ] forState:UIControlStateSelected];
    
    [_allButton4 setTitle:[datas objectAtIndexForX:4 ] forState:UIControlStateNormal];
    [_allButton4 setTitle:[datas objectAtIndexForX:4 ] forState:UIControlStateSelected];
    
    [_allButton5 setTitle:[datas objectAtIndexForX:5 ] forState:UIControlStateNormal];
    [_allButton5 setTitle:[datas objectAtIndexForX:5 ] forState:UIControlStateSelected];
    [self setNeedsLayout];
}


-(UIButton*)createButton{
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:RGB(58, 149, 214) forState:UIControlStateSelected];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:button];
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}


@end
