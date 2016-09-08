//
//  TTPhotoPicker.m
//  Pods
//
//  Created by kebi on 15/12/9.
//
//

#import "TTPhotoPicker.h"
#import "TTTipsHelper.h"
#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>

#define kTTPhotoPickerSelectedMaxCout 9

static NSString *actionSheet;
static NSString *imagePick;
@interface TTPhotoPicker () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, copy) void (^block)(NSArray *image);
@property (nonatomic, assign) BOOL singleSelect;
@end

@implementation TTPhotoPicker

+ (TTPhotoPicker *)showCameraToAllowsEditing:(BOOL)allowsEditing
                                singleSelect:(BOOL)isSingleSelect
                                       block:(void (^)(NSArray *image))block {
    TTPhotoPicker *photoPicker = [TTPhotoPicker new];
    photoPicker.block = block;
    photoPicker.singleSelect = isSingleSelect;
    [photoPicker chooseCameraImage];
    return photoPicker;
}

- (BOOL)checkCamaraIsReady {
    BOOL isCameraValid = YES;
    //判断iOS7的宏，没有就自己写个，下边的方法是iOS7新加的，7以下调用会报错
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus != AVAuthorizationStatusAuthorized) {
            isCameraValid = NO;
        }
    }
    return isCameraValid;
}

//-(void)chooseSingleAlbum{
//    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//    objc_setAssociatedObject(imagePicker,
//                             &imagePick,
//                             self,
//                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    imagePicker.view.backgroundColor = [UIColor whiteColor];
//    imagePicker.delegate = self;
//    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    imagePicker.allowsEditing = _allowsEditing;
//    UIViewController *viewcontroller =  [UIApplication sharedApplication].delegate.window.rootViewController;
//    [viewcontroller presentViewController:imagePicker animated:YES completion:nil];
//
//}

- (void)chooseCameraImage {
    if (![self checkCamaraIsReady]) {
        [TTTipsHelper
            showMsg:@"请在iPhone的\"设置-隐私-相机\"选项中，允许树根金融访问你的相机。"
              title:@""
             cancel:nil
            confirm:@"确定"];
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    objc_setAssociatedObject(imagePicker, &imagePick, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    imagePicker.delegate = self;
    imagePicker.view.backgroundColor = [UIColor whiteColor];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = YES;
    UIViewController *viewcontroller = [UIApplication sharedApplication].delegate.window.rootViewController;
    [viewcontroller presentViewController:imagePicker
                                 animated:YES
                               completion:^{

                               }];
}

#pragma marks-- ----UIImagePickerController delegate-- ------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    if (YES) {
        image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    }
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    UIImage *resizeedImage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(640, 640)];

    if (resizeedImage && self.block) {
        self.block(@[resizeedImage]);
    }

    UIViewController *viewcontroller = [UIApplication sharedApplication].delegate.window.rootViewController;
    [viewcontroller dismissViewControllerAnimated:YES
                                       completion:^{

                                       }];
}

- (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize {
    if (image.size.width > newSize.width) {
        newSize.height = newSize.width * image.size.height / image.size.width;
        UIGraphicsBeginImageContext(newSize);
        [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    } else {
        return image;
    }
}

@end
