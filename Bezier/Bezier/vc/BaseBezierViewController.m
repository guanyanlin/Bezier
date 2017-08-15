//
//  BaseBezierViewController.m
//  Bezier
//
//  Created by yanglong on 2017/8/14.
//  Copyright © 2017年 yanglong. All rights reserved.
//

#import "BaseBezierViewController.h"
#import "BaseBezierView.h"

@interface BaseBezierViewController ()

@end

@implementation BaseBezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSMutableArray *entries = [NSMutableArray array];
    NSMutableArray *names = [NSMutableArray array];
    
    for(int i=0;i<10;i++){
        double val = (double)(arc4random_uniform(100));
        LineEntry *entry = [[LineEntry alloc]init];
        entry.yVal = val;
        entry.xVal = i+i*20.0;
        [entries addObject:entry];
        [names addObject:[NSString stringWithFormat:@"第%d个",i]];
    }
    [self createControlBtn];
    
    BaseBezierView *baseView = [[BaseBezierView alloc]init];
    baseView.viewType = _bezierType;//设置图形的实心和空心（1：实心；2：空心）
    baseView.frame = CGRectMake(0, 64, kSCREEN_W, kSCREEN_H-264);
    baseView.lineEntryArray = entries;
    baseView.xNamesArray = names;
    [self.view addSubview:baseView];
}
- (void)createControlBtn {
    


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
