//
//  ZDPersonInfo.m
//  DuBi
//
//  Created by lanou3g on 16/6/2.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDPersonInfo.h"
#import "ZDPersonInfoCell.h"
              
@interface ZDPersonInfo ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 类别数组
@property(strong,nonatomic)NSArray * typeArray;

// 内容数组
@property(strong,nonatomic)NSMutableArray * infoArray;

@property(strong,nonatomic)ZDPersonInfoCell * cell;
@end

@implementation ZDPersonInfo

-(NSMutableArray *)infoArray
{
    if (!_infoArray) {
        _infoArray = [NSMutableArray array];
    }
    return _infoArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    // 数据源设置
    [self setDate];
    
    
    
    NSLog(@"=====================%ld",_typeArray.count);
    // 左右上角按钮
    [self setButton];
    // tableView设置
    [self registerTableView];
    
}
-(void)setDate
{
    _typeArray = @[@"昵称",@"用户名",@"性别",@"电话"];
    
    NSString * userAlias =  [[NSUserDefaults standardUserDefaults] objectForKey:@"userAlias"];
    NSString * userID =  [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    NSString * gender = [[NSUserDefaults standardUserDefaults] objectForKey:@"gender"];
    NSString * telNum =  [[NSUserDefaults standardUserDefaults] objectForKey:@"telNum"];
    [_infoArray addObject:userAlias];
    [_infoArray addObject:userID];
    [_infoArray addObject:gender];
    [_infoArray addObject:telNum];
}

-(void)registerTableView
{
    self.tableView.autoresizesSubviews = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(-34, 0, 0, 0);
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZDPersonInfoCell class]) bundle:nil] forCellReuseIdentifier:@"cell"] ;
}

//  返回按钮的设置
-(void)setButton{
    // 返回按钮
    UIButton * button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitle:@"<返回" forState:(UIControlStateNormal)];
    button.frame = CGRectMake(0, 10, 70, 30);
    [button setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor greenColor] forState:(UIControlStateHighlighted)];
    [button addTarget:self action:@selector(backButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    
    UIButton * button1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button1 setTitle:@"完成" forState:(UIControlStateNormal)];
    button1.frame = CGRectMake(0, 10, 70, 30);
    button1.titleLabel.font = [UIFont systemFontOfSize:15];
     button1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [button1 setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [button1 setTitleColor:[UIColor greenColor] forState:(UIControlStateHighlighted)];
    [button1 addTarget:self action:@selector(rightButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
}

// 返回按钮的方法
-(void)backButtonAction
{
    NSLog(@"234");
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
}
// 完成按钮的方法
-(void)rightButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
   //  [[NSUserDefaults standardUserDefaults] setObject:self.cell.infoTextField.text forKey:@"userAlias"];
    
}


// 视图将要出现
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.hidesBackButton = YES;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _typeArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (self.cell == nil) {
        self.cell = [[ZDPersonInfoCell
                 alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    }
    self.cell.typeLabel.text = _typeArray[indexPath.row];
    self.cell.infoTextField.text = _infoArray[indexPath.row];
    return self.cell;
}
@end
