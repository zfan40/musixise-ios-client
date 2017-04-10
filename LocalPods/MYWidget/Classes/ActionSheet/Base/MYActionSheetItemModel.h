//
//  MYActionSheetItemModel.h
//  Pods
//
//  Created by wmy on 2017/3/20.
//
//

#import <Foundation/Foundation.h>
#import "MYActionSheetDelegate.h"

typedef void (^TouchBlock)(UIView *);

@interface MYActionSheetItemModel : NSObject <MYActionSheetItemModelProtocol>

@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) MYActionSheetItemTextAligement textAligement;
@property (nonatomic, strong) NSString *iconFontName;
@property (nonatomic, strong) UIColor *iconFontColor;
@property (nonatomic, strong) NSString *imageUrl;

@end
