//
//  MYScanViewController.m
//  musixise
//
//  Created by wmy on 2017/4/17.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MYWidget/MYMaskView.h>
#import "MYScanView.h"

#define kScanWidth 200

@interface MYScanViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureDevice *device;// 捕获设备，后置摄像头
@property (nonatomic, strong) AVCaptureDeviceInput *input;// 输入设备
@property (nonatomic, strong) AVCaptureMetadataOutput *output;// 输出设备，需要制定输出类型及扫描范围
@property (nonatomic, strong) AVCaptureSession *session;// 协调输入输出设备以获得数据
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) MYScanView *scanView;
@property (nonatomic, strong) MYMaskView *maskView;

@end

@implementation MYScanViewController

#pragma mark - --------------------退出清空------------------

- (void)dealloc {
    [self.scanView stopAnimation];
}

#pragma mark - --------------------初始化--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData {
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.output]) {
        [self.session addOutput:self.output];
    }
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [self.output setRectOfInterest:self.scanView.frame];
}

- (void)initView {
    [self.view addSubview:self.scanView];
    self.scanView.centerX = self.view.width * 0.5;
    self.scanView.centerY = self.view.height * 0.5;
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    [self startScan];
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (BOOL)isBarAlpha {
    return YES;
}

#pragma mark - --------------------功能函数------------------

- (void)startScan {
    [self.scanView startAnimation];
    [self.session startRunning];
}

- (void)stopScan {
    [self.scanView stopAnimation];
    [self.session stopRunning];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------

#pragma mark AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection {
    NSString *stringValue;
    if (metadataObjects.count > 0) {
        [self stopScan];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        //TODO: wmy 蜂鸣声
    }
    //TODO: wmy 返回，跳转扫描结果
    DebugLog(@"stringValue = %@",stringValue);
    if (!isEmptyString(stringValue)) {
        [router routeUrl:@"musixise://back"];
        if ([stringValue hasPrefix:@"musixise://"]) {
            [router routeUrl:stringValue];
        } else {
            if ([stringValue hasPrefix:@"http://m.musixise.com"] ||
                [stringValue hasPrefix:@"m.musixise.com"]) {
                [router routeUrl:[NSString stringWithFormat:@"musixise://openWebPage?url=%@",stringValue]];
            }
            //TODO: wmy
        }
    }
    
}

#pragma mark - --------------------属性相关------------------

- (MYMaskView *)maskView {
    if (!_maskView) {
        _maskView = [[MYMaskView alloc] init];
        _maskView.frame = self.view.frame;
    }
    return _maskView;
}

- (AVCaptureDevice *)device {
    if (!_device) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}

- (AVCaptureDeviceInput *)input {
    if (!_input) {
        NSError *error;
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device
                                                       error:&error];
    }
    return _input;
}

- (AVCaptureMetadataOutput *)output {
    if (!_output) {
        _output = [[AVCaptureMetadataOutput alloc] init];
        CGRect viewRect = self.view.frame;
        CGRect containerRect = self.scanView.frame;
        
        CGFloat x = containerRect.origin.y / viewRect.size.height;
        CGFloat y = containerRect.origin.x / viewRect.size.width;
        CGFloat width = containerRect.size.height / viewRect.size.height;
        CGFloat height = containerRect.size.width / viewRect.size.width;
        
        _output.rectOfInterest = CGRectMake(x, y, width, height);
    }
    return _output;
}

- (AVCaptureSession *)session {
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
    }
    return _session;
}

- (AVCaptureVideoPreviewLayer *)previewLayer {
    if (!_previewLayer) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _previewLayer.frame = self.view.layer.bounds;
    }
    return _previewLayer;
}

- (MYScanView *)scanView {
    if (!_scanView) {
        _scanView = [[MYScanView alloc] init];
        _scanView.width = kScanWidth;
        _scanView.height = kScanWidth;
    }
    return _scanView;
}

@end
