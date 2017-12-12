//
//  PopupView.m
//  PopupView
//
//  Created by Zhao Fei on 2016/10/12.
//  Copyright © 2016年 ZhaoFei. All rights reserved.
//

#import "PopupView.h"
#import "PopupTableViewCell.h"

static CGFloat devicePadding = 20.0f;
static CGFloat popupViewWidth = 85.0f;
static CGFloat popupViewpadding = 8.0f;
static CGFloat Trianglewidth = 5;
static CGFloat rowHeight = 40.0f;

@interface PopupView() <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) NSInteger rows;
@property (nonatomic, strong) NSMutableArray *iconArray;
@property (nonatomic, strong) NSMutableArray *textArray;
@property (nonatomic, strong) NSMutableArray *actionBlocks;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *Triangle;
@property (nonatomic, strong) UIView *bgView;

@end

PopupView *popupView;
BOOL isShow = NO;

@implementation PopupView

+ (instancetype)shareInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.rows = 0;
        self.Triangle = [[UIImageView alloc] initWithImage:[PopupView drawTriangle]];
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (NSMutableArray *)iconArray {
    if (!_iconArray) {
        _iconArray = [NSMutableArray array];
    }
    return _iconArray;
}

- (NSMutableArray *)textArray {
    if (!_textArray) {
        _textArray = [NSMutableArray array];
    }
    return _textArray;
}

- (NSMutableArray *)actionBlocks {
    if (!_actionBlocks) {
        _actionBlocks = [NSMutableArray array];
    }
    return _actionBlocks;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = popupView;
        _tableView.delegate = popupView;
        _tableView.rowHeight = rowHeight;
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
        [_tableView registerNib:[UINib nibWithNibName:@"PopupTableViewCell" bundle:nil] forCellReuseIdentifier:@"PopupTableViewCell"];
        [self addSubview:_tableView];
    }
    return _tableView;
}

