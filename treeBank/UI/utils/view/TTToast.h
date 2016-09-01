//
//  TTToast.h
//  TTPod
//
//  Created by lihui on 2/1/13.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define DEFAULT_DISPLAY_DURATION 2.0f

@interface TTToast : NSObject

@property (nonatomic, assign) BOOL orientationSensitive;
@property (nonatomic, assign) BOOL isZoomMax;
@property (nonatomic, assign) CGFloat toastFontSize;
@property (nonatomic, assign) CGFloat toastRadius;
@property (nonatomic, assign) CGFloat toastAlpha;

+ (TTToast *)sharedInstance;

+ (TTToast *)showWithText:(NSString *)text;
+ (TTToast *)showWithText:(NSString *)text duration:(CGFloat)duration;

+ (TTToast *)showWithText:(NSString *)text topOffset:(CGFloat)topOffset;
+ (TTToast *)showWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration;

+ (TTToast *)showWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset;
+ (TTToast *)showWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration;
+ (TTToast *)showWithText:(NSString *)text inView:(UIView *)view orientationSensitive:(BOOL)orientationSensitive;

- (void)setText:(NSString *)text;
- (void)setDuration:(CGFloat)duration_;

- (void)showToast;
- (void)showInView:(UIView *)view;
- (void)showFromTopOffset:(CGFloat)top;
- (void)showFromBottomOffset:(CGFloat)bottom;
- (void)dismissToast;

- (void)showWaitAnim:(NSString *)text;
- (void)hideWaitAnim;

@end