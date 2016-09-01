//
//  TTMessageListModel.h
//  treeBank
//
//  Created by kebi on 16/4/28.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTBaseModel.h"

#define kTTMessageDataChangedNotification @"kTTMessageDataChangedNotification"

@interface TTMessageItemModel : TTBaseModel
@property (nonatomic, assign)NSInteger objId;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, assign)BOOL isrec;
-(void)parseData:(NSDictionary*)dics;
@end

@interface TTMessageListModel : TTBaseModel
@property (nonatomic, strong) NSMutableArray *datas;
-(void)load;
@end