+ (UIImage *)drawTriangle {
    
    UIGraphicsBeginImageContextWithOptions( CGSizeMake(2 * Trianglewidth, 2 * Trianglewidth), NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //绘制三角形
    CGContextMoveToPoint(context, Trianglewidth, 0);
    CGContextAddLineToPoint(context, 2 * Trianglewidth, 2 * Trianglewidth);
    CGContextAddLineToPoint(context, 0, 2 * Trianglewidth);
    //关闭路径，闭环，（连接起点和最后一个点）
    CGContextSetLineWidth(context, 2);
    CGContextClosePath(context);
    [[UIColor blackColor] setFill];
    
    CGContextFillPath(context);
    
    //获取生成的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}


+ (void)addCellWithIcon:(UIImage *)icon text:(NSString *)text action:(void (^)())action {
    //    if (!icon) {
    //        return;
    //    }
    
    popupView = [PopupView shareInstance];
    popupView.rows += 1;
    //[popupView.iconArray addObject:icon];
    [popupView.textArray addObject: (text.length ? text : @"item")];
    [popupView.actionBlocks addObject: (action ? [action copy] : [NSNull null])];
}

+ (void)popupViewInPosition:(HGGPopViewShowPosition)position {
    
    isShow = !isShow;
    
    isShow == YES ? [PopupView showWithPosition:position] : [PopupView hide];
    
    
    //发送信号
    NSDictionary *dic;
    if (isShow) {
        dic = @{@"status":@"NO"};
    }else{
        dic = @{@"status":@"YES"};
        
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeStatus" object:nil userInfo:dic];
}
+ (void)popupViewInButton:(UIButton *)button {
    
    
    isShow = !isShow;
    
    isShow == YES ? [PopupView showWithButton:button] : [PopupView hide];
    
    
    //发送信号
    NSDictionary *dic;
    if (isShow) {
        dic = @{@"status":@"NO"};
    }else{
        dic = @{@"status":@"YES"};
        
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeStatus" object:nil userInfo:dic];
    
}

+(void)showWithButton:(UIButton *)button
{
    UIWindow *window = [[[UIApplication sharedApplication] windows] firstObject];
    
    if (popupView == nil) {
        popupView = [PopupView shareInstance];
    }
    
    popupView.bgView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:popupView action:@selector(clickBgViewToHide)];
    [popupView.bgView addGestureRecognizer:tap];
    [window addSubview:popupView.bgView];
//    按钮右偏
    CGFloat offsetX = 0;
    if (button.frame.size.width/2 + button.frame.origin.x  > [UIScreen mainScreen].bounds.size.width/2) {
        
        offsetX = -10;
    }else if (button.frame.size.width/2 + button.frame.origin.x  < [UIScreen mainScreen].bounds.size.width/2)
    {
        offsetX = 10;
    }else{
        offsetX = 0;
    }
    
    
    popupView.Triangle.frame = CGRectMake(button.frame.origin.x + (button.frame.size.width/2) + offsetX, button.frame.origin.y + button.frame.size.height - 4, (Trianglewidth + 2) * 2, (Trianglewidth + 2) * 2);
    
    popupView.frame = CGRectMake(popupView.Triangle.frame.origin.x - popupViewWidth/2 + offsetX, CGRectGetMaxY(popupView.Triangle.frame), popupViewWidth, rowHeight * popupView.rows);
    
    
    
    
    popupView.layer.cornerRadius = 5;
    popupView.layer.masksToBounds = YES;
    [window addSubview:popupView.Triangle];
    
    
    [popupView addSubview: popupView.tableView];
    
    [window addSubview: popupView];
    
    
}
+ (void)showWithPosition:(HGGPopViewShowPosition)position {
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] firstObject];
    
    if (popupView == nil) {
        popupView = [PopupView shareInstance];
    }
    
    popupView.bgView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:popupView action:@selector(clickBgViewToHide)];
    [popupView.bgView addGestureRecognizer:tap];
    [window addSubview:popupView.bgView];
    
    
    if (ShowRight == position) {
        
        //
        popupView.Triangle.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 43, 60, (Trianglewidth + 2) * 2, Trianglewidth * 2);
        popupView.frame = CGRectMake(popupView.Triangle.frame.origin.x - popupViewWidth/2 - 10, CGRectGetMaxY(popupView.Triangle.frame), popupViewWidth, rowHeight * popupView.rows);
        
        
    }else if (ShowLeft == position){
        
        //        显示样式 -- 箭头位于按钮中间  箭头位于 POPView 中间偏左
        popupView.Triangle.frame = CGRectMake(43, 60, (Trianglewidth + 2) * 2, Trianglewidth * 2);
        popupView.frame = CGRectMake(20, CGRectGetMaxY(popupView.Triangle.frame), popupViewWidth, rowHeight * popupView.rows);
        
        
    }
    
    
    
    popupView.layer.cornerRadius = 5;
    popupView.layer.masksToBounds = YES;
    [window addSubview:popupView.Triangle];
    
    
    [popupView addSubview: popupView.tableView];
    
    [window addSubview: popupView];
    
}


+ (void)hide {
    if (popupView == nil) {
        return;
    }
    popupView.rows = 0;
    [popupView.bgView removeFromSuperview];
    [popupView.Triangle removeFromSuperview];
    [popupView removeFromSuperview];
    [popupView.actionBlocks removeAllObjects];
    popupView = nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PopupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PopupTableViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.textArray[indexPath.row];
    if (indexPath.row == self.textArray.count - 1) {
        cell.bottomView.hidden = YES;
    }else{
        cell.bottomView.hidden = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.actionBlocks.count == 0) {
        return;
    }
    id block = self.actionBlocks[indexPath.row];
    if (![block isEqual:[NSNull null]]) {
        [PopupView popupViewInPosition:ShowRight];
        ((void (^)())block)();
    }
}

- (void)clickBgViewToHide{
    NSLog(@"clickBgViewToHide");
    [PopupView popupViewInPosition:ShowLeft];
}

@end
