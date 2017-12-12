//
//  ViewController.m
//  DropViewDemo
//
//  Created by 浩哥哥 on 2017/12/12.
//  Copyright © 2017年 浩哥哥. All rights reserved.
//

#import "ViewController.h"

#import "PopupView.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *leftBtn;

@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) UIButton *autoBtn;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"测试一发";
    
    _leftBtn = [[UIButton alloc]init];
    [_leftBtn setTitle:@"左边" forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:_leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    _rightBtn = [[UIButton alloc]init];
    [_rightBtn setTitle:@"右边" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    _autoBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, 100, 30)];
    [_autoBtn setTitle:@"自由按钮" forState:UIControlStateNormal];
    [_autoBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_autoBtn setBackgroundColor:[UIColor greenColor]];
    [_autoBtn addTarget:self action:@selector(autoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_autoBtn];
}

- (void)leftBtnAction
{
    [PopupView addCellWithIcon:nil text:@"第一个" action:^{
       
        NSLog(@"别点第一个");
    }];
    [PopupView addCellWithIcon:nil text:@"第二个" action:^{
        
        NSLog(@"别点第二个");
    }];
    [PopupView popupViewInPosition:ShowLeft];
}
- (void)rightBtnAction
{
    [PopupView addCellWithIcon:nil text:@"第一个" action:^{
        
        NSLog(@"别点第一个");
    }];
    [PopupView addCellWithIcon:nil text:@"第二个" action:^{
        
        NSLog(@"别点第二个");
    }];
    [PopupView popupViewInPosition:ShowRight];
}
- (void)autoBtnAction:(UIButton *)sender
{
    [PopupView addCellWithIcon:nil text:@"第一个" action:^{
        
        NSLog(@"别点第一个");
    }];
    [PopupView addCellWithIcon:nil text:@"第二个" action:^{
        
        NSLog(@"别点第二个");
    }];
    [PopupView popupViewInButton:sender];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
@end
