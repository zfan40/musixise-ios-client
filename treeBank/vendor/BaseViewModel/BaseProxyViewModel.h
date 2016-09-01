//
//  BaseProxyViewModel.h
//  xiami
//
//  Created by go886 on 14-7-12.
//
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"
@interface BaseProxyViewModel : BaseViewModel
@property(nonatomic,strong) BaseViewModel* srcViewModel;

-(instancetype)initWithViewModel:(BaseViewModel*)viewModel;
-(void)viewModelStateChanged;
-(void)viewModelDataChanged;
@end
