//
//  BaseDetailModel.h
//  xiami
//
//  Created by daodao on 14-7-15.
//
//

#import "BaseViewModel.h"
#import <Foundation/Foundation.h>

@interface BaseDetailModel : BaseViewModel
@property (nonatomic, strong) id data;

- (instancetype)initWithObj:(id)data;

@end
