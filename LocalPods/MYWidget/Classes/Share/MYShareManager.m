//
//  MYShareManager.m
//  Pods
//
//  Created by wmy on 16/10/10.
//
//

#import "MYShareManager.h"
#import "MYShareView.h"

@interface MYShareManager ()

@end


@implementation MYShareManager

- (void)showShareViewWithModels:(NSArray <NSArray<MYShareModel *> *>*)shareModels {
    MYShareView *shareView = [MYShareView shareViewWithModels:shareModels];
    [shareView show];
}

@end
