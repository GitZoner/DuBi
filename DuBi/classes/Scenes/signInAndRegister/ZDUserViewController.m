//
//  ZDUserViewController.m
//  DuBi
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDUserViewController.h"
#import "UIView+XYWidthHeight.h"
#import "ZDCustomUserTableViewCell.h"
#import "ZDCustomHeaderView.h"
#import "JTSignInChoiceViewController.h"
@interface ZDUserViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView * tableView;



@property(strong,nonatomic)NSArray * typeArray;

@property(strong,nonatomic)ZDCustomHeaderView * headerView;

@end
static NSString * const cellID = @"cellID";

@implementation ZDUserViewController

//-(NSArray *)typeArray
//{
//    if (!_typeArray) {
//        _typeArray = @[@"个人资料",@"都圈",@"更换主题",@"清除缓存",@"安全设置"];
//    }
//    return _typeArray;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.typeArray = _typeArray = @[@"个人资料",@"都圈",@"更换主题",@"清除缓存",@"安全设置"];

    
    // 添加上边视图
    [self addTopView];
    
   // 设置tableView
    [self setTableView];
   
}
// 上边视图
-(void)addTopView
{
    ZDCustomHeaderView * headView = [[ZDCustomHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height / 3)];
    headView.bgImgView.userInteractionEnabled = YES;
    [self.view addSubview:headView];
    
    UITapGestureRecognizer * headerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerTapAction)];
        [headView.registerOrLoginButton addGestureRecognizer:headerTap];
}
// 点击button执行的方法
-(void)headerTapAction
{
    JTSignInChoiceViewController * jtscVC = [JTSignInChoiceViewController new];
    [self presentViewController:jtscVC animated:YES completion:nil];
}

/**
 *  tableView的设置
 */
-(void)setTableView{
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.height / 3 , self.view.width, self.view.height) style:(UITableViewStyleGrouped)];
    self.tableView.contentInset =UIEdgeInsetsMake(-30,0, 0, 0);
    [self.view addSubview:self.tableView];
    
//    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tableViewHeader"]];
//    imageView.frame = CGRectMake(0, 0, self.tableView.width, self.tableView.tableHeaderView.height);
//    [self.tableView.tableHeaderView addSubview:imageView];
    
//    self.headerView =  [[ZDCustomHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.width, self.tableView.tableHeaderView.height)];
//    
//    self.tableView.tableHeaderView = self.headerView;
//    
    
    [self.tableView registerClass:[ZDCustomUserTableViewCell class] forCellReuseIdentifier:cellID];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark --- 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.typeArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZDCustomUserTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    // cell.bgImgView.image = [UIImage imageNamed:@"tableViewHeader.jpg"];
    cell.contentlabel.text = self.typeArray[indexPath.row];
    return cell;
}

// 透视图高度
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return self.tableView.height / 3;
//}










@end
