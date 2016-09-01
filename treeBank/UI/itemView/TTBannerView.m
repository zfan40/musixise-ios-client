//
//  XBannerScrollView.m
//  xiami
//
//  Created by kebi on 14-11-19.
//
//

#import "TTBannerView.h"
#import <UIKit/UIAccessibility.h>
#import "TTUIViewAdditons.h"



@implementation TTBannerItemView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.imageView = [UIImageView new];
        [self addSubview:self.imageView];
        self.isAccessibilityElement = YES;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

@end


@interface TTBannerView()<UIScrollViewDelegate>
@property(nonatomic, strong)UIScrollView* scrollView;
@property(nonatomic, strong)UIPageControl* pageControl;
@property(nonatomic, strong)NSMutableArray* visibleArrays;
@property(nonatomic, strong)NSMutableDictionary* stackDics;

@property(nonatomic, strong)NSTimer* timer;
@property(nonatomic, strong)NSDictionary* registerDic;
@end
@implementation TTBannerView{
    BOOL _isLoadingPage;
    NSInteger _currentPage;
    NSInteger _totalPages;
}

-(void)dealloc{
    self.scrollView = nil;
    self.visibleArrays = nil;
    self.pageControl = nil;
    self.registerDic = nil;
    self.stackDics = nil;
    if(self.timer){
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initSubViews];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self =[super initWithCoder:aDecoder];
    if(self){
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews{
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:self.scrollView];
    self.backgroundColor = [UIColor clearColor];
    self.scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator= NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollsToTop = NO;
    _scrollView.bounces = NO;
    _isLoadingPage = NO;
    self.stackDics =[NSMutableDictionary new];
    self.visibleArrays =[NSMutableArray new];
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectZero];
    [self addSubview:self.pageControl];
    self.pageControl.hidesForSinglePage = YES;
    self.showPageIndicator =YES;
    self.pageIndicatorDirection = TTBannerPageIndicatorDirection_CenterBottom;
    _time = 5.0;
    _scrollView.contentSize = CGSizeMake(self.bounds.size.width*3, self.bounds.size.height);
}

-(void)onAutoScrollView:(NSTimer*)timer{
    _isLoadingPage = NO;
    if([UIApplication sharedApplication].applicationState != UIApplicationStateActive ){
        return;
    }
    BOOL scrollView = NO;
    if(self.delegate&&[self.delegate respondsToSelector:@selector(autoScorllView)]){
        BOOL isAutoScrollView = [self.delegate autoScorllView];
        if(!isAutoScrollView){
            [self.timer invalidate];
            self.timer = nil;
        }else{
            scrollView = YES;
        }
    }
    if(scrollView){
        ++_currentPage;
        NSInteger totalPages = 1;
        if(self.delegate&&[self.delegate numberOfPages]){
            totalPages = [self.delegate numberOfPages];
        }
        if( 1==totalPages ){
            _currentPage = 0;
            if(self.timer){
                [self.timer invalidate];
                self.timer = nil;
            }
        }
        if(_currentPage>=totalPages ){
            _currentPage = 0;
        }
        if(1< totalPages){
            [self loadData:YES];
        }
    }
}
-(void)reloadData{
    [self pauseTimer];
    _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    [self setNeedsLayout];
    _currentPage = 0;
    NSInteger numberPages = 1;
    if(self.delegate&&[self.delegate respondsToSelector:@selector(numberOfPages)]){
        numberPages = [self.delegate numberOfPages];
        if( numberPages<=0 ){
            return;
        }
    }
    self.scrollView.scrollEnabled = numberPages>1;
    _totalPages = numberPages;
    self.pageControl.numberOfPages= numberPages;
    [self setPageControlFrameWithPageIndicatorDirecton:self.pageIndicatorDirection];
    [self startTimer];
    for(int index=0; index<_totalPages; ++index ){
        [_delegate bannerScrollView:self viewForPageAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    }
    
    [self loadData:NO];
}

-(void)registerClass:(Class)pageClass forPageViewReuseIdentifer:(NSString*)identifer{
    if(!pageClass || !(identifer)){
        NSAssert(nil, @"error");
        return;
    }
    
    if(!self.registerDic){
        self.registerDic = [NSMutableDictionary new];
    }
    [self.registerDic setValue:NSStringFromClass(pageClass) forKey:identifer];
}


-(id)dequeueReusePageViewWithIdentifer:(NSString*)identifer forIndexPath:(NSIndexPath*)indexPath{
    if( !(identifer)||!indexPath ){
        NSAssert(nil, @"error");
        return nil;
    }
    NSString *key = [NSString stringWithFormat:@"%d",indexPath.row];
    UIView* view =[self.stackDics objectForKey:key];
    NSAssert(self.registerDic&&[[self.registerDic allValues]count]>0, @"registerDic is nil");
    if(!view){
        NSString* class =[[self.registerDic allValues]lastObject];
        UIView* itemView = [ (Class)NSClassFromString(class) new];
        itemView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(onTap:)];
        [itemView addGestureRecognizer:singleTap];
        [self.stackDics setValue:itemView forKey:key];
        view = itemView;
        view.isAccessibilityElement = YES;
    }
    return view;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _scrollView.frame = self.bounds;
    [self setPageControlFrameWithPageIndicatorDirecton:self.pageIndicatorDirection];
    _scrollView.contentSize = CGSizeMake(self.width*3, self.height);
    [_visibleArrays enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = obj;
        view.frame = CGRectMake( idx*self.width, 0, self.width, self.height);
    }];
}

