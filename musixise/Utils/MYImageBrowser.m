//
//  MYImageBrowser.m
//  musixise
//
//  Created by wmy on 2017/3/14.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYImageBrowser.h"
#import "MYUploadUtils.h"
//TODO: wmy
#import <MYMVVM/MYRouter.h>
#import <UIKit/UIKit.h>

#define kImageBrowserCarema 0
#define kImageBrowserPhoto 1
#define kImageBrowserCancel 2

@interface MYImageBrowser () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic, copy) ImageBrowserBlock block;


@end

@implementation MYImageBrowser

- (void)imageBrowserWithBlock:(ImageBrowserBlock)block {
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"图片选择器"
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:@"拍照"
                                               otherButtonTitles:@"从相册选择", nil];
    self.block = block;
    [action showInView:router.navigationController.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case kImageBrowserCarema: {
            // 调用系统相机
            [self openPickerWithSource:UIImagePickerControllerSourceTypeCamera];
        }
            break;
        case kImageBrowserPhoto: {
            // 调用系统
            [self openPickerWithSource:UIImagePickerControllerSourceTypePhotoLibrary];
        }
            break;
        case kImageBrowserCancel: {
            if (self.block) {
                self.block(nil,NO);
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)openPickerWithSource:(UIImagePickerControllerSourceType)type {
    if ([UIImagePickerController isSourceTypeAvailable:type]) {
        UIImagePickerController *imageVC = [[UIImagePickerController alloc] init];
        imageVC.delegate = self;
        imageVC.allowsEditing = YES;
        imageVC.sourceType = type;
        [router.navigationController presentViewController:imageVC animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *resultImage = [info objectForKey:UIImagePickerControllerEditedImage];
    [self uploadImage:resultImage];
}

//TODO: wmy 上传图片
- (void)uploadImage:(UIImage *)image {
    [[MYUploadUtils sharedInstance] uploadImage:image withComplete:^(NSDictionary * _Nonnull result, BOOL success, NSError * _Nullable error) {
        //TODO: wmy
        if (self.block) {
            self.block(nil, YES);
        }
    }];
}

@end
