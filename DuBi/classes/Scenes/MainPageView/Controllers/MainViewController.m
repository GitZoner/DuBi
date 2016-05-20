//
//  MainViewController.m
//  DuBi
//
//  Created by lanou3g on 16/5/19.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "MainViewController.h"
#import "InfomationHandle.h"
#import "MainViewCell.h"
@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载菊花样式
    // 数据请求
    // 注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"MainViewCell" bundle:nil] forCellReuseIdentifier:@"mainViewCellID"];
    // 设置代理
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainViewCellID" forIndexPath:indexPath];

    return cell;
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
