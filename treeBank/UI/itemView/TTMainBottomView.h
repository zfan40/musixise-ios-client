//
//  TTMainBottomView.h
//  treeBank
//
//  Created by kebi on 16/3/22.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTMainHeadView.h"

@interface TTMainBottomView : UIView
@property ( nonatomic, strong ) TTMainButton *mainButton;
@property ( nonatomic, strong ) TTMainButton *mineButton;
@property ( nonatomic, strong ) TTMainButton *businessButton;
-(void)updateButton:(TTMainButton*)button selected:(BOOL)selected;
@end
