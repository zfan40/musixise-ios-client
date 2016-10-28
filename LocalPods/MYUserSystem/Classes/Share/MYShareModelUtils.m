//
//  MYShareModelUtils.m
//  Pods
//
//  Created by wmy on 16/10/10.
//
//

#import "MYShareModelUtils.h"
#import "MYWeiboManager.h"
#import "MYShareModel.h"
#import "MYWeiBoShareImageModel.h"
#import "MYWeiBoShareMediaModel.h"

@implementation MYShareModelUtils

+ (MYShareModel *)modelWithType:(MYShareModelType)type {
    MYShareModel *shareModel = [[MYShareModel alloc] init];
    shareModel.name = [self nameWithType:type];
    shareModel.image = [self imageWithType:type];
    shareModel.block = [self blockWithType:type];
    //TODO: wmy 给block赋值
    return shareModel;
}

+ (ClickBlock)blockWithType:(MYShareModelType)type {
    switch (type) {
        case MYShareModelUtilsType_QQ:
            return ^{
            };
        case MYShareModelUtilsType_Qzone:
            return ^{
            };
        case MYShareModelUtilsType_Weibo:
            return ^{
                [[MYWeiboManager sharedInstance] shareWithShareModel:[self testMediaModel]];
            };
        case MYShareModelUtilsType_Weixin:
            return ^{
            };
        case MYShareModelUtilsType_Weixin_Friends:
            return ^{
            };
        default:
            break;
    }
}

+ (MYWeiBoShareImageModel *)testImageModel {
    MYWeiBoShareImageModel *imageModel = [[MYWeiBoShareImageModel alloc] init];
    imageModel.text = @"test文案";
//    imageModel.imageData = UIImagePNGRepresentation([UIImage imageNamed:@"1"]);
    return imageModel;
}

+ (MYWeiBoShareMediaModel *)testMediaModel {
    MYWeiBoShareMediaModel *testModel = [[MYWeiBoShareMediaModel alloc] init];
    testModel.text = @"test";
    testModel.title = @"test文案";
    testModel.detailTitle = @"test detail";
    testModel.webPageUrl = @"http://www.musixise.com";
    testModel.objdctID = @"";
    testModel.imageData = [UIImage imageNamed:@"AppIcon"];
    return testModel;
}


+ (UIImage *)imageWithType:(MYShareModelType)type {
    NSString *imageName = nil;
    switch (type) {
        case MYShareModelUtilsType_QQ:
            imageName = @"global_btn_share_qq";
            break;
        case MYShareModelUtilsType_Qzone:
            imageName = @"global_btn_share_qzone";
            break;
        case MYShareModelUtilsType_Weibo:
            imageName = @"global_btn_share_share";
            break;
        case MYShareModelUtilsType_Weixin:
            imageName = @"global_btn_share_weixin";
            break;
        case MYShareModelUtilsType_Weixin_Friends:
            imageName = @"global_btn_share_pengyouquan";
            break;
    }
    UIImage *image = [UIImage imageNamed:imageName];
    return image;
}

+ (NSString *)nameWithType:(MYShareModelType)type {
    NSString *name = nil;
    switch (type) {
        case MYShareModelUtilsType_QQ:
            name = @"QQ好友";
            break;
        case MYShareModelUtilsType_Qzone:
            name = @"QQ空间";
            break;
        case MYShareModelUtilsType_Weibo:
            name = @"微博";
            break;
        case MYShareModelUtilsType_Weixin:
            name = @"微信好友";
            break;
        case MYShareModelUtilsType_Weixin_Friends:
            name = @"朋友圈";
            break;
    }
    return name;
}

@end
