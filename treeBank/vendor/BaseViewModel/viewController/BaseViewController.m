//
//  BaseViewController.m
//  xiami
//
//  Created by go886 on 14-6-19.
//
//

#import "BaseViewController.h"
#import "BaseViewModel.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
    self.viewModel = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.viewModel && MS_FAILED == self.viewModel.state)
        [self.viewModel load];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setViewModel:(BaseViewModel *)viewModel {
    if (_viewModel) {
        [_viewModel removeObserver:self forKeyPath:kStateKey];
        [_viewModel removeObserver:self forKeyPath:kDataKey];
        [_viewModel cancelLoad];
    }

    _viewModel = viewModel;
    if (_viewModel) {
        [_viewModel addObserver:self forKeyPath:kStateKey options:NSKeyValueObservingOptionNew context:nil];
        [_viewModel addObserver:self forKeyPath:kDataKey options:NSKeyValueObservingOptionNew context:nil];
        if (_viewModel.needLoad) [_viewModel load];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == _viewModel) {
        if ([keyPath isEqualToString:kStateKey]) {
            [self viewModelStateChanged];
            return;
        }else if([keyPath isEqualToString:kDataKey]) {
            [self viewModelDataChanged];
            return;
        }
    }
    
    return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

-(void)viewModelStateChanged {
    /*
    const MODESTATE st = _viewModel.state;
    switch (st) {
        case MS_INIT:
            break;
        case MS_LOADING:
            [self viewModelLoading];
            break;
        case MS_FINISHED:
            [self viewModelLoadFinished:TRUE];
            break;
        case MS_FAILED:
            [self viewModelLoadFinished:FALSE];
            break;
        default:
            break;
    }*/
}
-(void)viewModelDataChanged {
    if (self.view && [self.view isKindOfClass:[UITableView class]]) {
        [(UITableView*)self.view reloadData];
    }
}

@end
