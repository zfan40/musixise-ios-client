//
//  BaseTableView.h
//  xiami
//
//  Created by go886 on 14-7-11.
//
//

#import <UIKit/UIKit.h>
@interface UITableView (viewmodel)
-(UITableViewCell*)cellForClass:(Class)cls style:(UITableViewCellStyle)style;
-(UITableViewCell*)cellForClass:(Class)cls style:(UITableViewCellStyle)style kIdentifier:(NSString*)identifier;
-(UITableViewCell*)cellForNibNamed:(NSString*)name kIdentifier:(NSString*)identifier;
@end


@class BaseViewModel;
@interface BaseTableView : UITableView
@property(nonatomic,strong)BaseViewModel* viewModel;
-(void)viewModelStateChanged;
-(void)viewModelDataChanged;
@end


