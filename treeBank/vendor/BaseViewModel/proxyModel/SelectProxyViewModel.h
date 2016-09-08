//
//  SelectProxyViewModel.h
//  xiami
//
//  Created by go886 on 14-7-15.
//
//

#import "BaseProxyViewModel.h"
#import <Foundation/Foundation.h>

/*
 选择模型
*/
@interface SelectProxyViewModel : BaseProxyViewModel
@property (nonatomic, assign) NSInteger selectedIndex;      //当前选择的index 0...
@property (nonatomic, copy, readonly) NSArray *models;      //原models
@property (nonatomic, assign) BOOL enabledAllModelChanged;  //指定是否开启全部model 变化通知

- (instancetype)initWithViewModels:(NSArray *)models;
@end
