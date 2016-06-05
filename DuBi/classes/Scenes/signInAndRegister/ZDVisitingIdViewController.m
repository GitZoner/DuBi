//
//  ZDVisitingIdViewController.m
//  DuBi
//
//  Created by lanou3g on 16/6/5.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDVisitingIdViewController.h"

#import "UIView+XYWidthHeight.h"
#import "ZDVisitingIdView.h"
#import "Main_marco.h"

@interface ZDVisitingIdViewController ()<UITableViewDelegate,UITableViewDataSource>
// tableView
@property(strong,nonatomic)UITableView * tableView;

// 显示的数据
@property(strong,nonatomic)NSMutableArray * dataArray;

// 头部视图
@property(strong,nonatomic)ZDVisitingIdView * visitView;

@end

@implementation ZDVisitingIdViewController

-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.visitView.frame), self.view.width, self.visitView.height) style:(UITableViewStyleGrouped)];
    }
    
    return _tableView;
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
     
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 添加顶部视图
    [self addHeaderView];
    
    // tableView的设置
    [self setUpTableView];
    
    
}
-(void)addHeaderView
{
    
    // 取出头像
    NSString * protrait = [[NSUserDefaults standardUserDefaults]objectForKey:kUserInfoKey_protrait];
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:protrait]];
    UIImage * image = [[UIImage alloc]initWithData:data];
    // 取出别名
    NSString * alias = [[NSUserDefaults standardUserDefaults]objectForKey:kUserInfoKey_userAlias];
    self.visitView = [[ZDVisitingIdView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height * 0.3) imageView:image lable:alias];
    [self.view addSubview:self.visitView];
}

#pragma  mark --- 设置tableVIew
-(void)setUpTableView
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    return cell;
}











@end
