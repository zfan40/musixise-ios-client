//
//  MYShareModelProtocol.h
//  Pods
//
//  Created by wmy on 2016/11/1.
//
//

#ifndef MYShareModelProtocol_h
#define MYShareModelProtocol_h

@protocol MYShareModelProtocol <NSObject>

//TODO: wmy 根据不同sdk的分享来进行
@property(nonatomic, strong) NSString *text;
@property(nonatomic, assign) NSData *imageData;
@property(nonatomic, strong) NSString *detailTitle;
@property(nonatomic, strong) NSString *objdctID;
@property(nonatomic, strong) NSString *webPageUrl;
//TODO: wmy
@property(nonatomic, strong) NSURL *url;

@end


#endif /* MYShareModelProtocol_h */
