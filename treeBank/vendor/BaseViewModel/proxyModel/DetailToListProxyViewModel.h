//
//  DetailToListProxyModel.h
//  xiami
//
//  Created by go886 on 14-7-29.
//
//

#import "BaseProxyViewModel.h"
#import <Foundation/Foundation.h>
@interface DetailToListProxyViewModel : BaseProxyViewModel
@property (nonatomic, copy) NSArray *keys;
@property (nonatomic, copy) NSArray *formats;
@property (nonatomic, copy) NSArray *defaultValues;

- (void)apply;
@end
