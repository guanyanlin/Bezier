//
//  BaseViewController.m
//  Bezier
//
//  Created by yanglong on 2017/8/14.
//  Copyright © 2017年 yanglong. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    UIView *bgView = [[UIView alloc]initWithFrame:self.view.frame];
//    bgView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:bgView];
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
