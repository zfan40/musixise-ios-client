//
//  TTIntroductionView.m
//  treeBank
//
//  Created by kebi on 16/5/17.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTAppDelegate.h"
#import "TTIntroductionView.h"
#import "TTRunTime.h"
#import "TTUIViewAdditons.h"

@implementation TTIntroductionView {
    UIImageView *_imageView1;
    UIImageView *_imageView2;
    UIImageView *_imageView3;

    UIButton *_button1;
    UIButton *_button2;
    UIButton *_button3;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro1.jpg"]];
    _imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro2.jpg"]];
    _imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro3.jpg"]];

    _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _button3 = [UIButton buttonWithType:UIButtonTypeCustom];

    [_button1 addTarget:self action:@selector(onClick1) forControlEvents:UIControlEventTouchUpInside];
    [_button2 addTarget:self action:@selector(onClick2) forControlEvents:UIControlEventTouchUpInside];
    [_button3 addTarget:self action:@selector(onClick3) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_imageView1];
    [self addSubview:_imageView2];
    [self addSubview:_imageView3];
    [_imageView1 addSubview:_button1];
    [_imageView2 addSubview:_button2];
    [_imageView3 addSubview:_button3];
    _imageView2.hidden = YES;
    _imageView3.hidden = YES;
    _imageView1.userInteractionEnabled = YES;
    _imageView2.userInteractionEnabled = YES;
    _imageView3.userInteractionEnabled = YES;
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView1.frame = self.bounds;
    _imageView2.frame = self.bounds;
    _imageView3.frame = self.bounds;
    _button1.frame = CGRectMake(self.width - 120, self.height - 100, 100, 100);
    _button2.frame = CGRectMake(30, 200, 100, 100);
    _button3.frame = CGRectMake(30, 280, 200, 200);
}

- (void)onClick1 {
    _imageView2.hidden = NO;
    _imageView1.hidden = YES;
    _imageView3.hidden = YES;
}

- (void)onClick2 {
    _imageView1.hidden = YES;
    _imageView2.hidden = YES;
    _imageView3.hidden = NO;
}

- (void)onClick3 {
    [self removeFromSuperview];
    TTAppDelegate *delegate = (TTAppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.otherWindow resignKeyWindow];
    delegate.otherWindow.hidden = YES;
    delegate.otherWindow = nil;
    [delegate.window makeKeyAndVisible];
}

+ (TTIntroductionView *)showIntroductionView {
    NSString *authIdentifer = @"showIntroduction_auth";
    //    NSString *bindIdentifer = @"showIntroduction_bind";
    BOOL showAuthIntroduction = [[[NSUserDefaults standardUserDefaults] objectForKey:authIdentifer] boolValue];
    //    BOOL bindAuthIntroduction =[[[NSUserDefaults standardUserDefaults]objectForKey:bindIdentifer]boolValue];
    if (showAuthIntroduction) {
        return nil;
    }
    [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:authIdentifer];
    [[NSUserDefaults standardUserDefaults] synchronize];

    TTIntroductionView *introductionView = [[TTIntroductionView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    TTAppDelegate *delegate = (TTAppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.otherWindow makeKeyAndVisible];
    [delegate.otherWindow addSubview:introductionView];
    //    if([TTRunTime instance].user.authstatus==TTAuthStatus_N0 ){
    //
    //    }
    return introductionView;
}
@end
