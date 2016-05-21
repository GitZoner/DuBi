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
#import "MBProgressHUD+gifHUD.h"
#import "InfomationHandle.h"
#import "LWNMainPageUrl.h"
#define kInfomationHandle [InfomationHandle sharedInfomationHandle]
@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor greenColor];
    // 数据请求
    [self requestData];
    // 注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"MainViewCell" bundle:nil] forCellReuseIdentifier:@"mainViewCellID"];
    // 设置代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
   // 取消线条
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
}
-(void)requestData{
 // 加载菊花样式
    [MBProgressHUD setUpHUDWithFrame:CGRectMake(0, 0, 50, 50) gifName:@""andShowToView:self.view];
    [kInfomationHandle getModelDataWithUrl:[NSString stringWithFormat:kTopicUrl,@""] comption:^(NSArray *array, NSError *error) {
        // 数据请求完毕,刷新数据
        [self updateData];
    }];
}
-(void)updateData{
    [self.tableView reloadData];
  // 数据加载完毕,就可以隐藏菊花样式
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [kInfomationHandle numberOfSections];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [kInfomationHandle numberOfRowsInsection:section];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainViewCellID" forIndexPath:indexPath];
    cell.topic = [kInfomationHandle topicForRowAtIndexPath:indexPath];
    //[cell.shareButton addTarget:self action:@selector(shareAction) forControlEvents:(UIControlEventTouchUpInside)];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{




}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Topic *topic = [kInfomationHandle topicForRowAtIndexPath:indexPath];
    return [MainViewCell heightForTopicLabel:topic];
}
#pragma mark ----收藏,分享功能-----
// 点击cell会模态出AlertController,在这这里进行分享,收藏的操作

-(void)shareActionWithTopic:(Topic *)topic{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"收藏" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        // 收藏
        // 收藏之前要判断是否登录,已经登录,直接收藏
        
        // 否则,进入登录界面
        
        
        
    }];
    UIAlertAction *shareAction = [UIAlertAction actionWithTitle:@"分享" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancleAction];
    [alertController addAction:shareAction];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
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
