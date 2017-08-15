//
//  MainViewController.m
//  Bezier
//
//  Created by yanglong on 2017/8/14.
//  Copyright © 2017年 yanglong. All rights reserved.
//

#import "MainViewController.h"
#import "BaseBezierViewController.h"

@interface MainViewController ()
@property (nonatomic, strong) UIButton *cusBtn;
@property (nonatomic, strong) UIView *contentView1;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    // Do any additional setup after loading the view.
    _cusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cusBtn.bounds = CGRectMake(0, 0, 40, 40);
    _cusBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_cusBtn setTitle:@"Back" forState:UIControlStateNormal];
    [_cusBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:_cusBtn];
    leftBarBtn.tintColor = [UIColor redColor];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    
    _contentView1 = [[UIView alloc]init];
    _contentView1.frame = self.view.frame;
    _contentView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView1];
    UIButton *baseLineBezierBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    baseLineBezierBtn.frame = CGRectMake(100, 150, 200, 50);
    baseLineBezierBtn.tag = 0x1101;
    [baseLineBezierBtn setTitle:@"基础的贝塞尔折线图" forState:UIControlStateNormal];
    baseLineBezierBtn.backgroundColor = [UIColor greenColor];
    [baseLineBezierBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView1 addSubview:baseLineBezierBtn];
    
    
    UIButton *baseBarBezierBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [baseBarBezierBtn setTitle:@"基础的贝塞尔柱状图" forState:UIControlStateNormal];
    baseBarBezierBtn.backgroundColor = [UIColor greenColor];
    baseBarBezierBtn.tag = 0x1102;
    [baseBarBezierBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView1 addSubview:baseBarBezierBtn];
    [baseBarBezierBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baseLineBezierBtn.mas_bottom).offset(30);
        make.left.equalTo(baseLineBezierBtn.mas_left);
        make.width.equalTo(@200);
        make.height.equalTo(@50);
    }];
    
    UIButton *basePieBezierBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [basePieBezierBtn setTitle:@"基础的贝塞尔饼状图" forState:UIControlStateNormal];
    basePieBezierBtn.backgroundColor = [UIColor greenColor];
    basePieBezierBtn.tag = 0x1103;
    [basePieBezierBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView1 addSubview:basePieBezierBtn];
    [basePieBezierBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baseBarBezierBtn.mas_bottom).offset(30);
        make.width.equalTo(@200);
        make.height.equalTo(@50);
        make.left.equalTo(baseBarBezierBtn.mas_left);
    }];
    
    
}
- (void)onClick:(UIButton *)sender {
    BaseBezierViewController *bazierVC = [[BaseBezierViewController alloc]init];
    switch (sender.tag) {
        case 0x1101:
            bazierVC.bezierType = 1;
            break;
        case 0x1102:
            bazierVC.bezierType = 2;
            break;
        case 0x1103:
            bazierVC.bezierType = 3;
            break;

        default:
            break;
    }
    [self.navigationController pushViewController:bazierVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
