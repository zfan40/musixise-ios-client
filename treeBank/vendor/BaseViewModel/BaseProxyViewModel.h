//
//  BaseProxyViewModel.h
//  xiami
//
//  Created by go886 on 14-7-12.
//
//

#import "BaseViewModel.h"
#import <Foundation/Foundation.h>
@interface BaseProxyViewModel : BaseViewModel
@property (nonatomic, strong) BaseViewModel *srcViewModel;

- (instancetype)initWithViewModel:(BaseViewModel *)viewModel;
- (void)viewModelStateChanged;
- (void)viewModelDataChanged;
@end
