//
//  TTToast.m
//  TTPod
//
//  Created by lihui on 2/1/13.
//
//

#import "MBProgressHUD.h"
#import "TTToast.h"
#import "UIView+DeviceOrientationChanged.h"
#import <QuartzCore/QuartzCore.h>

#define ToastFont 17.0f
#define ToastRadius 8.0f
#define ToastAlpha 0.7f;

@interface TTToast () {
    UIButton *contentView;
    UILabel *lbl;
    CGFloat duration;
    MBProgressHUD *m_waitAnim;
    UIViewAutoresizing m_autoresizingMask;

    CGFloat m_topMargin;
    CGFloat m_bottomMargin;
}

@end

@implementation TTToast

- (void)dealloc {
    contentView = nil;
}

- (void)showWaitAnim:(NSString *)text {
    if (m_waitAnim) {
        m_waitAnim.labelText = text;
        return;
    }

    m_waitAnim = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:m_waitAnim];
    m_waitAnim.labelText = text;
    [m_waitAnim show:YES];

    m_waitAnim.alpha = 0;
    m_waitAnim.hidden = NO;
    [UIView animateWithDuration:0.3
                     animations:^{
                         m_waitAnim.alpha = 1;
                     }];
}

- (void)hideWaitAnim {
    if (!m_waitAnim) {
        return;
    }
    m_waitAnim.hidden = YES;
    m_waitAnim = nil;
}

+ (TTToast *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        CGSize textSize = CGSizeMake(150, 80);
        contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textSize.width, textSize.height)];
        contentView.layer.cornerRadius = ToastRadius;
        contentView.layer.masksToBounds = YES;
        contentView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        [contentView addTarget:self action:@selector(hideAnimation) forControlEvents:UIControlEventTouchUpInside];
        contentView.alpha = 0;

        lbl = [[UILabel alloc] initWithFrame:contentView.frame];
        lbl.numberOfLines = 0;
        lbl.backgroundColor = [UIColor clearColor];
        lbl.textColor = [UIColor whiteColor];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.font = [UIFont boldSystemFontOfSize:ToastFont];
        [contentView addSubview:lbl];

        duration = DEFAULT_DISPLAY_DURATION;
        self.orientationSensitive = YES;
        self.isZoomMax = YES;
        self.toastFontSize = ToastFont;
        self.toastRadius = ToastRadius;
        self.toastAlpha = ToastAlpha;
    }
    return self;
}

- (void)setText:(NSString *)text {
    UIFont *font = nil;
    if (ToastFont > self.toastFontSize) {
        font = [UIFont systemFontOfSize:self.toastFontSize];
    } else {
        font = [UIFont boldSystemFontOfSize:ToastFont];
    }
    lbl.font = font;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle.copy};
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(180, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attributes
                                         context:nil]
                          .size;
    contentView.frame = CGRectMake(0, 0, textSize.width, textSize.height);
    contentView.layer.cornerRadius = self.toastRadius;
    contentView.layer.masksToBounds = YES;
    contentView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:self.toastAlpha];
    lbl.frame = contentView.frame;
    lbl.text = text;
}

- (void)setDuration:(CGFloat)duration_ {
    if (duration_ <= 0.0f) {
        duration_ = NSIntegerMax;
    }
    duration = duration_;
}

- (void)showAnimation {
    if (contentView.alpha > 0.7) {
        contentView.alpha = 0.7f;
    }
    [UIView animateWithDuration:0.3
                     animations:^{
                         contentView.alpha = 1.0f;
                     }];
}

- (void)hideAnimation {
    [UIView animateWithDuration:0.3
        animations:^{
            contentView.alpha = 0.0f;
        }
        completion:^(BOOL finished) {
            [self dismissToast];
        }];
}

- (void)dismissToast {
    [contentView removeFromSuperview];
    if (self.orientationSensitive) {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIApplicationDidChangeStatusBarOrientationNotification
                                                      object:nil];
    }
}

- (void)showToast {
    m_autoresizingMask = UIViewAutoresizingNone;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self showInView:window
        withCenterPosition:[UIApplication sharedApplication].keyWindow.center
                   ZoomMax:self.isZoomMax];
}

- (void)showInView:(UIView *)view withCenterPosition:(CGPoint)centerSize ZoomMax:(BOOL)isZoom {
    [contentView transformViewWithOrientation:UIInterfaceOrientationPortrait];

    CGSize textSize = lbl.frame.size;
    if (isZoom) {
        textSize.width += 30;
        textSize.height += 20;
        textSize.width = MAX(textSize.width, 150);
        textSize.height = MAX(textSize.height, 83);
    } else {
        textSize.width += 30;
        textSize.height += 20;
    }
    contentView.frame = CGRectMake(0, 0, textSize.width, textSize.height);
    lbl.center = CGPointMake(textSize.width / 2, textSize.height / 2);

    contentView.center = centerSize;
    [self setCenterAutosize];

    if (contentView.superview != view) {
        [contentView removeFromSuperview];
        [view addSubview:contentView];
    }

    if (self.orientationSensitive) {  //监听设备方向改变
        [contentView transformViewByCurrentOrientation];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(viewOrientationChangeNotice)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIApplicationDidChangeStatusBarOrientationNotification
                                                      object:nil];
    }

    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self showAnimation];
    if (duration < 0) {
        return;
    }
    if (duration == 0) {
        duration = DEFAULT_DISPLAY_DURATION;
    }
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:duration];
}

