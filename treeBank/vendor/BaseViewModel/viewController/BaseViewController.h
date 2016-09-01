//
//  BaseViewController.h
//  xiami
//
//  Created by go886 on 14-6-19.
//
//

#import <UIKit/UIKit.h>
@class BaseViewModel;
@interface BaseViewController : UIViewController
@property(nonatomic,strong) BaseViewModel* viewModel;

-(void)viewModelStateChanged;
-(void)viewModelDataChanged;
@end
