//
//  MYSettingDelegate.h
//  musixise
//
//  Created by wmy on 2017/4/7.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import <MYMVVM/MYBaseTableViewDelegate.h>

@class MYSettingListModel;
@class MYSettingViewModel;

@interface MYSettingDelegate : MYBaseTableViewDelegate

- (MYSettingListModel *)listModel;
- (MYSettingViewModel *)detailModelWithIndexPath:(NSIndexPath *)indexPath;

@end
