//
//  MYThirdWeiboShareManager.h
//  Pods
//
//  Created by wmy on 2016/11/1.
//
//

#import <MYUtils/MYBasicSingleton.h>
#import "MYShareModelProtocol.h"

@interface MYThirdWeiboShareManager : MYBasicSingleton

- (void)shareWithShareModel:(id<MYShareModelProtocol>)shareModel;

@end
