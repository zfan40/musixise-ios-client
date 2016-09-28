//
//  MYTextView.m
//  Pods
//
//  Created by wmy on 16/4/1.
//
//

#import "MYEamilTextView.h"
#import <MYWidget/UILabel+MYStyle.h>
#import <MYUtils/MYSafeUtil.h>
#import <MYWidget/UITextView+MYStyle.h>

#define kMYTextViewTableViewCellHeight 50

@interface MYEamilTextView () <UITableViewDelegate,UITableViewDataSource>

// 选项
@property (nonatomic,strong) UITableView *tableView;


@property (nonatomic,strong) NSArray *emailArray;

@property (nonatomic, strong) NSMutableArray *dataArray;

/**
 *  @之前的邮箱地址
 */
@property (nonatomic, strong) NSString *textBefore;

@end

@implementation MYEamilTextView

#pragma mark - --------------------退出清空------------------

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

#pragma mark - --------------------初始化--------------------

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    [self registNotification];
    [self addSubview:self.tableView];
}

- (void)registNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChange) name:UITextViewTextDidChangeNotification object:nil];
}
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.width = self.width;
}

#pragma mark - --------------------功能函数------------------


- (void)textViewChange {
    self.placeholderLabel.hidden = !isEmptyString(self.textView.text);
    NSRange range = [self.textView.text rangeOfString:@"@"];
    if (range.length > 0 && range.length < self.textView.text.length) {
//        self.isShowComplete = YES;
        self.textBefore = [self.textView.text substringToIndex:range.location];
        NSString *emailStr = [self.textView.text substringFromIndex:range.location + 1];
        for (NSString *email in self.emailArray) {
            if (![email hasPrefix:emailStr] && !isEmptyString(emailStr)) {
                [self.dataArray removeObject:email];
            } else if (![self.dataArray containsObject:email]) {
                [self.dataArray addObject:email];
            }
        }
//        self.isShowComplete = (self.dataArray.count != 0);
//        self.tableView.height = 3 * kEmailTextTableViewHeight;
        [self.tableView reloadData];
    } else {
//        self.isShowComplete = NO;
    }
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MYTextViewUITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MYTextViewUITableViewCell"];
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, kMYTextViewTableViewCellHeight)];
        
        UILabel *label = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f2_a80 withTextAligment:NSTextAlignmentLeft];
        label.text = [self.emailArray objectAtIndex:indexPath.row];
        [contentView addSubview:label];
        
        label.left = theMYWidget.m4;
        label.centerY = kMYTextViewTableViewCellHeight * 0.5;
        
        [cell.contentView addSubview:contentView];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kMYTextViewTableViewCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - --------------------属性相关------------------

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSArray *)emailArray {
    if (!_emailArray) {
        _emailArray = @[
                        @"163.com",
                        @"qq.com",
                        @"gmail.com",
                        @"126.com",
                        @"sina.com",
                        @"sina.cn",
                        @"hotmail.com",
                        @"shou.com",
                        @"139.com",
                        @"189.com"
                        ];
    }
    return _emailArray;
}



- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = theMYWidget.backgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


@end
