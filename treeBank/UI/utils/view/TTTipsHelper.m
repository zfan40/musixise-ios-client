//
//  TTTipsHelper.m
//  Pods
//
//  Created by kebi on 15/12/8.
//
//

#import "TTTipsHelper.h"
#import "TTUtility.h"
#import "TTProgressHUD.h"
#import "UIAlertView+MKBlockAdditions.h"

static UIWindow *win;
static BOOL isShowKeyboard;
TTTipHandler  _tipsHandler = nil;
void ontips(TTTipContent* ctx, UIView *view, TTTipFinished block) {
    if (TTTip_Msg == ctx.style) {
        NSString* msg = ctx.msg;
        NSString* title = ctx.title;
        NSString* confirmTitle = ctx.confirm;
        NSString* cancelTitle = ctx.cancel;
        
        NSArray *others = nil;
        if (confirmTitle) {
            others = [NSArray arrayWithObject:confirmTitle];
        }
        
        UIAlertView* alert =
        [UIAlertView alertViewWithTitle:title
                                message:msg
                      cancelButtonTitle:cancelTitle
                      otherButtonTitles:others];
        
        [alert showWithCompletion:^(NSInteger buttonIndex) {
            if (block) {
                block(buttonIndex, ctx);
            }
        }];
        return;
    }
    
    
    NSString* text = ctx.title;
    NSString* detailText = ctx.msg;
    TTTipStyle style = ctx.style;
    
    if (!win) {
        win = [[UIApplication sharedApplication] keyWindow];
    }
    
    if (view) {
        [TTProgressHUD hideAllHUDsForView:view animated:NO];
    } else {
        [TTProgressHUD hideAllHUDsForView:win animated:NO];
    }
    
    TTProgressHUD * HUD = nil;
    @try
    {
        if (view) {
            HUD = [[TTProgressHUD alloc] initWithView:view];
        } else {
            HUD = [[TTProgressHUD alloc] initWithView:win];
        }
    }
    @catch (NSException *exception) {return;}
    @finally {}
    HUD.userInteractionEnabled = NO;
    HUD.isShowKeyBoard = isShowKeyboard;
    if (HUD) {
        if (view) {
            [view addSubview:HUD];
        } else {
            [win addSubview:HUD];
        }
    }
    
    if (isEmptyString(text)|| isEmptyString(detailText)) {
        text =!isEmptyString(text)?text:detailText;
        detailText =nil;
        CGSize size = [text boundingRectWithSize:CGSizeMake(INT16_MAX, 30) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:HUD.labelFont} context:nil].size;
        if(size.width > 320 -4*HUD.margin){
            detailText = text;
            text = nil;
        }
    }
    
    NSString * imgName = nil;
    switch (style) {
        case TTTip_OK:
            imgName = @"Tip_Ok.png";
            break;
        case TTTip_Warn:
            imgName = @"Tip_Warn.png";
            break;
        case TTTip_Info:
            imgName = @"Tip_Info.png";
            break;
        case TTTip_Error:
            imgName = @"Tip_Warn.png";
            break;
        default:
            break;
    }
    if (imgName && !isEmptyString(imgName))
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
    
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.removeFromSuperViewOnHide = YES;
    HUD.labelText = text;
    HUD.detailsLabelText = detailText;
    
    if (TTTip_Init == style) {
        @try {
            CGPoint pt = ((NSValue*)ctx.userdata).CGPointValue;
            if(pt.x!=0) HUD.xOffset = pt.x;
            if(pt.y!=0) HUD.yOffset = pt.y;
        }@catch (NSException *exception) {
        }
        @finally {
        }
    }
    
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];
}

@implementation TTTipsHelper

+(void)load {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self setTipHandler:^(TTTipContent *ctx, UIView *view, TTTipFinished block) {
        ontips(ctx, view, block);
    }];
}

+ (void)keyboardWillShow:(NSNotification *)note {
    win = [[UIApplication sharedApplication].windows lastObject];
    isShowKeyboard = YES;
}

+ (void)keyboardWillHide:(NSNotification *)note {
    win = [[UIApplication sharedApplication] keyWindow];
    isShowKeyboard = NO;
}

+(void)showTip:(NSString *)msg point:(CGPoint)pt {
    TTTipContent* ctx = [TTTipContent new];
    ctx.title = msg;
    ctx.userdata = [NSValue valueWithCGPoint:pt];
    [self show:ctx];
}


+(void)setTipHandler:(TTTipHandler)handler {
    _tipsHandler = handler;
}
+(void)show:(TTTipContent*)ctx {
    return [self show:ctx inView:nil finished:nil];
}

+(void)show:(TTTipContent*)ctx finished:(TTTipFinished)block {
    [self show:ctx inView:nil finished:block];
}

