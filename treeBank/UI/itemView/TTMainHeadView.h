//
//  TTMainHeadView.h
//  treeBank
//
//  Created by kebi on 16/3/22.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTMainButton : UIButton
@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UILabel *label;
@end

@interface TTMainHeadView : UIView
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) TTMainButton *collectionMoney;
@property (nonatomic, strong) TTMainButton *getMoney;
@property (nonatomic, strong) UILabel *titleLab;

@end
