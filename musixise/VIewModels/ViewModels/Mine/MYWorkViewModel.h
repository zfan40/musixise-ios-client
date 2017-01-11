//
//  MYWorkViewModel.h
//  musixise
//
//  Created by wmy on 2016/12/25.
//  Copyright © 2016年 wmy. All rights reserved.
//  作品的viewModel

#import <MYMVVM/MYBaseViewModel.h>

@interface MYWorkViewModel : MYBaseViewModel

@property(nonatomic, strong) NSString *content;
@property(nonatomic, strong) NSString *createdDate;
@property(nonatomic, strong) NSString *status;
@property(nonatomic, strong) NSString *url;
@property(nonatomic, assign) long long userId;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *detail;
@property(nonatomic, strong) NSString *cover;

//- (NSString *)time;

@end
