//
//  UIAlertView+MKBlockAdditions.h
//  UIKitCategoryAdditions
//
//  Created by Mugunth on 21/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 cancel buttonIndex: -1
 other: [0,...]
*/
@interface UIAlertView (Block)
+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message;

+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                 cancelButtonTitle:(NSString *)cancelButtonTitle;

+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                 cancelButtonTitle:(NSString *)cancelButtonTitle
                 otherButtonTitles:(NSArray *)otherButtons;

- (void)showWithCompletion:(void (^)(NSInteger buttonIndex))block;
- (void)showWithSucceed:(void (^)(NSInteger buttonIndex))block;
- (void)showWithCancel:(void (^)())block;
- (void)showWithSucceed:(void (^)(NSInteger buttonIndex))block cancel:(void (^)())cancel;
- (NSInteger)showModal;
@end
