//
//  TTAuthPostViewController.m
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTApiService.h"
#import "TTAuthPostViewController.h"
#import "TTMainHeadView.h"
#import "TTPhotoPicker.h"
#import "TTRunTime.h"
#import "TTTipsHelper.h"
#import "TTUIViewAdditons.h"
#import "TTUtility.h"

@interface TTAuthPostViewController ()
@property (nonatomic, strong) IBOutlet UIButton *postButton;
@property (nonatomic, strong) IBOutlet TTMainButton *idCardUpBtn;
@property (nonatomic, strong) IBOutlet TTMainButton *idCardDownBtn;
@property (nonatomic, strong) IBOutlet TTMainButton *bankCardBtn;
@property (nonatomic, strong) IBOutlet TTMainButton *personPicBtn;
@property (nonatomic, strong) IBOutlet UIImageView *idCardUpImageView;
@property (nonatomic, strong) IBOutlet UIImageView *idCardDownImageView;
@property (nonatomic, strong) IBOutlet UIImageView *bankCardImageView;
@property (nonatomic, strong) IBOutlet UIImageView *personPicImageView;
@property (nonatomic, strong) IBOutlet UIView *line1;
@property (nonatomic, strong) IBOutlet UIView *line2;

@end

@implementation TTAuthPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
    _idCardUpBtn.label.text = @"身份证正面";
    _idCardDownBtn.label.text = @"身份证反面";
    _idCardUpBtn.mainImageView.image = [UIImage imageNamed:@"idcardUp"];
    _idCardDownBtn.mainImageView.image = [UIImage imageNamed:@"idcardDown"];
    _bankCardBtn.label.text = @"银行卡正面";
    _personPicBtn.label.text = @"手持证件个人照";
    _bankCardBtn.mainImageView.image = [UIImage imageNamed:@"bankCard"];
    _personPicBtn.mainImageView.image = [UIImage imageNamed:@"personPic"];
    _line1.backgroundColor = RGBA(0, 0, 0, 0.2);
    _line2.backgroundColor = RGBA(0, 0, 0, 0.2);
    [_idCardUpImageView.superview bringSubviewToFront:_idCardUpImageView];
    [_bankCardImageView.superview bringSubviewToFront:_bankCardImageView];
    [_idCardUpBtn addTarget:self action:@selector(onIdCardUpClick) forControlEvents:UIControlEventTouchUpInside];
    [_idCardDownBtn addTarget:self action:@selector(onIdCardDownClick) forControlEvents:UIControlEventTouchUpInside];
    [_bankCardBtn addTarget:self action:@selector(onBankCardClick) forControlEvents:UIControlEventTouchUpInside];
    [_personPicBtn addTarget:self action:@selector(onPersonPicClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onIdCardUpClick {
    [TTPhotoPicker showCameraToAllowsEditing:YES
                                singleSelect:YES
                                       block:^(NSArray *image) {
                                           _idCardUpImageView.image = image.firstObject;
                                       }];
}

- (void)onIdCardDownClick {
    [TTPhotoPicker showCameraToAllowsEditing:YES
                                singleSelect:YES
                                       block:^(NSArray *image) {
                                           _idCardDownImageView.image = image.firstObject;
                                       }];
}

- (void)onBankCardClick {
    [TTPhotoPicker showCameraToAllowsEditing:YES
                                singleSelect:YES
                                       block:^(NSArray *image) {
                                           _bankCardImageView.image = image.firstObject;
                                       }];
}

- (void)onPersonPicClick {
    [TTPhotoPicker showCameraToAllowsEditing:YES
                                singleSelect:YES
                                       block:^(NSArray *image) {
                                           _personPicImageView.image = image.firstObject;
                                       }];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGSize size = self.view.frame.size;
    CGSize cellSize = CGSizeMake(size.width / 2.0, 125);
    _idCardUpBtn.frame = CGRectMake(0, 0, cellSize.width, cellSize.height);
    _idCardUpImageView.frame = _idCardUpBtn.frame;
    _idCardDownImageView.frame = CGRectMake(cellSize.width, 0, cellSize.width, cellSize.height);
    _idCardDownBtn.frame = _idCardDownImageView.frame;

    _bankCardImageView.frame = CGRectMake(0, 0, cellSize.width, cellSize.height);
    _bankCardBtn.frame = _bankCardImageView.frame;
    _personPicImageView.frame = CGRectMake(cellSize.width, 0, cellSize.width, cellSize.height);
    _personPicBtn.frame = _personPicImageView.frame;
    _line1.frame = CGRectMake(cellSize.width, 0, 0.5, cellSize.height);
    _line2.frame = _line1.frame;
    _postButton.frame = CGRectMake(20, _personPicImageView.superview.bottom + 30, self.view.width - 40, 40);
}

- (IBAction)onPost:(id)sender {
    NSMutableDictionary *dics = [NSMutableDictionary new];
    [dics setObject:_model.name forKey:@"fullname"];
    [dics setObject:_model.idCard forKey:@"certno"];
    [dics setObject:_model.accountBankId forKey:@"bankcode"];
    [dics setObject:@(_model.provinceCardId) forKey:@"province"];
    [dics setObject:@(_model.cityCardId) forKey:@"city"];

    [dics setObject:_model.bankName forKey:@"brancename"];
    [dics setObject:[TTRunTime instance].user.token forKey:@"token"];
    [dics setObject:[TTRunTime instance].user.objId forKey:@"memberid"];

    [dics setObject:_model.bankCard forKey:@"bankno"];

    NSMutableDictionary *imageDics = [NSMutableDictionary new];

    [imageDics setObject:_idCardUpImageView.image forKey:@"idezfile"];
    [imageDics setObject:_idCardDownImageView.image forKey:@"ideffile"];
    [imageDics setObject:_bankCardImageView.image forKey:@"bankfile"];
    [imageDics setObject:_personPicImageView.image forKey:@"personfile"];

    [theApiService postImageRequest:@"/account/certification.htm"
                          parameter:dics
                          imageDics:imageDics
                              block:^(id result, BOOL ret, NSError *error) {
                                  BOOL status = [[result objectForKey:@"success"] boolValue];
                                  NSString *message = [result objectForKey:@"message"];
                                  if (status) {
                                      [TTTipsHelper showTip:@"实名认证资料提交成功"];
                                      [self route:@"treeBank://interBack"
                                          withParam:@{
                                              @"viewController": @"TTMyMainViewController"
                                          }];
                                  } else {
                                      [TTTipsHelper showTip:message];
                                  }
                              }];
}

@end
