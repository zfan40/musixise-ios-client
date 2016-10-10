//
//  MYMaskView.h
//  Pods
//
//  Created by wmy on 16/10/10.
//
//

#import <UIKit/UIKit.h>

@protocol MYMaskViewDelegate <NSObject>

- (void)maskViewDidClick;

@end

@interface MYMaskView : UIView

@property(nonatomic, weak) id<MYMaskViewDelegate> delegate;

+ (instancetype)maskView;

@end
