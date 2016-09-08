//
//  TTItemView.h
//  treeBank
//
//  Created by kebi on 16/5/13.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TTViewEventProtocal <NSObject>

- (void)onEvent:(NSString *)event view:(UIView *)view parameter:(NSDictionary *)dics;

@end

@interface TTItemView : UIView

@end
