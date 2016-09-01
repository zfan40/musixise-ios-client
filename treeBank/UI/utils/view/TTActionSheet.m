//
//  TTActionSheet.m
//  Pods
//
//  Created by kebi on 15/12/9.
//
//

#import "TTActionSheet.h"
#import <objc/runtime.h>


static char kTTActionSheetDISMISS_IDENTIFER;
static char kTTActionSheetCANCEL_IDENTIFER;
static char kTTActionSheetBUTTONINDEX_IDENTIFER;

@interface TTActionSheet ()<UIActionSheetDelegate>

@end

@implementation TTActionSheet
@dynamic dismissActionBlock;
@dynamic cancelActionBlock;


- (void)setDismissActionBlock:(TTActionSheetDismissBlock)dismissBlock
{
    objc_setAssociatedObject(self, &kTTActionSheetDISMISS_IDENTIFER, dismissBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (TTActionSheetDismissBlock)dismissActionBlock
{
    return objc_getAssociatedObject(self, &kTTActionSheetDISMISS_IDENTIFER);
}

- (void)setCancelActionBlock:(TTActionSheetCancelBlock)cancelBlock
{
    objc_setAssociatedObject(self, &kTTActionSheetCANCEL_IDENTIFER, cancelBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (TTActionSheetCancelBlock)cancelActionBlock
{
    return objc_getAssociatedObject(self, &kTTActionSheetCANCEL_IDENTIFER);
}

- (NSInteger) returnButtonIndex{
    return [(NSNumber*)objc_getAssociatedObject(self, &kTTActionSheetBUTTONINDEX_IDENTIFER) integerValue];
}
-(void) setReturnButtonIndex:(NSInteger) returnButtonIndex{
    objc_setAssociatedObject(self, &kTTActionSheetBUTTONINDEX_IDENTIFER, [NSNumber numberWithInteger:returnButtonIndex], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == [actionSheet cancelButtonIndex])
    {
        if (((TTActionSheet*)actionSheet).cancelActionBlock) {
            ((TTActionSheet*)actionSheet).cancelActionBlock();
        }
    }
    else
    {
        if (((TTActionSheet*)actionSheet).dismissActionBlock) {
            ((TTActionSheet*)actionSheet).dismissActionBlock((int)buttonIndex - 1); // cancel button is button 0
        }
    }
}
+(TTActionSheet*)actionSheetWithTitle:(NSString *)title
                              subview:(UIView *)subview
                    cancelButtonTitle:(NSString *)cancelButtonTitle
               destructiveButtonTitle:(NSString *)destructiveButtonTitle
                    otherButtonTitles:(NSArray *)otherButtons
                            onDismiss:(TTActionSheetDismissBlock)dismissed
                             onCancel:(TTActionSheetCancelBlock)cancelled
{
    TTActionSheet *alert = [[TTActionSheet alloc] initWithTitle:title
                                                       delegate:(id)self
                                              cancelButtonTitle:cancelButtonTitle
                                         destructiveButtonTitle: destructiveButtonTitle
                                              otherButtonTitles:nil];
    
    [alert setDismissActionBlock:dismissed];
    [alert setDismissActionBlock:cancelled];
    
    for(NSString *buttonTitle in otherButtons)
        [alert addButtonWithTitle:buttonTitle];
    if(subview)
        [alert addSubview:subview];
    return alert;
}

#pragma mark - -------------action sheet delegate---------------------
+(void)showActionSheetWithTitle:(NSString*) title
                        subview:(UIView*)subview
              cancelButtonTitle:(NSString*) cancelButtonTitle
         destructiveButtonTitle: (NSString*)destructiveButtonTitle
              otherButtonTitles:(NSArray*) otherButtons
                      onDismiss:(TTActionSheetDismissBlock) dismissed
                       onCancel:(TTActionSheetCancelBlock) cancelled {
    if(NSClassFromString(@"UIAlertController")){
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:title
                                                                             message:@""
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
        if(cancelButtonTitle){
            UIAlertAction* cancle = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction* action){
                cancelled();
                [actionSheet dismissViewControllerAnimated:YES completion:nil];
            }];
            [actionSheet addAction:cancle];
        }
        NSInteger index =0;
        for( NSString*text in otherButtons ){
            UIAlertAction* action = [UIAlertAction actionWithTitle:text style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
                dismissed(index);
                [actionSheet dismissViewControllerAnimated:YES completion:nil];
            }];
            index++;
            [actionSheet addAction:action];
        }
        
        if(destructiveButtonTitle){
            UIAlertAction* confirm = [UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
                dismissed(kTTActionSheetBUTTONINDEX_IDENTIFER);
                [actionSheet dismissViewControllerAnimated:YES completion:nil];
            }];
            [actionSheet addAction:confirm];
        }
        
        UIViewController *viewcontroller = [UIApplication sharedApplication].delegate.window.rootViewController;
        [viewcontroller   presentViewController:actionSheet animated:YES completion:nil];
        return;
    }else{
        TTActionSheet* alert = [ TTActionSheet actionSheetWithTitle:title subview:subview cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtons onDismiss:dismissed onCancel:cancelled];
        
        UIWindow* window = [[UIApplication sharedApplication] keyWindow];
        if ([window.subviews containsObject:subview]) {
            [alert showInView:subview];
        } else {
            [alert showInView:window];
        }
    }
}




@end