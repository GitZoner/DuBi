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
#import "LWNTableView.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property(strong,nonatomic)UIScrollView *scrollView;
@property(strong,nonatomic)LWNTableView *tableView1;
@property(strong,nonatomic)LWNTableView *tableView2;
@property(strong,nonatomic)LWNTableView *tableView3;

@end

@implementation MainViewController
// 懒加载数组

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView1 = [[LWNTableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight) withUrl:[NSString stringWithFormat:kTopicUrl,@""]];
    self.tableView1.delegate = self;
    self.tableView1.backgroundColor = [UIColor yellowColor];
    self.tableView2 = [[LWNTableView alloc]initWithFrame:CGRectMake(kWidth, 0, kWidth, kHeight) withUrl:[NSString stringWithFormat:kPictureUrl,@""]];
    self.tableView2.delegate = self;

    self.tableView2.backgroundColor = [UIColor blackColor];
    self.tableView3 = [[LWNTableView alloc]initWithFrame:CGRectMake(kWidth * 2, 0, kWidth, kHeight) withUrl:@""];
    self.tableView3.backgroundColor = [UIColor redColor];
    self.tableView3.delegate = self;

    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWidth * 3, kHeight)];
    [self.scrollView addSubview:self.tableView1];
    [self.scrollView addSubview:self.tableView2];
    [self.scrollView addSubview:self.tableView3];
    self.scrollView.contentSize = CGSizeMake(kWidth, 0);
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    
    
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger number = scrollView.contentOffset.x / kWidth;
    if (number == 0) {
        
    }else if (number == 1){
    
    }else if (number == 3){
    
    }
    
    
}
-(void)requestData{
 // 加载菊花样式
    [MBProgressHUD setUpHUDWithFrame:CGRectMake(0, 0, 50, 50) gifName:@"pika"andShowToView:self.view];
    [kPictureHandle getDataWithString:[NSString stringWithFormat:kTopicUrl,@""] comptionBlock:^(NSMutableArray *array) {
        [self updateData];
    }];
}
-(void)updateData{
    //[self.tableView reloadData];
  // 数据加载完毕,就可以隐藏菊花样式
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_tableView1]) {
        return self.tableView1.array.count ;

    } else if ([tableView isEqual:_tableView2]) {
    
        return self.tableView2.array.count ;
        
    }else{
        return self.tableView3.array.count ;

    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PictureViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainViewCellID" forIndexPath:indexPath];
    if ([tableView isEqual:_tableView1]) {
      cell.picture =  self.tableView1.array[indexPath.row] ;
    } else if ([tableView isEqual:_tableView2]) {
      cell.picture =  self.tableView1.array[indexPath.row] ;
    }else{
      cell.picture =  self.tableView1.array[indexPath.row] ;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{



}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_tableView1]) {
      Picture * picture =  self.tableView1.array[indexPath.row] ;
        return [PictureViewCell heightFor:picture];
    } else if ([tableView isEqual:_tableView2]) {
      Picture * picture =  self.tableView1.array[indexPath.row] ;
        return [PictureViewCell heightFor:picture];

    }else{
      Picture * picture =  self.tableView1.array[indexPath.row] ;
        return [PictureViewCell heightFor:picture];

    }

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
