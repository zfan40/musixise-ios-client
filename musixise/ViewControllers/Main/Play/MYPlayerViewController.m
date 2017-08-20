//
//  MYPlayerViewController.m
//  musixise
//
//  Created by wmy on 2017/4/21.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYPlayerViewController.h"
#import "MYPlayListManager.h"
#import "MYPlayerTitleView.h"
#import "MYWorkViewModel.h"
#import "MYPlayerBar.h"
#import "MYPlayerToolBar.h"
#import "MYWorkListModel.h"

#define kImageWidth (kScreenWidth - 20 * 2)

@interface MYPlayerViewController () <MYPlayerBarProtocol>

@property (nonatomic, strong) MYPlayerTitleView *titleView;
@property (nonatomic, strong) MYPlayerBar *playerBar;
@property (nonatomic, strong) MYPlayerToolBar *toolBar;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) MYWorkListModel *workListModel;
@property(nonatomic, weak) MYWorkViewModel *currentViewModel;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onReceiveStart) name:kStartPlayingNofitication object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onReceiveStop) name:kStopSongNofitication object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onReceiveNext) name:kNextSongNofitication object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onReceivePre) name:kPreSongNofitication object:nil];
}




- (void)initData {
    self.workListModel = [[MYPlayListManager sharedInstance] listModel];
    self.currentViewModel = [[MYPlayListManager sharedInstance] currentModel];
}

- (void)initView {
    self.navigationItem.titleView = self.titleView;
    [self.view addSubview:self.logoImageView];
    self.logoImageView.top = 30 + self.titleView.bottom;
    self.logoImageView.centerX = kScreenWidth * 0.5;
    [self.titleView setTitle:self.currentViewModel.title];
    [self.titleView setSubTitle:self.currentViewModel.detail];
    
    [self.view addSubview:self.playerBar];
    self.playerBar.bottom = self.view.height;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)viewModelDataChanged {
    [super viewModelDataChanged];
}

- (BOOL)playBarHidden {
    return YES; 
}

- (BOOL)isBarAlpha {
    return YES;
}

- (MYBaseViewControllerMode)mode {
    return MYBaseViewControllerModeOnlyOne;
}
#pragma mark - --------------------功能函数------------------

- (void)refreshSong {
    self.currentViewModel = [[MYPlayListManager sharedInstance] currentModel];
    [self.titleView setTitle:self.currentViewModel.title];
    [self.titleView setSubTitle:self.currentViewModel.detail];
}

- (void)onReceiveStart {
    [self.playerBar setPlay:YES];
    [self refreshSong];
}

- (void)onReceivePre {
    [self refreshSong];
}

- (void)onReceiveNext {
    [self refreshSong];
}

- (void)onReceiveStop {
    [self.playerBar setPlay:NO];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------

#pragma mark MYPlayerBarProtocol

- (void)playerBarDidClickNextButton:(MYPlayerBar *)playerBar {
    [[MYPlayListManager sharedInstance] next];
}

- (void)playerBarDidClickPreButton:(MYPlayerBar *)playerBar {
    [[MYPlayListManager sharedInstance] pre];
}

- (void)playerBar:(MYPlayerBar *)playerBar didClickPlayButton:(BOOL)isPlay {
    if (isPlay) {
        [[MYPlayListManager sharedInstance] pause];
    } else {
        [[MYPlayListManager sharedInstance] resume];
    }
}

- (void)playerBarDidClickMoreButton:(MYPlayerBar *)playerBar {
    [self showTip:@"点击更多"];
}

- (void)playerBar:(MYPlayerBar *)playerBar didChangePlayMode:(MYPlayerModeType)type {
    
}

#pragma mark - --------------------属性相关------------------

- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.width = kImageWidth;
        _logoImageView.height = kImageWidth;
#if DEBUG
        _logoImageView.layer.borderWidth = 1;
        _logoImageView.layer.borderColor = [UIColor redColor].CGColor;
#endif
    }
    return _logoImageView;
}

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
