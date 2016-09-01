//
//  SectionToItemProxyViewModel.h
//  xiami
//
//  Created by go886 on 14-7-24.
//
//

#import <Foundation/Foundation.h>
#import "BaseProxyViewModel.h"
@interface SectionToItemProxyViewModel : BaseProxyViewModel
-(NSIndexPath*)maptoSource:(NSIndexPath*)index;
-(NSInteger)srcModelItemCount:(NSIndexPath* const)indexPath;

@end
