//
//  TTNavigationBar.m
//  TTUISkeleton
//
//  Created by guanshanliu on 11/20/15.
//  Copyright © 2015 TTPod. All rights reserved.
//

#import "TTNavigationBar.h"
#import "TTUIViewAdditons.h"
#import "TTUtility.h"

@interface TTNavigationBar ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UINavigationItem *navigationItem;
@end

@implementation TTNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    [self setupNavigationBar];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    
    [self setupNavigationBar];
    
    return self;
}

- (void)setupNavigationBar {
    // 透明的Navigation Bar
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.shadowImage = [UIImage new];
    self.translucent = YES;
    
//    // 设置NavigationItem
//    self.navigationItem = [UINavigationItem new];
//    [self pushNavigationItem:self.navigationItem animated:NO];
//    self.backgroundView = ({
////        TTRainbowView *view = [[TTRainbowView alloc] initWithFrame:self.bounds];
//        UIImageView *view =[[UIImageView alloc]initWithFrame:self.bounds];
//        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        [self insertSubview:view atIndex:0];
//        
//        CAGradientLayer *gradient = [CAGradientLayer layer];
//        gradient.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
//        gradient.colors = [NSArray arrayWithObjects:(id)RGBA(0, 0, 0, 0).CGColor,
//                           (id)RGBA(0, 0, 0, 0).CGColor,
//                           (id)RGBA(0, 0, 0, 0).CGColor,nil];
//        [view.layer insertSublayer:gradient atIndex:0];
//        
//        view;
//    });
    
    
    self.backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.backButton];
    self.backButton.frame = CGRectMake(15, 15, 100, 40);
    self.backButton.imageEdgeInsets = UIEdgeInsetsMake( 10, 0, 0, 60);
    [self.backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    
}

- (UIColor *)backgroundColor {
   return self.backgroundView.backgroundColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.backgroundView.backgroundColor = backgroundColor;
}

- (void)setBarTintColor:(UIColor *)barTintColor {
    self.backgroundView.backgroundColor = barTintColor;
}

- (void)setTintColor:(UIColor *)tintColor {
    [super setTintColor:tintColor];
    self.titleLabel.textColor = tintColor;
}

- (UILabel *)titleLabel {
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if( !titleView ){
        titleView =[UILabel new];
        titleView.font = [UIFont systemFontOfSize:15];
        titleView.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleView];
    }
    titleView.textColor =[UIColor whiteColor];
    titleView.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44);
    if ([titleView isKindOfClass:[UILabel class]]) {
        return titleView;
    }
    
    return nil;
}

- (void)setBackgroundAlpha:(CGFloat)backgroundAlpha {
    self.backgroundView.alpha = backgroundAlpha;
}

@end
