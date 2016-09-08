//
//  BaseMergeViewModel.h
//  xiami
//
//  Created by go886 on 14-7-15.
//
//

#import "BaseViewModel.h"
#import <Foundation/Foundation.h>
@interface BaseMergeViewModel : BaseViewModel
- (instancetype)initWithViewModels:(NSArray *)models;
- (BaseViewModel *)modelForSection:(NSInteger)section;
- (BaseViewModel *)modelForSection:(NSInteger)section outSection:(NSInteger *)outSection;
- (BaseViewModel *)lastStateChangedModel;
- (BaseViewModel *)lastDataChangedModel;
- (void)viewModelStateChanged:(BaseViewModel *)model;
- (void)viewModelDataChanged:(BaseViewModel *)model;
@end
