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
#import "ZDSetUpController.h"
#import "ZDSetUpViewController.h"

@interface ZDUserViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView * tableView;

// 图标imgages
@property(strong,nonatomic)NSArray * images;

// 分类名字
@property(strong,nonatomic)NSArray * typeArray;
// 头视图
@property(strong,nonatomic)ZDCustomHeaderView * headerView;



// 右上角设置按钮
@property(strong,nonatomic)UIButton * rightButton;
@property (strong,nonatomic)NSString *hasSign; // YES or NO
@end
static NSString * const cellID = @"cellID";

@implementation ZDUserViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // self.view.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.799703663793103];
   // 数组初始化
    [self arraySet];
    
    // 添加上边视图
    [self addTopView];
    
   // 设置tableView
    [self setTableView];
   
    // 右上角设置按钮
    [self topRightButton];
    
    
}

// 右上角设置按钮
-(void)topRightButton
{
    self.rightButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.width - 45, 30, 24, 24)];
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"shezhi"] forState:(UIControlStateNormal)];
    [self.rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.rightButton];
}

// 右button时间
-(void)rightButtonAction
{
    
   //  NSLog(@"我的天呐。");
   //  ZDSetUpViewController * setUp = [ZDSetUpViewController new];
    
}


// 数组
-(void)arraySet
{
    self.typeArray = @[@"个人资料",@"都圈",@"更换主题",@"清除缓存",@"安全设置"];
    self.images = @[@"ziliao.png",@"quanzi.png",@"zhuti.png",@"huancun.png",@"anquan.png"];
}

// 上边视图
-(void)addTopView
{
    self.headerView = [[ZDCustomHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height / 3)];
    self.headerView.bgImgView.userInteractionEnabled = YES;
    [self.view addSubview:self.headerView];
    
    UITapGestureRecognizer * headerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerTapAction)];
        [self.headerView.touXimageView addGestureRecognizer:headerTap];
}
// 点击头像按钮的事件
-(void)headerTapAction
{
    self.hasSign = [[NSUserDefaults standardUserDefaults] objectForKey:@"hasSign"];
    if ([self.hasSign isEqualToString:@"NO"] ||self.hasSign == nil) {
        JTSignInChoiceViewController * jtscVC = [JTSignInChoiceViewController new];
        [self presentViewController:jtscVC animated:YES completion:nil];
    }else {
        // 如果是已登录的状态，那么点击头像按钮，能够修改头像，或者浏览个人基本信息
        // 可以先简单实现上传个人头像的图片
        
    }
   
}

/**
 *  tableView的设置
 */
-(void)setTableView{
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.height / 3 , self.view.width, self.view.height) style:(UITableViewStyleGrouped)];
    self.tableView.contentInset =UIEdgeInsetsMake(-30,0, 0, 0);
//    self.tableView.tableHeaderView.backgroundColor = [UIColor clearColor];
   //  self.tableView.tableHeaderView = self.headerView;
   //  self.tableView.backgroundColor = [UIColor clearColor];
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
    NSString * tupianStr = _images[indexPath.row];
    cell.tuBImg.image = [UIImage imageNamed:tupianStr];
    return cell;
}

// 透视图高度
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//   //  return self.tableView.height / 3;
//}










@end