+(void)show:(TTTipContent*)ctx inView:(UIView *)view finished:(TTTipFinished)block {
    NSAssert(ctx, @"ctx is nil");
    if (!ctx) return;
    
    if (ctx.threadSafe && ![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            @try {
                [self show:ctx finished:block];
            }
            @catch (NSException *exception) {
            }
            @finally {
            }
        });
        return;
    }
    
    TTTipHandler handler = _tipsHandler;
    if (handler) handler(ctx, view, block);
}
+(void)show:(NSString*)msg style:(TTTipStyle)style {
    return [self show:msg title:nil style:style];
}

+(void)show:(NSString*)msg title:(NSString*)title style:(TTTipStyle)style {
    TTTipContent* ctx = [TTTipContent new];
    ctx.msg = msg;
    ctx.title = title;
    ctx.style = style;
    
    return [self show:ctx];
}



+(void)showMsg:(NSString*)msg {
    return [self showMsg:msg title:nil];
}
+(void)showMsg:(NSString*)msg title:(NSString*)title {
    return [self showMsg:msg title:title cancel:nil];
}

+(void)showMsg:(NSString*)msg title:(NSString*)title cancel:(NSString*)cancel {
    return [self showMsg:msg title:title cancel:cancel confirm:nil];
}
+(void)showMsg:(NSString *)msg title:(NSString *)title cancel:(NSString *)cancel confirm:(NSString*)confirm {
    return [self showMsg:msg title:title cancel:cancel confirm:confirm finisehd:nil];
}
+(void)showMsg:(NSString *)msg title:(NSString *)title cancel:(NSString *)cancel confirm:(NSString*)confirm finisehd:(TTTipFinished)block {
    TTTipContent* ctx = [TTTipContent new];
    ctx.msg = msg;
    ctx.title = title;
    ctx.cancel = cancel;
    ctx.confirm = confirm;
    ctx.style = TTTip_Msg;
    
    return [self show:ctx finished:block];
}


+(void)showTipWithFormat:(NSString*)fmt, ... {
    NSString* msg;
    va_list arg_ptr;
    va_start(arg_ptr, fmt);
    msg = [[NSString alloc] initWithFormat:fmt arguments:arg_ptr];
    va_end(arg_ptr);
    return [self showTip:msg];
}
+(void)showTip:(NSString*)msg {
    return [self showTip:msg title:nil];
}

+(void)showTip:(NSString *)msg inView:(UIView *)view {
    TTTipContent *ctx = [TTTipContent new];
    ctx.msg = msg;
    ctx.title = nil;
    ctx.style = TTTip_Info;
    
    return [self show:ctx inView:view finished:nil];
}

+(void)showTip:(NSString*)msg title:(NSString*)title {
    return [self show:msg title:title style:TTTip_Info];
}

+(void)warningTipWithFormat:(NSString*)fmt, ... {
    NSString* msg;
    va_list arg_ptr;
    va_start(arg_ptr, fmt);
    msg = [[NSString alloc] initWithFormat:fmt arguments:arg_ptr];
    va_end(arg_ptr);
    return [self warningTip:msg];
}

+(void)warningTip:(NSString*)msg {
    return [self warningTip:msg title:nil];
}
+(void)warningTip:(NSString*)msg title:(NSString*)title {
    return [self show:msg title:title style:TTTip_Warn];
}

+(void)errorTipWithFormat:(NSString*)fmt, ... {
    NSString* msg;
    va_list arg_ptr;
    va_start(arg_ptr, fmt);
    msg = [[NSString alloc] initWithFormat:fmt arguments:arg_ptr];
    va_end(arg_ptr);
    [self errorTip:msg];
}

+(void)errorTip:(NSString*)msg {
    return [self errorTip:msg title:nil];
}
+(void)errorTip:(NSString*)msg title:(NSString*)title {
    return [self show:msg title:title style:TTTip_Error];
}

+(void)finishedTipWithFormat:(NSString*)fmt, ... {
    NSString* msg;
    va_list arg_ptr;
    va_start(arg_ptr, fmt);
    msg = [[NSString alloc] initWithFormat:fmt arguments:arg_ptr];
    va_end(arg_ptr);
    [self finishedTip:msg];
}

+(void)finishedTip:(NSString*)msg {
    return [self finishedTip:msg title:nil];
}
+(void)finishedTip:(NSString *)msg title:(NSString*)titile {
    return [self show:msg title:titile style:TTTip_OK];
}

+(void)closeTip {
    [MBProgressHUD hideAllHUDsForView:win animated:NO];
}

@end

@implementation TTTipContent
-(instancetype)init {
    self = [super init];
    if (self) {
        _threadSafe = YES;
    }
    
    return self;
}
@end