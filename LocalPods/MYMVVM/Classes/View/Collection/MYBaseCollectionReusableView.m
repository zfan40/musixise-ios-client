//
//  MYBaseCollectionReusableView.m
//  Pods
//
//  Created by wmy on 16/9/7.
//
//

#import "MYBaseCollectionReusableView.h"
#import "MYBaseItemView.h"

@implementation MYBaseCollectionReusableView

- (void)refresh {
    [self.itemView viewModelDataChanged];
}

@end
