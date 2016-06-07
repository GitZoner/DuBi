//
//  JTMainTestViewController.m
//  DuBi
//
//  Created by Jason on 16/5/29.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "JTMainTestViewController.h"
#import "JTSelectTopView.h"

@interface JTMainTestViewController ()<JTSelectTopViewDelegate>

@end

@implementation JTMainTestViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden  = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    JTSelectTopView *topView = [[JTSelectTopView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 50 ,30)];
    
    self.navigationItem.titleView = topView;
    topView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clickButtonAction:(UIButton *)button {
    NSLog(@"sdfgsdg");
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
