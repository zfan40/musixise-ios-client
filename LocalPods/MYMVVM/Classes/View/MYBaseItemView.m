//
//  MYBaseItemView.m
//  xiaplay
//
//  Created by wmy on 15/11/25.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBaseItemView.h"
#import "MYBaseViewModel.h"
#import <MYWidget/MYWidget.h>


@interface MYBaseItemView ()


@end

@implementation MYBaseItemView

#pragma mark - --------------------退出清空------------------

- (void)dealloc {
    self.viewModel = nil;
    [_viewModel removeObserver:self forKeyPath:kStateKey];
    [_viewModel removeObserver:self forKeyPath:kDataKey];
    
}

#pragma mark - --------------------初始化--------------------

- (instancetype)init {
    if (self = [super init]) {
        self.autoUpdate = YES;
    }
    return self;
}

- (instancetype)initWithItemStyle:(MYBaseItemViewStyle)style viewModel:(id)viewModel {
    if (self = [self init]) {
        self.style = style;
        self.viewModel = viewModel;
    }
    return self;
}

- (void)registNotification {

}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (id)valueForUndefinedKey:(NSString *)key {
    if ([key isEqualToString:kDataKey] || [key isEqualToString:kStateKey]) {
        return nil;
    } else {
#if DEBUG
        return [super valueForUndefinedKey:key];
#endif
        return nil;
    }
}

#pragma mark - --------------------功能函数------------------


+ (CGFloat)heightForViewModel:(NSIndexPath *)indexPath {
    
    return 75;
}

- (void)viewModelDataChanged {
    
}

- (void)viewModelStateChanged {
    [self setNeedsLayout];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (void)setStyle:(MYBaseItemViewStyle)style {
    _style = style;
    if (style == MYBaseItemViewStyleNOTitleBackground) {
        self.cornerRadius = 0;
    } else {
        self.backgroundColor = theMYWidget.itemViewColor;
        self.cornerRadius = 10;
    }
}

- (void)setViewModel:(MYBaseViewModel *)viewModel {
    if (viewModel != nil && [viewModel isKindOfClass:[MYBaseViewModel class]] == NO) {
        viewModel = nil;
        NSString *errorReason = [NSString stringWithFormat:@"viewModel is wrong type:%@",NSStringFromClass([viewModel class])];
        NSAssert(NO, errorReason);
    }
    if ((viewModel != _viewModel) &&self.autoUpdate) {
        if (_viewModel) {
            [_viewModel removeObserver:self forKeyPath:kStateKey];
            [_viewModel removeObserver:self forKeyPath:kDataKey];
        }
        _viewModel = viewModel;
        if (_viewModel) {
            [_viewModel addObserver:self forKeyPath:kStateKey options:NSKeyValueObservingOptionNew context:nil];
            [_viewModel addObserver:self forKeyPath:kDataKey options:NSKeyValueObservingOptionNew context:nil];
        }
        
        if(_viewModel){
            [self viewModelDataChanged];
            [self setNeedsLayout];
        }
    }else if(viewModel != _viewModel){
        _viewModel = viewModel;
        if(_viewModel) {
            [self viewModelDataChanged];
            [self setNeedsLayout];
        }
    }
    else{
        /*!
         *    @Author pengyutang, 15-01-30
         *
         *    @brief  加这段代码是为了解决首页卡片显示Gif图的时候，view出去了，回来动画就失效了的Bug
         */
        if (_viewModel) {
            [self viewModelDataChanged];
            [self setNeedsLayout];
        }
    }

}

/**
 *  处理model key的回调
 *  @param viewModel
 */
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (object == _viewModel) {
        if ([keyPath isEqualToString:kStateKey]) {
            if (![NSThread isMainThread]) {
                [self performSelectorOnMainThread:@selector(viewModelStateChanged) withObject:nil waitUntilDone:NO];
            } else {
                [self viewModelStateChanged];
            }
            return;
        } else if ([keyPath isEqualToString:kDataKey]) {
            if (![NSThread isMainThread]) {
                [self performSelectorOnMainThread:@selector(viewModelDataChanged) withObject:nil waitUntilDone:NO];
            } else {
                [self viewModelDataChanged];
            }
            return;
        }
    }
    
    return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

@end
