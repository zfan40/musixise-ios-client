//
//  BaseWebviewModel.h
//  xiami
//
//  Created by Li Jianfeng on 14-7-25.
//
//

#import "BaseViewModel.h"

@interface BaseWebviewModel : BaseViewModel
@property (nonatomic, strong, readonly) NSURL *url;
- (instancetype)initWithURL:(NSURL *)URL;
@end
