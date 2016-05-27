//
//  ZDSetUpController.m
//  DuBi
//
//  Created by lanou3g on 16/5/25.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDSetUpController.h"

@interface ZDSetUpController ()
@property(strong,nonatomic)UIButton * backButton;

@end

@implementation ZDSetUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // 返回按钮
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.45 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self back];
    });
}
// 返回按钮
-(void)back{
    self.backButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 30, 32, 32)];
    [self.backButton setTitle:@"x" forState:(UIControlStateNormal)];
    [self.backButton addTarget:self action:@selector(backButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    
    [self.view addSubview:self.backButton ];
}
// 返回button响应的事件
-(void)backButtonAction
{
    [self dismissViewControllerAnimated:NO completion:nil];
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
