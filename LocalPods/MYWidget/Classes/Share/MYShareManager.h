//
//  MYShareManager.h
//  Pods
//
//  Created by wmy on 16/10/10.
//
//

#import <MYUtils/MYBasicSingleton.h>
#import "MYShareModel.h"

@interface MYShareManager : MYBasicSingleton

- (void)showShareViewWithModels:(NSArray <NSArray<MYShareModel *> *>*)shareModels;

@end
