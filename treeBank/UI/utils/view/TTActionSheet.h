//
//  TTActionSheet.h
//  Pods
//
//  Created by kebi on 15/12/9.
//
//

#import <UIKit/UIKit.h>

typedef void (^TTActionSheetDismissBlock)(int buttonIndex);
typedef void (^TTActionSheetCancelBlock)();

@interface TTActionSheet : UIActionSheet
@property (nonatomic, copy) TTActionSheetDismissBlock dismissActionBlock;
@property (nonatomic, copy) TTActionSheetCancelBlock cancelActionBlock;

+ (void)showActionSheetWithTitle:(NSString *)title
                         subview:(UIView *)subview
               cancelButtonTitle:(NSString *)cancelButtonTitle
          destructiveButtonTitle:(NSString *)destructiveButtonTitle
               otherButtonTitles:(NSArray *)otherButtons
                       onDismiss:(TTActionSheetDismissBlock)dismissed
                        onCancel:(TTActionSheetCancelBlock)cancelled;

@end
