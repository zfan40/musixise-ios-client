//
//  UIAlertView+MKBlockAdditions.m
//  UIKitCategoryAdditions
//
//  Created by Mugunth on 21/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIAlertView+MKBlockAdditions.h"
#import <objc/runtime.h>

static char COMPLETE_BLOCK;
@implementation UIAlertView (Block)
+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                 cancelButtonTitle:(NSString *)cancelButtonTitle
                 otherButtonTitles:(NSArray *)otherButtons {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:nil];

    for (NSString *buttonTitle in otherButtons)
        [alert addButtonWithTitle:buttonTitle];

    return alert;
}

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message {

    return [UIAlertView alertViewWithTitle:title message:message cancelButtonTitle:NSLocalizedString(@"Dismiss", @"")];
}

+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                 cancelButtonTitle:(NSString *)cancelButtonTitle {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:nil];
    return alert;
}

+ (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    typedef void (^CompleteBlock)(NSInteger buttonIndex);
    CompleteBlock block = objc_getAssociatedObject(alertView, &COMPLETE_BLOCK);
    if (block) {
        objc_setAssociatedObject(self, &COMPLETE_BLOCK, nil, OBJC_ASSOCIATION_COPY);
        if (-1 != alertView.cancelButtonIndex) {
            buttonIndex--;
        }
        block(buttonIndex);
    }
}

- (void)showWithCompletion:(void (^)(NSInteger))complete {
    if (complete) {
        objc_setAssociatedObject(self, &COMPLETE_BLOCK, complete, OBJC_ASSOCIATION_COPY);
        self.delegate = [self class];
    }

    [self show];
}

- (void)showWithSucceed:(void (^)(NSInteger buttonIndex))block {
    [self showWithSucceed:block cancel:nil];
}

- (void)showWithCancel:(void (^)())block {
    [self showWithSucceed:nil cancel:block];
}
- (void)showWithSucceed:(void (^)(NSInteger buttonIndex))block cancel:(void (^)())cancel {
    [self showWithCompletion:^(NSInteger buttonIndex) {
        if (-1 == buttonIndex) {
            if (cancel)
                cancel();
        } else {
            if (block)
                block(buttonIndex);
        }
    }];
}

- (NSInteger)showModal {
    @try {
        NSInteger tag = self.tag;
        id oldDelegate = self.delegate;
        self.tag = -1;
        self.delegate = self;
        [self show];
        CFRunLoopRun();
        NSInteger result = self.tag;
        self.tag = tag;
        self.delegate = oldDelegate;

        if (-1 != self.cancelButtonIndex) {
            result--;
        }
        return result;
    } @catch (NSException *exception) {
        return -1;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    alertView.tag = buttonIndex;
    CFRunLoopStop(CFRunLoopGetCurrent());
}
@end
