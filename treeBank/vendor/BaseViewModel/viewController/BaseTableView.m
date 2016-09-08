//
//  BaseTableView.m
//  xiami
//
//  Created by go886 on 14-7-11.
//
//

#import "BaseTableView.h"
#import "BaseViewModel.h"

@implementation UITableView (viewmodel)
- (UITableViewCell *)cellForClass:(Class)cls style:(UITableViewCellStyle)style {
    return [self cellForClass:cls style:style kIdentifier:NSStringFromClass(cls)];
}
- (UITableViewCell *)cellForClass:(Class)cls style:(UITableViewCellStyle)style kIdentifier:(NSString *)identifier {
    if (!identifier)
        identifier = NSStringFromClass(cls);
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
        cell = [[cls alloc] initWithStyle:style reuseIdentifier:identifier];

    return cell;
}
- (UITableViewCell *)cellForNibNamed:(NSString *)name kIdentifier:(NSString *)identifier {
    if (!identifier)
        identifier = @"xiamicell";
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
        cell = [[[NSBundle mainBundle] loadNibNamed:name owner:self options:nil] objectAtIndex:0];
    return cell;
}
@end

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc {
    self.viewModel = nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)setViewModel:(BaseViewModel *)viewModel {
    if (_viewModel) {
        [_viewModel removeObserver:self forKeyPath:kStateKey];
        [_viewModel removeObserver:self forKeyPath:kDataKey];
        [_viewModel cancelLoad];
    }

    _viewModel = viewModel;
    if (_viewModel) {
        [_viewModel addObserver:self forKeyPath:kStateKey options:NSKeyValueObservingOptionNew context:nil];
        [_viewModel addObserver:self forKeyPath:kDataKey options:NSKeyValueObservingOptionNew context:nil];
        if (_viewModel.needLoad)
            [_viewModel load];
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (object == _viewModel) {
        if ([keyPath isEqualToString:kStateKey]) {
            [self viewModelStateChanged];
            return;
        } else if ([keyPath isEqualToString:kDataKey]) {
            [self viewModelDataChanged];
            return;
        }
    }

    return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (void)viewModelStateChanged {
    // [self reloadData];
}
- (void)viewModelDataChanged {
    [self reloadData];
}
@end
