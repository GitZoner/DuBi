//
//  ZDUserChangeViewController.m
//  DuBi
//
//  Created by lanou3g on 16/5/29.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDUserChangeViewController.h"
#import "UIView+XYWidthHeight.h"
#import "ZDChangeView.h"
#import "ZDCustomUserTableViewCell.h"
#import "JTSignInChoiceViewController.h"

@interface ZDUserChangeViewController ()<UITableViewDelegate,UITableViewDataSource>
// tableVIew
@property(strong,nonatomic)UITableView * tableView;
// 头部视图
@property(strong,nonatomic)ZDChangeView * ChangeView;

// 图标imgages
@property(strong,nonatomic)NSArray * images;

// 分类名字
@property(strong,nonatomic)NSArray * typeArray;

@property(strong,nonatomic)NSString * hasSign;
@end

@implementation ZDUserChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 数据源
    [self arraySet];
    // 添加顶部视图
    [self addTopView];
    // 初始化tableView
    [self creatTableView];
    
    
}

-(void)arraySet
{
    self.typeArray = @[@"个人资料",@"都圈",@"更换主题",@"清除缓存",@"安全设置"];
    self.images = @[@"ziliao.png",@"quanzi.png",@"zhuti.png",@"huancun.png",@"anquan.png"];
}

#pragma mark --- 添加顶部视图
-(void)addTopView
{
    self.ChangeView = [[ZDChangeView alloc]initWithFrame:CGRectMake(0, -48, self.view.width, self.view.height * 2 / 7 + 48 * 2)];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.view addSubview:self.ChangeView];
}

-(void)tapAction
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

#pragma mark --- 初始化TableView

-(void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64,self.view.height , self.view.height - 64) style:(UITableViewStylePlain)];
    
    // 代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 注册cell
    [self.tableView registerClass:[ZDCustomUserTableViewCell class] forCellReuseIdentifier:@"tableView"];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    // 设置头部视图
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height * 2 / 7 - 64)];
    self.tableView.tableHeaderView = header;
    [self.view addSubview:self.tableView];
}





#pragma mark --- tableViewDelegate 
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.images.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZDCustomUserTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tableView"];
    
    NSString * tupianStr = _images[indexPath.row];
    cell.tuBImg.image = [UIImage imageNamed:tupianStr];
    cell.contentlabel.text = self.typeArray[indexPath.row];
    // cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark --- 父类scorllView的delegate
#define kImageViewForHeader self.ChangeView.imageViewForHeader
#define kImageViewForUser self.ChangeView.imageViewForUser
#define kTitleLabel self.ChangeView.titleLabel
#define kUIBlurEffect self.ChangeView.visualEffectView
// 滑动tableView的时候执行下面代码
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGPoint point = scrollView.contentOffset;
    if (point.y <= 0&& point.y >= -48 * 2)
    {
        kImageViewForHeader.frame = CGRectMake(0, -48 - point.y / 2, self.view.width, self.view.height * 2 / 7 + 48 * 2);
        kImageViewForUser.frame = CGRectMake(10 +20, kImageViewForHeader.height - 55 - 48 - point.y / 2, 45, 45);
        kTitleLabel.frame = CGRectMake(kImageViewForUser.x, CGRectGetMaxY(kImageViewForUser.frame) + 10, self.view.width - kImageViewForUser.x - kImageViewForUser.width - 10, 25);
        [UIView animateWithDuration:0.5 animations:^{
                kUIBlurEffect.alpha = 0;
        }];
        
    }
    
    else if(0 < point.y && point.y < self.view.height * 2 / 7 - 64){
       
        kImageViewForHeader.frame = CGRectMake(0, -48-point.y, self.view.width, self.view.height * 2 / 7 + 48 * 2);
        
        kImageViewForUser.frame = CGRectMake(10 + 20, kImageViewForHeader.height -55 -48, 45, 45);
        
        //
        kTitleLabel.frame = CGRectMake(kImageViewForUser.x, kImageViewForUser.y + 10 + kImageViewForUser.width +55, self.view.width - kImageViewForUser.x - kImageViewForUser.width - 10, 25);
        
        [UIView animateWithDuration:1 animations:^{
            kUIBlurEffect.alpha = point.y / (self.view.height * 2 / 7 - 64) + 0.2; 
        }];
       
    }
    
    else if (-48 * 2 >= point.y)
    {
        scrollView.contentOffset = CGPointMake(0, -48 * 2);
    }
    else if (point.y >= self.view.height * 2 / 7 - 64)
    {
        kImageViewForHeader.frame = CGRectMake(0, -48 - (self.view.height * 2 / 7 - 64), self.view.width, self.view.height * 2 / 7 + 48 * 2);
        kImageViewForUser.frame = CGRectMake(10 + 20, kImageViewForHeader.height - 55 - 48, 45, 45);
         kTitleLabel.frame = CGRectMake(kImageViewForUser.x , kImageViewForUser.y + kImageViewForUser.width +55, self.view.width - kImageViewForUser.x - kImageViewForUser.width - 10, 25);
        kUIBlurEffect.alpha = 0.6;
    }
}


@end