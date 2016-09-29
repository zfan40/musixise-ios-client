//
//  MYNavigationView.h
//  Pods
//
//  Created by wmy on 16/9/29.
//
//  用于在添加view时自适应的view.但是，需要注意的是，目前由于开发周期问题，最好先将subView的宽高做好后再加入view中

#import <UIKit/UIKit.h>

@interface MYNavigationView : UIView

+ (instancetype)navigationView;

@end
