//
//  MYSwitch.m
//  Pods
//
//  Created by wmy on 16/6/13.
//
//

#import "MYSwitch.h"
#import "MYWidget.h"

#define kSwitchHeight 25
#define kSwitchWidth 45

@interface MYSwitch ()

@property (nonatomic,strong) UIView *buttonView;
@property (nonatomic,strong) UIView *onBackView;
@end

@implementation MYSwitch

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------
- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}


- (void) initView {
    self.isOn = NO;
    self.buttonView.left = 0;
    self.onBackView.width = 0;
    self.clipsToBounds = NO;
    [self addSubview:self.onBackView];
    [self addSubview:self.buttonView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                         action:@selector(onClickSwitch)];
    [self addGestureRecognizer:tap];
}

+ (instancetype)newSwitchWithBackgroundColor:(UIColor *)backColor foregroundColor:(UIColor *)foreColor {
    MYSwitch *aSwitch = [[MYSwitch alloc] init];
    
    aSwitch.buttonView.backgroundColor = foreColor;
    aSwitch.onBackView.backgroundColor = backColor;
    
    aSwitch.layer.borderWidth = 1.0 /[UIScreen mainScreen].scale ;
    aSwitch.layer.borderColor = foreColor.CGColor;
    aSwitch.width = kSwitchWidth;
    aSwitch.height = kSwitchHeight;
    return aSwitch;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.cornerRadius = self.height * 0.5;
    
    self.buttonView.width = self.height;
    self.buttonView.height = self.height;
    self.buttonView.centerY = self.height * 0.5;
    self.buttonView.cornerRadius = self.height * 0.5;
    
    self.onBackView.height =self.height;
    self.onBackView.left = 0;
    self.onBackView.top = 0;
}

#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------

- (void)onClickSwitch {
    self.isOn = !self.isOn;
    if ([self.delegate respondsToSelector:@selector(switchisOn:)]) {
        [self.delegate switchisOn:self.isOn];
    }
}

#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

newInstanceUIView(buttonView, _buttonView)
newInstanceUIView(onBackView, _onBackView)

- (void)setIsOn:(BOOL)isOn {
    if (isOn) {
        [UIView animateWithDuration:0.25 animations:^{
            self.buttonView.left = self.width - self.height;
            self.onBackView.width = self.width - self.height * 0.5;
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            self.buttonView.right = self.buttonView.width;
            self.onBackView.width = self.height * 0.5;
        }];
        
    }
    self.buttonView.centerY = self.height * 0.5;
    _isOn = isOn;
    [self setNeedsLayout];
}


@end
