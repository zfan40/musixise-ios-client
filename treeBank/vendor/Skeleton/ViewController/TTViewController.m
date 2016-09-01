//
//  TTViewController.m
//  Pods
//
//  Created by guanshanliu on 11/20/15.
//
//

#import "TTViewController.h"
#import "NSObject+TTRouter.h"
#import "UIBarButtonItem+TTConvenientCreator.h"
#import "TTNavigator.h"
#import <libextobjc/EXTScope.h>
#import "TTRouter.h"
#import "TTUtility.h"

const CGFloat TTViewControllerNavigationBarHeight = 64;

@interface TTViewController () {
    BOOL _hidesNavigationBarWhenLoaded;
}

@property (nonatomic, assign) BOOL viewWillAppearIsCalledBefore;
@property (nonatomic, assign) BOOL viewDidAppearIsCalledBefore;
@property (nonatomic, strong) UIImageView *theImageViewBehideOtherViews;
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UIBarButtonItem *playerItem;
@property (nonatomic, strong) UIBarButtonItem *rightNegativeSpacer;

@property (nonatomic, copy) NSString *pageName;

@end

@implementation TTViewController

@synthesize shouldHideNavigationBar = _shouldHideNavigationBar;
@synthesize customNavigationBar = _customNavigationBar;
@synthesize rightBarButtonItems = _rightBarButtonItems;
@synthesize navigationBarLeftButtonStyle = _navigationBarLeftButtonStyle;
@synthesize navigationBarTitleViewStyle = _navigationBarTitleViewStyle;
@synthesize navigationBarRightButtonStyle = _navigationBarRightButtonStyle;
@synthesize bShowRedPoint = _bShowRedPoint;
@synthesize searchBarWidth = _searchBarWidth;
@dynamic rightBarButtonItem;
@synthesize customBackGesture;
- (void)viewDidLoad {
    [super viewDidLoad];
//
//    self.theImageViewBehideOtherViews = ({
//        UIImageView *imageView = [UIImageView new];
//        imageView.image = self.shouldHideBackgroundImage ? nil : [UIImage imageNamed:@"view-background.jpg"];
//        imageView.frame = self.view.bounds;
//        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        [self.view insertSubview:imageView atIndex:0];
//        imageView;
//    });
    self.view.backgroundColor = RGB(0, 0, 0);//nav bar
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setNeedsStatusBarAppearanceUpdate];
    self.navigationBarLeftButtonStyle = NavigationBarLeftButtonStyleBack;
    self.navigationBarRightButtonStyle = NavigationBarRightButtonStyleMore | NavigationBarRightButtonStylePlayer;
    
    
    _hidesNavigationBarWhenLoaded = self.shouldHideNavigationBar;
    
    if (!_hidesNavigationBarWhenLoaded) {
        [self setupCustomNavigationBar];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!self.viewWillAppearIsCalledBefore) {
        self.viewWillAppearIsCalledBefore = YES;
        [self viewWillFirstAppear];
    }
}

- (void)viewWillFirstAppear {
    if (!_hidesNavigationBarWhenLoaded) {
        [self adjustScrollViewContentInsets];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!self.viewDidAppearIsCalledBefore) {
        self.viewDidAppearIsCalledBefore = YES;
        [self viewDidFirstAppear];
    }
}

- (void)viewDidFirstAppear{
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
//    if (!self.shouldHideNavigationBar) {
//        CGSize size = self.view.bounds.size;
//        self.customNavigationBar.frame = CGRectMake(0, 0, size.width, TTViewControllerNavigationBarHeight);
//        [self.view bringSubviewToFront:self.customNavigationBar];
//    }
}



- (UINavigationController *)navigationController {
    UINavigationController *navigationController = [super navigationController];
    if (navigationController) {
        return navigationController;
    }

    return [TTNavigator sharedInstance].navigationController;
}

#pragma mark - Navigation bar
- (void)setNavigationBarLeftButtonStyle:(NavigationBarLeftButtonStyle)navigationBarLeftButtonStyle {
    _navigationBarLeftButtonStyle = navigationBarLeftButtonStyle;
}

- (void)setNavigationBarTitleViewStyle:(NavigationBarTitleViewStyle)navigationBarTitleViewStyle {
    _navigationBarTitleViewStyle = navigationBarTitleViewStyle;
}

- (void)setNavigationBarRightButtonStyle:(NavigationBarRightButtonStyle)navigationBarRightButtonStyle {
    _navigationBarRightButtonStyle = navigationBarRightButtonStyle;
}

- (void)setSearchBarWidth:(CGFloat)searchBarWidth {
    _searchBarWidth = searchBarWidth;
    
    if (self.searchView) {
        CGRect rect = self.searchView.frame;
        rect.size.width = searchBarWidth;
        self.searchView.frame = rect;
//        self.customNavigationBar.navigationItem.titleView = self.searchView;
    }
}

