//
//  MYPlayerViewController.m
//  musixise
//
//  Created by wmy on 2017/4/21.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYPlayerViewController.h"
#import "MYPlayerTitleView.h"
#import "MYPlayerBar.h"
#import "MYPlayerToolBar.h"

@interface MYPlayerViewController () <MYPlayerBarProtocol>

@property (nonatomic, strong) MYPlayerTitleView *titleView;
@property (nonatomic, strong) MYPlayerBar *playerBar;
@property (nonatomic, strong) MYPlayerToolBar *toolBar;

@end

@implementation MYPlayerViewController

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

+ (instancetype)sharedInstance {
    static MYPlayerViewController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance=[[self alloc] init];
    });
    return sharedInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData {
    
}

- (void)initView {
    self.navigationItem.titleView = self.titleView;
    //TODO: wmy test
    [self.titleView setTitle:@"标题"];
    [self.titleView setSubTitle:@"副标题"];
    
    [self.view addSubview:self.playerBar];
    self.playerBar.bottom = self.view.height;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (BOOL)isBarAlpha {
    return YES;
}

#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------

#pragma mark MYPlayerBarProtocol

- (void)playerBarDidClickNextButton:(MYPlayerBar *)playerBar {
    
}

- (void)playerBarDidClickPreButton:(MYPlayerBar *)playerBar {
    
}

- (void)playerBar:(MYPlayerBar *)playerBar didClickPlayButton:(BOOL)isPlay {
    
}

- (void)playerBarDidClickMoreButton:(MYPlayerBar *)playerBar {
    
}

- (void)playerBar:(MYPlayerBar *)playerBar didChangePlayMode:(MYPlayerModeType)type {
    
}

#pragma mark - --------------------属性相关------------------

- (MYPlayerTitleView *)titleView {
    if (!_titleView) {
        _titleView = [[MYPlayerTitleView alloc] init];
        _titleView.width = kScreenWidth - 150;
        _titleView.height = 44;
#if DEBUG
        _titleView.layer.borderWidth = 1;
        _titleView.layer.borderColor = [UIColor redColor].CGColor;
#endif
    }
    return _titleView;
}

- (MYPlayerToolBar *)toolBar {
    if (!_toolBar) {
        _toolBar = [MYPlayerToolBar playerToolBar];
    }
    return _toolBar;
}

- (MYPlayerBar *)playerBar {
    if (!_playerBar) {
        _playerBar = [MYPlayerBar playerBar];
        _playerBar.delegate = self;
    }
    return _playerBar;
}

@end
