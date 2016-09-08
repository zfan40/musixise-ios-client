//
//  TTTipsHelper.h
//  Pods
//
//  Created by kebi on 15/12/8.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum {
    TTTip_Init = 0,
    TTTip_Msg,
    TTTip_OK,
    TTTip_Info,
    TTTip_Warn,
    TTTip_Error,
} TTTipStyle;

@interface TTTipContent : NSObject
@property (nonatomic, assign) BOOL threadSafe;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *cancel;
@property (nonatomic, strong) NSString *confirm;
@property (nonatomic, assign) TTTipStyle style;
@property (nonatomic, strong) id userdata;
@property (nonatomic, assign) int tag;
@end

typedef void (^TTTipFinished)(NSInteger btnIdx, TTTipContent *ctx);
typedef void (^TTTipHandler)(TTTipContent *ctx, UIView *view, TTTipFinished block);

@interface TTTipsHelper : NSObject
+ (void)setTipHandler:(TTTipHandler)handler;

+ (void)show:(TTTipContent *)ctx;
+ (void)show:(TTTipContent *)ctx finished:(TTTipFinished)block;
+ (void)show:(NSString *)msg style:(TTTipStyle)style;
+ (void)show:(NSString *)msg title:(NSString *)title style:(TTTipStyle)style;
+ (void)showTip:(NSString *)msg point:(CGPoint)pt;

+ (void)showMsg:(NSString *)msg;
+ (void)showMsg:(NSString *)msg title:(NSString *)title;
+ (void)showMsg:(NSString *)msg title:(NSString *)title cancel:(NSString *)cancel;
+ (void)showMsg:(NSString *)msg title:(NSString *)title cancel:(NSString *)cancel confirm:(NSString *)confirm;
+ (void)showMsg:(NSString *)msg
          title:(NSString *)title
         cancel:(NSString *)cancel
        confirm:(NSString *)confirm
       finisehd:(TTTipFinished)block;

+ (void)showTipWithFormat:(NSString *)fmt, ...;
+ (void)showTip:(NSString *)msg;
+ (void)showTip:(NSString *)msg inView:(UIView *)view;
+ (void)showTip:(NSString *)msg title:(NSString *)title;

+ (void)warningTipWithFormat:(NSString *)fmt, ...;
+ (void)warningTip:(NSString *)msg;
+ (void)warningTip:(NSString *)msg title:(NSString *)title;

+ (void)errorTipWithFormat:(NSString *)fmt, ...;
+ (void)errorTip:(NSString *)msg;
+ (void)errorTip:(NSString *)msg title:(NSString *)title;

+ (void)finishedTipWithFormat:(NSString *)fmt, ...;
+ (void)finishedTip:(NSString *)msg;
+ (void)finishedTip:(NSString *)msg title:(NSString *)titile;

+ (void)closeTip;
@end
