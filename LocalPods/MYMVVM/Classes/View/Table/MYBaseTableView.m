//
//  MYTableView.m
//  xiaplay
//
//  Created by wmy on 15/11/23.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBaseTableView.h"
  

@implementation MYBaseTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.separatorStyle = UITableViewStyleGrouped;
        self.backgroundColor = [UIColor clearColor];
                self.separatorColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.separatorStyle = UITableViewStyleGrouped;
        self.backgroundColor = [UIColor clearColor];
        self.separatorColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        self.separatorStyle = UITableViewStyleGrouped;
        self.backgroundColor = [UIColor clearColor];
            self.separatorColor = [UIColor clearColor];
    }
    return self;
}

@end
