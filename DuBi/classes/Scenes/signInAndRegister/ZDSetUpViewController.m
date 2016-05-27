//
//  ZDSetUpViewController.m
//  DuBi
//
//  Created by lanou3g on 16/5/25.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDSetUpViewController.h"

@interface ZDSetUpViewController ()

@end

@implementation ZDSetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self barButtonSet];
}

// barButton做按钮返回
-(void)barButtonSet{

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemPlay) target:self action:@selector(leftBarAction)];
}
-(void)leftBarAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
