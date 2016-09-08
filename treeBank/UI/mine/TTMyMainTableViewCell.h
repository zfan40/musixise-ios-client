//
//  TTMyMainTableViewCell.h
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTMyMainTableViewCell : UITableViewCell
@property (nonatomic, strong) NSString *logoUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UILabel *detailLab;
@property (nonatomic, assign) BOOL showIndicator;
@end
