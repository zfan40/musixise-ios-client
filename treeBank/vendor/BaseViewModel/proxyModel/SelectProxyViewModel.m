//
//  SelectProxyViewModel.m
//  xiami
//
//  Created by go886 on 14-7-15.
//
//

#import "SelectProxyViewModel.h"

@implementation SelectProxyViewModel
- (instancetype)initWithViewModels:(NSArray *)models {
    NSAssert(models, @"models is null");
    NSAssert(models.count, @"models is empty");
    self = [super initWithViewModel:models[0]];
    if (self) {
        _models = [models copy];
    }
    return self;
}
- (void)dealloc {
    self.srcViewModel = nil;
    for (BaseViewModel *model in _models) {
        @try {
            [model removeObserver:self forKeyPath:kStateKey context:nil];
            [model removeObserver:self forKeyPath:kDataKey context:nil];
        } @catch (NSException *exception) {

        } @finally {
        }
    }
}
- (void)setSrcViewModel:(BaseViewModel *)viewModel {
    [super setSrcViewModel:viewModel];
    if (self.enabledAllModelChanged && viewModel) {
        for (BaseViewModel *model in _models) {
            @try {
                [model removeObserver:self forKeyPath:kStateKey context:nil];
                [model removeObserver:self forKeyPath:kDataKey context:nil];
            } @catch (NSException *exception) {

            } @finally {
            }

            [model addObserver:self forKeyPath:kStateKey options:NSKeyValueObservingOptionNew context:nil];
            [model addObserver:self forKeyPath:kDataKey options:NSKeyValueObservingOptionNew context:nil];
        }
    }
}

- (void)setEnabledAllModelChanged:(BOOL)enabledAllModelChanged {
    _enabledAllModelChanged = enabledAllModelChanged;
    if (enabledAllModelChanged) {
        for (BaseViewModel *model in _models) {
            @try {
                [model removeObserver:self forKeyPath:kStateKey context:nil];
                [model removeObserver:self forKeyPath:kDataKey context:nil];
            } @catch (NSException *exception) {

            } @finally {
            }

            [model addObserver:self forKeyPath:kStateKey options:NSKeyValueObservingOptionNew context:nil];
            [model addObserver:self forKeyPath:kDataKey options:NSKeyValueObservingOptionNew context:nil];
        }
    } else {
        for (BaseViewModel *model in _models) {
            @try {
                [model removeObserver:self forKeyPath:kStateKey context:nil];
                [model removeObserver:self forKeyPath:kDataKey context:nil];
            } @catch (NSException *exception) {

            } @finally {
            }

            if (model == self.srcViewModel) {
                [model addObserver:self forKeyPath:kStateKey options:NSKeyValueObservingOptionNew context:nil];
                [model addObserver:self forKeyPath:kDataKey options:NSKeyValueObservingOptionNew context:nil];
            }
        }
    }
}
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    NSInteger cnt = _models ? _models.count : 0;
    if (_selectedIndex != selectedIndex && selectedIndex < cnt) {
        BaseViewModel *viewModel = _models[selectedIndex];
        NSAssert([viewModel isKindOfClass:[BaseViewModel class]], @"not viewModel class");
        [self setSrcViewModel:viewModel];
        _selectedIndex = selectedIndex;

        if (viewModel.needLoad) {
            [viewModel load];
        } else {
            [self viewModelDataChanged];
            [self viewModelStateChanged];
        }
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (self.enabledAllModelChanged && [object isKindOfClass:[BaseViewModel class]]) {
        if ([keyPath isEqualToString:kStateKey]) {
            [super viewModelStateChanged];
            return;
        } else if ([keyPath isEqualToString:kDataKey]) {
            [super viewModelDataChanged];
            return;
        }
    }

    return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}
@end
