//
//  TTAuthTableViewCell.h
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTAuthTableViewCell : UITableViewCell
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detailTitle;
@property (nonatomic, assign) BOOL showIndicator;

@property (nonatomic, strong) UITextField *textFiled;
@end
