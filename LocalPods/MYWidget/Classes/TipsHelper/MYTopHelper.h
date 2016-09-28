//
//  MYTopHelper.h
//  Pods
//
//  Created by wmy on 16/2/2.
//
//


#import <MYUtils/MYBasicSingleton.h>
#define theTopHelper [MYTopHelper sharedInstance]

@interface MYTopHelper : MYBasicSingleton

- (void)showTipsOnTop:(NSString *)text;

@end