- (UIBarButtonItem *)rightBarButtonItem {
    return self.rightBarButtonItems.firstObject;
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem {
    if (rightBarButtonItem) {
        self.rightBarButtonItems = @[rightBarButtonItem];
    } else {
        self.rightBarButtonItems = nil;
    }
}

- (UINavigationItem *)navigationItem {
    if (self.customNavigationBar.navigationItem) {
         return self.customNavigationBar.navigationItem;
    }else{
        return [super navigationItem];
    }
}

- (void)setTitle:(NSString *)title {
//    self.navigationItem.title = title;
    self.customNavigationBar.titleLabel.text = title;
//    self.customNavigationBar.titleLabel.width = [self.customNavigationBar.titleLabel
//                                                 sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width, 44)].width;
}

- (void)setupCustomNavigationBar {
    CGSize size = self.view.bounds.size;
    self.customNavigationBar = [[TTNavigationBar alloc] initWithFrame:CGRectMake(0, 0, size.width, TTViewControllerNavigationBarHeight)];
//    self.customNavigationBar.barTintColor = [UIColor colorWithRed:0 green:0 blue:255 alpha:0.6];
    
    [self setupLeftItem:self.customNavigationBar];
    __weak TTViewController *weak = self;
    [self.customNavigationBar.backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:self.customNavigationBar];
}


- (void)setupLeftItem:(TTNavigationBar *)navigationBar {
    navigationBar.navigationItem.leftBarButtonItem = nil;
    navigationBar.navigationItem.leftBarButtonItems = nil;
    
    if (self.navigationBarLeftButtonStyle == NavigationBarLeftButtonStyleSearch) {
    } else if (self.navigationBarLeftButtonStyle == NavigationBarLeftButtonStyleBack) {
        [self showBackItem];
    } else if (self.navigationBarLeftButtonStyle == NavigationBarLeftButtonStyleClose) {
        [self showCloseItem];
    }
}

- (void)showBackItem {
    UIBarButtonItem *backItem = [self backItem];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -15;
    self.customNavigationBar.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, backItem, nil];
}

- (void)showCloseItem {
    UIBarButtonItem *closeItem = [self closeItem];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -15;
    self.customNavigationBar.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, closeItem, nil];
}

- (void)setupTitleView:(TTNavigationBar *)navigationBar {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    navigationBar.navigationItem.titleView = titleLabel;
}


- (void)setRightBarButtonItems:(NSArray<UIBarButtonItem *> *)rightBarButtonItems {
    BOOL bothNil = !_rightBarButtonItems && !rightBarButtonItems;
    if (bothNil || [_rightBarButtonItems isEqualToArray:rightBarButtonItems]) {
        return;
    }
    _rightBarButtonItems = rightBarButtonItems.copy;
    
    NSMutableArray *rightItems = [NSMutableArray arrayWithObject:self.rightNegativeSpacer];
    if (self.navigationBarRightButtonStyle & NavigationBarRightButtonStylePlayer) {
        [rightItems addObject:self.playerItem];
    }
    [rightItems addObjectsFromArray:rightBarButtonItems];
    self.customNavigationBar.navigationItem.rightBarButtonItems = rightItems;
}

- (UIBarButtonItem *)rightNegativeSpacer {
    if (!_rightNegativeSpacer) {
        _rightNegativeSpacer = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                target:nil action:nil];
        _rightNegativeSpacer.width = -10;
    }
    return _rightNegativeSpacer;
}

#pragma mark - Go back

- (BOOL)canDismissWithGesture {
    return YES;
}

- (UIBarButtonItem *)backItem {
    UIBarButtonItem * item =[UIBarButtonItem tt_backBarButtonItemWithTarget:self action:@selector(goBack:)];
#ifdef DEBUG
    if (item) {
        return item;
    }
    return [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
#endif
    return item;

}

- (UIBarButtonItem *)closeItem {
    UIBarButtonItem * item =[UIBarButtonItem tt_closeBarButtonItemWithTarget:self action:@selector(goBack:)];
#ifdef DEBUG
    if (item) {
        return item;
    }
    return [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
#endif
    return item;
    
}


- (void)goBack:(id)sender {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - TTRouting

//- (void)route:(NSString *)urlString withParam:(NSDictionary *)param {
//    [super route:urlString withParam:param fromViewController:self];
//}

#pragma mark - Rotation

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - Status bar

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Miscs

- (void)setShouldHideBackgroundImage:(BOOL)shouldHideBackgroundImage {
    if (_shouldHideBackgroundImage == shouldHideBackgroundImage) {
        return;
    }

    _shouldHideBackgroundImage = shouldHideBackgroundImage;
    self.theImageViewBehideOtherViews.image = _shouldHideBackgroundImage ? nil : [UIImage imageNamed:@"view-background.jpg"];
}

- (TTViewControllerPresentStyle)presentStyle {
    return TTViewControllerPresentStylePush;
}

-(void)adjustScrollViewContentInsets {
    if (!self.automaticallyAdjustsScrollViewInsets) {
        return;
    }
    
    if ([self.view isKindOfClass:[UIScrollView class]]) {
        [self adjustContentInsetsForScrollView:(UIScrollView *)self.view];
        return;
    }
    
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[UIScrollView class]] && CGSizeEqualToSize(self.view.bounds.size, subView.frame.size)) {
            [self adjustContentInsetsForScrollView:(UIScrollView *)subView];
            break;
        }
    }
}

- (void)adjustContentInsetsForScrollView:(UIScrollView *)scrollView {
    UIEdgeInsets insets = scrollView.contentInset;
    insets.top = TTViewControllerNavigationBarHeight;
    scrollView.contentInset = insets;
    scrollView.scrollIndicatorInsets = insets;
    scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, -insets.top);
}


@end
