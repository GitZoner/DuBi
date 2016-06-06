//
//  ZDVisitingIdViewCotnroller.m
//  DuBi
//
//  Created by lanou3g on 16/6/5.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDVisitingIdViewCotnroller.h"
#import "Main_marco.h"
#import "ZDVisitingTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface ZDVisitingIdViewCotnroller ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

/**
 *  顶部视图
 */
@property (weak, nonatomic) IBOutlet UIView *topView;


/**
 *  背景图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

/**
 *  头像属性
 */
@property (weak, nonatomic) IBOutlet UIImageView *protraitImageView;

/**
 *  别名儿
 */
@property (weak, nonatomic) IBOutlet UILabel *aliasLabel;

/**
 * tableView
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 数组存放信息类别
@property(strong,nonatomic)NSMutableArray * typeArray;

// 存放信息
@property(strong,nonatomic)NSMutableArray * infoArray;
@end


static NSString * const CUSTOMCELL = @"regiser";
@implementation ZDVisitingIdViewCotnroller

-(NSMutableArray *)typeArray
{
    if (!_typeArray) {
     
        _typeArray = [NSMutableArray array];
    }
    return _typeArray;
}

-(NSMutableArray *)infoArray
{
    if (!_infoArray) {
     
        _infoArray = [NSMutableArray array];
    }
    return _infoArray;
}

-(void)addDataForArray{

    NSArray * typeArr = @[@"性别：",@"生日：",@"爱好：",@"邮箱：",@"自绍："];
    
    NSArray * dataArr = @[@"男",@"保密",@"吃饭,睡觉",@"保密",@"明知山有虎"];
    
    [self.typeArray addObjectsFromArray:typeArr];
    [self.infoArray addObjectsFromArray:dataArr];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 数据源相关设置
    [self addDataForArray];
    
    // 添加顶部视图
    [self setUpTopView];
    
    // 设置tableView
    [self setUpTableView];
    
    
}

-(void)setUpTopView
{
    NSString * protrait = [[NSUserDefaults standardUserDefaults]objectForKey:kUserInfoKey_protrait];
     NSString * alias = [[NSUserDefaults standardUserDefaults]objectForKey:kUserInfoKey_userAlias];
    
    [self.protraitImageView sd_setImageWithURL:[NSURL URLWithString:protrait] placeholderImage:[UIImage imageNamed:@"pro"]];
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:protrait] placeholderImage:[UIImage imageNamed:@"10"]];
    self.aliasLabel.text = alias;
   
}

// 设置tableView
-(void)setUpTableView{

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZDVisitingTableViewCell class]) bundle:nil] forCellReuseIdentifier:CUSTOMCELL];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

// 返回上一页面
- (IBAction)dismissAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark --- tableVeiw代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.typeArray.count;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZDVisitingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CUSTOMCELL forIndexPath:indexPath];
    cell.typeLabel.text = self.typeArray[indexPath.row];
    cell.infoLable.text = self.infoArray[indexPath.row];
    return cell;
}



#pragma mark --- scrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGPoint point = scrollView.contentOffset;
//    
//    if (point.y <= 0) {
//        
//        self.topView.frame = CGRectMake(0, 0, self.bgImageView.frame.size.width - point.y, self.bgImageView.frame.size.height - point.y);
//    }
//    if(point.y >= 0)
//    {
//        
//    }
}

















@end
