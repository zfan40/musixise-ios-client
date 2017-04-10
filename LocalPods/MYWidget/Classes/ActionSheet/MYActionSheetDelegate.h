//
//  MYActionSheetDelegate.h
//  Pods
//
//  Created by wmy on 2017/3/20.
//
//

#ifndef MYActionSheetDelegate_h
#define MYActionSheetDelegate_h

@class MYActionSheet;

@protocol MYActionSheetDelegate <NSObject>

@optional;

/**
 点击某个item时的callback

 @param actionSheet actionSheet
 @param index 当index = -1 时，为点击cancel
 */
- (void)actionSheet:(MYActionSheet *)actionSheet DidClickWithIndex:(NSInteger)index;

- (void)willPresentActionSheet:(MYActionSheet *)actionSheet;

- (void)didPresentActionSheet:(MYActionSheet *)actionSheet;

- (void)willDismissActionSheet:(MYActionSheet *)actionSheet;

- (void)didDismissActionSheet:(MYActionSheet *)actionSheet;

@end

typedef enum {
    MYActionSheetItemTextAligement_Left = 1,
    MYActionSheetItemTextAligement_Center = 2,
    //MYActionSheetItemTextAligement_Right = 3,
} MYActionSheetItemTextAligement;


@protocol MYActionSheetItemModelProtocol <NSObject>

@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) MYActionSheetItemTextAligement textAligement;

@optional;

@property (nonatomic, strong) NSString *iconFontName;
@property (nonatomic, strong) UIColor *iconFontColor;
@property (nonatomic, strong) NSString *imageUrl;

@end

@protocol MYActionSheetTitleViewProtocol <NSObject>// 标志protocol

- (void)setTitle:(NSString *)title;

@optional;

- (void)setSubTitle:(NSString *)subTitle;

@end

@protocol MYActionSheetContentViewProtocol <NSObject>// 标志protocol



@end

@protocol MYActionSheetBottomViewProtocol <NSObject>// 标志protocol

- (void)setTitle:(NSString *)title;

@end


#endif /* MYActionSheetDelegate_h */
