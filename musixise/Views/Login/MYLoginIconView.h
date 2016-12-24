//
//  MYLoginIconView.h
//  musixise
//
//  Created by wmy on 16/9/28.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kQQTag 100
#define kTaobaoTag 101
#define kWeiboTag 102
#define kWeixinTag 103
#define kNormalTag 104


@protocol MYLoginIconViewDelegate <NSObject>

- (void)loginIconViewDidClickIconWithTag:(NSInteger)tag;

@end

@interface MYLoginIconView : UIView

@property (weak, nonatomic) id<MYLoginIconViewDelegate> delegate;

+ (instancetype)loginIconView;

@end