- (void)viewOrientationChangeNotice {
    [self setCenterAutosize];
    [contentView transformViewByCurrentOrientation];
}

- (void)setCenterAutosize {
    BOOL osVersionIs8AndAbove =
        [[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending;

    if (m_autoresizingMask == UIViewAutoresizingNone) {
        contentView.center = [UIApplication sharedApplication].keyWindow.center;
        return;
    }
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGSize size = [UIApplication sharedApplication].keyWindow.frame.size;
    CGPoint point = CGPointZero;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            point.x = size.width / 2;
            if (m_autoresizingMask == UIViewAutoresizingFlexibleTopMargin) {
                point.y = m_topMargin;
            } else if (m_autoresizingMask == UIViewAutoresizingFlexibleBottomMargin) {
                point.y = size.height - m_bottomMargin;
            }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            point.x = size.width / 2;
            if (m_autoresizingMask == UIViewAutoresizingFlexibleTopMargin) {
                point.y = size.height - m_topMargin;
            } else if (m_autoresizingMask == UIViewAutoresizingFlexibleBottomMargin) {
                point.y = m_bottomMargin;
            }
            break;
        case UIInterfaceOrientationLandscapeRight:
            if (osVersionIs8AndAbove) {
                point.x = size.width / 2;
                if (m_autoresizingMask == UIViewAutoresizingFlexibleTopMargin) {
                    point.y = size.height - m_topMargin;
                } else if (m_autoresizingMask == UIViewAutoresizingFlexibleBottomMargin) {
                    point.y = size.height - m_bottomMargin;
                }
            } else {
                point.y = size.height / 2;
                if (m_autoresizingMask == UIViewAutoresizingFlexibleTopMargin) {
                    point.x = size.width - m_topMargin;
                } else if (m_autoresizingMask == UIViewAutoresizingFlexibleBottomMargin) {
                    point.x = m_bottomMargin;
                }
            }

            break;
        case UIInterfaceOrientationLandscapeLeft:
            if (osVersionIs8AndAbove) {
                point.x = size.width / 2;
                if (m_autoresizingMask == UIViewAutoresizingFlexibleTopMargin) {
                    point.y = m_topMargin;
                } else if (m_autoresizingMask == UIViewAutoresizingFlexibleBottomMargin) {
                    point.y = size.height - m_bottomMargin;
                }
            } else {
                point.y = size.height / 2;
                if (m_autoresizingMask == UIViewAutoresizingFlexibleTopMargin) {
                    point.x = m_topMargin;
                } else if (m_autoresizingMask == UIViewAutoresizingFlexibleBottomMargin) {
                    point.x = size.width - m_bottomMargin;
                }
            }

            break;
        default:
            break;
    }
    contentView.center = point;
}

- (void)showInView:(UIView *)view {
    m_autoresizingMask = UIViewAutoresizingNone;
    [self showInView:view withCenterPosition:view.center ZoomMax:YES];
}

- (void)showFromTopOffset:(CGFloat)top {
    m_topMargin = top;
    m_autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGPoint point = CGPointMake(window.center.x, top);
    [self showInView:window withCenterPosition:point ZoomMax:NO];
}

- (void)showFromBottomOffset:(CGFloat)bottom {
    m_bottomMargin = bottom;
    m_autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGPoint point = CGPointMake(window.center.x, window.frame.size.height - m_bottomMargin);
    [self showInView:window withCenterPosition:point ZoomMax:NO];
}

#pragma mark -
+ (TTToast *)showWithText:(NSString *)text duration:(CGFloat)duration {
    TTToast *toast = [TTToast sharedInstance];
    [toast setText:text];
    [toast setDuration:duration];
    [toast showToast];
    return toast;
}

+ (TTToast *)showWithText:(NSString *)text
                 duration:(CGFloat)duration
                   inView:(UIView *)view
     orientationSensitive:(BOOL)orientationSensitive {
    TTToast *toast = [TTToast sharedInstance];
    [toast setText:text];
    toast.orientationSensitive = orientationSensitive;
    [toast setDuration:duration];
    [toast showInView:view];
    return toast;
}

+ (TTToast *)showWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration {
    TTToast *toast = [TTToast sharedInstance];
    [toast setText:text];
    [toast setDuration:duration];
    [toast showFromTopOffset:topOffset];
    return toast;
}

+ (TTToast *)showWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration {
    TTToast *toast = [TTToast sharedInstance];
    [toast setText:text];
    [toast setDuration:duration];
    [toast showFromBottomOffset:bottomOffset];
    return toast;
}

+ (TTToast *)showWithText:(NSString *)text {
    return [TTToast showWithText:text duration:DEFAULT_DISPLAY_DURATION];
}

+ (TTToast *)showWithText:(NSString *)text topOffset:(CGFloat)topOffset {
    return [TTToast showWithText:text topOffset:topOffset duration:DEFAULT_DISPLAY_DURATION];
}

+ (TTToast *)showWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset {
    return [TTToast showWithText:text bottomOffset:bottomOffset duration:DEFAULT_DISPLAY_DURATION];
}

+ (TTToast *)showWithText:(NSString *)text inView:(UIView *)view orientationSensitive:(BOOL)orientationSensitive {
    return [TTToast showWithText:text
                        duration:DEFAULT_DISPLAY_DURATION
                          inView:view
            orientationSensitive:orientationSensitive];
}

@end