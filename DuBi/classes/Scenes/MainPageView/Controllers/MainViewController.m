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
#import "PictureController.h"
#import "PictureHandle.h"
#define kInfomationHandle [InfomationHandle sharedInfomationHandle]
#define kPictureHandle [PictureHandle sharedPictureHandle]
#import "PictureViewCell.h"
#import "LWNViewController.h"
@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)NSArray *dataArray;
@end

@implementation MainViewController
// 懒加载数组
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor yellowColor];
    // 数据请求
    [self requestData];
    // 注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"PictureViewCell" bundle:nil] forCellReuseIdentifier:@"mainViewCellID"];
    // 设置代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
   // 取消线条
   self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(void)requestData{
 // 加载菊花样式
    [MBProgressHUD setUpHUDWithFrame:CGRectMake(0, 0, 50, 50) gifName:@"pika"andShowToView:self.view];
    [kPictureHandle getDataWithString:[NSString stringWithFormat:kTopicUrl,@""] comptionBlock:^(NSMutableArray *array) {
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
    return [kPictureHandle numberOfSections];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [kPictureHandle numofRowsAtSection:section];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PictureViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainViewCellID" forIndexPath:indexPath];
    cell.picture = [kPictureHandle pictureForCellAtIndexPath:indexPath];
    //[cell.shareButton addTarget:self action:@selector(shareAction) forControlEvents:(UIControlEventTouchUpInside)];
   // cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{



}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Picture *picture = [kPictureHandle pictureForCellAtIndexPath:indexPath];
  //  NSLog(@"%f",[MainViewCell heightForTopicLabel:topic]);
    return [PictureViewCell heightFor:picture];
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
#pragma mark ----点击button进行不同的页面跳转--------


- (IBAction)pictureAction:(id)sender {
  // 点击button,进行不同的数据请求
    [self requestPictureData];
}
-(void)requestPictureData{
    // 加载菊花样式
    [MBProgressHUD setUpHUDWithFrame:CGRectMake(0, 0, 50, 50) gifName:@"pika"andShowToView:self.view];
    [kPictureHandle getDataWithString:[NSString stringWithFormat:kPictureUrl,@""] comptionBlock:^(NSMutableArray *array) {
        [self updateData];
    }];
}

- (IBAction)pushAction:(id)sender {
    LWNViewController *lwn = [LWNViewController new];
    [self.navigationController pushViewController:lwn animated:YES];
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
