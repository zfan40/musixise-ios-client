//
//  BaseDetailModel.h
//  xiami
//
//  Created by daodao on 14-7-15.
//
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"

@interface BaseDetailModel : BaseViewModel
@property(nonatomic,strong) id data;

-(instancetype)initWithObj:(id)data;

@end
