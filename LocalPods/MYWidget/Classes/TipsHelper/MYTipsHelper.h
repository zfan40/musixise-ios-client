//
//  MYTipsHelper.h
//  Pods
//
//  Created by wmy on 16/2/2.
//
//

#import <UIKit/UIKit.h>
#import <MYUtils/MYBasicSingleton.h>
#define theTipsHelper [MYTipsHelper sharedInstance]
@interface MYTipsHelper : MYBasicSingleton

- (void)showTips:(NSString *)text;



@end
