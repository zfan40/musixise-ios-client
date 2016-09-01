//
//  ColumnProxyViewModel.h
//  xiami
//
//  Created by go886 on 14-7-12.
//
//

#import <Foundation/Foundation.h>
#import "BaseProxyViewModel.h"
@interface ColumnProxyViewModel : BaseProxyViewModel
@property(nonatomic,assign) NSInteger columnNum;
-(instancetype)initWithViewModel:(BaseViewModel *)viewModel columnNum:(NSInteger)columnNum;
-(instancetype)initWithViewModel:(BaseViewModel *)viewModel;
@end