- (void)loadData:(BOOL)isShowAnimation{
    _pageControl.currentPage = _currentPage;
    [self getDisplayImagesWithCurpage:_currentPage];
    CGFloat height = self.scrollView.frame.size.height;
    for (int i = 0; i < [_visibleArrays count]; i++) {
        UIView *v = [_visibleArrays objectAtIndex:i];
        v.frame = CGRectMake( i*self.width, 0, self.width, height);
        [_scrollView addSubview:v];
        if (isShowAnimation) {
            CATransition *animation = [CATransition animation];
            animation.duration = 0.3f;
            animation.type = kCATransitionPush;
            animation.subtype = kCATransitionFromRight;
            [v.layer addAnimation:animation forKey:@"animationID"];
        }
    }
    if(_totalPages==1){
        [_scrollView setContentOffset:CGPointMake(0, 0)];
    }else{
        [_scrollView setContentOffset:CGPointMake(self.width, 0)];
    }
    if([self.delegate respondsToSelector:@selector(bannerViewDidAppear:)]){
        [self.delegate bannerViewDidAppear:[NSIndexPath indexPathForRow:_currentPage inSection:0]];
    }
}
- (void)getDisplayImagesWithCurpage:(NSInteger)page {
    NSInteger pre = [self validPageValue:_currentPage-1];
    NSInteger last = [self validPageValue:_currentPage+1];
    [_visibleArrays enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view= (UIView*)obj;
        [view removeFromSuperview];
    }];
    [_visibleArrays removeAllObjects];
    
    if (_delegate && [_delegate numberOfPages] > 0) {
        UIView *preView = [_delegate bannerScrollView:self viewForPageAtIndexPath:[NSIndexPath indexPathForRow:pre inSection:0]];
        UIView *curView = [_delegate bannerScrollView:self viewForPageAtIndexPath:[NSIndexPath indexPathForRow:page  inSection:0]];
        
        if( pre==last ){
            NSString *key = [NSString stringWithFormat:@"%d",pre];
            [self.stackDics removeObjectForKey:key];
        }
        UIView *lastView = [_delegate bannerScrollView:self viewForPageAtIndexPath:[NSIndexPath indexPathForRow:last inSection:0]];
        [_visibleArrays addObject:preView];
        if( ![_visibleArrays containsObject:curView]){
            [_visibleArrays addObject:curView];
        }
        if( ![_visibleArrays containsObject:lastView]){
            [_visibleArrays addObject:lastView];
        }
    }
}

- (NSInteger)validPageValue:(NSInteger)value {
    if(value == -1){
        value = _totalPages - 1;
    }
    if(value == _totalPages) {
        value = 0;
    }
    return value;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    if(self.timer){
        if ([self.timer isValid]&&(!_isLoadingPage||aScrollView.isDragging||aScrollView.isTracking)){
            [self.timer invalidate];
            self.timer = nil;
        }
    }
    
    int x = aScrollView.contentOffset.x;
    
    if(x >= (2*self.frame.size.width)) {
        _currentPage =[self validPageValue:_currentPage+1];
        [self loadData:NO];
    }
    if(x <= 0) {
        _currentPage =[self validPageValue:_currentPage-1];
        [self loadData:NO];
    }
    _isLoadingPage = NO;
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    _isLoadingPage = YES;
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(onAutoScrollView:) userInfo:nil repeats:YES];
    
}

-(void)scrollToNextPage{
    _currentPage =[self validPageValue:_currentPage+1];
    [self loadData:NO];
}

-(void)onTap:(UITapGestureRecognizer*)tapGesture{
    if(self.delegate&&[self.delegate respondsToSelector:@selector(bannerScrollView:didSeclectAtIndexPath:)]){
        [self.delegate bannerScrollView:self didSeclectAtIndexPath:[NSIndexPath indexPathForRow:_currentPage inSection:0]];
    }
}

-(void)setTime:(NSTimeInterval)time{
    if( time<1.0 ){
        return;
    }
    _time = time;
}

- (void)pauseTimer{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)startTimer{
    _isLoadingPage = NO;
    if(1>=_totalPages){
        if(self.timer){
            [self.timer invalidate];
            self.timer = nil;
        }
        return;
    }
    if(self.delegate&&[self.delegate respondsToSelector:@selector(autoScorllView)]){
        BOOL autoScrollView = [self.delegate autoScorllView];
        if(autoScrollView){
            if (!self.timer) {
                self.timer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(onAutoScrollView:) userInfo:nil repeats:YES];
            }
        }
    }
}



-(void)setPageControlFrameWithPageIndicatorDirecton:(TTBannerPageIndicatorDirection)direction{
    CGRect ct = self.scrollView.frame;
    CGFloat y = ct.size.height - 25;
    CGFloat heigth = 30;
    CGRect pageFrame = CGRectZero;
    switch (direction) {
        case TTBannerPageIndicatorDirection_LeftBottom:
            pageFrame = CGRectMake(0, y, ct.size.width/2, heigth);
            break;
        case TTBannerPageIndicatorDirection_CenterBottom:
            pageFrame = CGRectMake(0, y, ct.size.width, heigth);
            break;
        case TTBannerPageIndicatorDirection_RightBottom:
            pageFrame = CGRectMake(ct.size.width/2, y, ct.size.width/2, heigth);
            break;
        default:
            NSAssert(nil, @"error");
            break;
    }
    self.pageControl.frame = pageFrame;
}



@end



