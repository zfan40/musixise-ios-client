//
//  BaseMergeViewModel.h
//  xiami
//
//  Created by go886 on 14-7-15.
//
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"
@interface BaseMergeViewModel : BaseViewModel
-(instancetype)initWithViewModels:(NSArray*)models;
-(BaseViewModel*)modelForSection:(NSInteger)section;
-(BaseViewModel*)modelForSection:(NSInteger)section outSection:(NSInteger*)outSection;
-(BaseViewModel*)lastStateChangedModel;
-(BaseViewModel*)lastDataChangedModel;
-(void)viewModelStateChanged:(BaseViewModel*)model;
-(void)viewModelDataChanged:(BaseViewModel*)model;
@end
