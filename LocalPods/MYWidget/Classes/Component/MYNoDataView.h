//
//  MYNoDataView.h
//  Pods
//
//  Created by wmy on 16/8/28.
//
//

#import <UIKit/UIKit.h>

@protocol MYNoDataViewDelegate <NSObject>

- (void)noDataViewDidClick;

@end


@interface MYNodataViewModel : NSObject

@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *desc;

@end

@interface MYNoDataView : UIView

@property (nonatomic,weak) id<MYNoDataViewDelegate> delegate;

+ (instancetype)noDataView;

- (void)setNoDataViewModel:(MYNodataViewModel *)noDataViewModel;

@end
