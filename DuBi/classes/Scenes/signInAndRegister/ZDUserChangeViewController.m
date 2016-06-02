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
#import <POP.h>


@interface ZDUserChangeViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
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
    self.ChangeView = [[ZDChangeView alloc]initWithFrame:CGRectMake(0, -48, self.view.width, self.view.height * 2 / 7 + 48 * 3)];
    [self.view addSubview:self.ChangeView];
    self.ChangeView.imageViewForHeader.userInteractionEnabled = YES;
    self.ChangeView.imageViewForUser.userInteractionEnabled = YES;
    // [self.ChangeView.nameButton addTarget:self action:@selector(tapAction) forControlEvents:(UIControlEventTouchUpInside)];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    tap.numberOfTapsRequired = 1;//手指数
    tap.numberOfTapsRequired = 1;//点击次数
    [self.ChangeView.nameButton
     addGestureRecognizer:tap];
}

-(void)tapAction
{
    NSLog(@"234");
    self.hasSign = [[NSUserDefaults standardUserDefaults] objectForKey:@"hasSign"];
    // [self.hasSign isEqualToString:@"NO"] ||self.hasSign == nil
    if (1) {
        JTSignInChoiceViewController * jtscVC = [JTSignInChoiceViewController new];
        [self.navigationController pushViewController:jtscVC animated:YES];
    }else {
        // 如果是已登录的状态，那么点击头像按钮，能够修改头像，或者浏览个人基本信息
        // 可以先简单实现上传个人头像的图片
        
    }

}


#pragma mark --- 初始化TableView

-(void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,109,self.view.height , self.view.height - 64) style:(UITableViewStylePlain)];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 注册cell
    [self.tableView registerClass:[ZDCustomUserTableViewCell class] forCellReuseIdentifier:@"tableView"];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    // self.tableView.contentInset = UIEdgeInsetsMake(45, 0, 44, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    // 设置头部视图
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height * 2 / 7 - 64)];
    self.tableView.tableHeaderView = header;
    [self.view insertSubview:self.tableView atIndex:0];
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
//     cell.backgroundColor = [UIColor clearColor];
    return cell;
}


#pragma mark --- 父类scorllView的delegate

#define kImageViewForHeader self.ChangeView.imageViewForHeader
#define kImageViewForUser self.ChangeView.imageViewForUser
#define kTitleLabel self.ChangeView.titleLabel
#define kUIBlurEffect self.ChangeView.visualEffectView

#define knameButton self.ChangeView.nameButton

// 滑动tableView的时候执行下面代码
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGPoint point = scrollView.contentOffset;
    NSLog(@"%zd",point.y);
    if (point.y <= 0&& point.y >= -48 * 2)
    {
        NSLog(@"1");
        kImageViewForHeader.frame = CGRectMake(0, -48 - point.y / 2, self.view.width - point.y, self.view.height * 2 / 7 + 48 * 3 - point.y );
        kImageViewForUser.frame = CGRectMake(10 +20, kImageViewForHeader.height - 55 - 48 - point.y / 3, 45, 45);
        kTitleLabel.frame = CGRectMake(kImageViewForUser.x, CGRectGetMaxY(kImageViewForUser.frame), self.view.width - kImageViewForUser.x - kImageViewForUser.width - 10, 25);
        knameButton.frame = CGRectMake(CGRectGetMaxX(kImageViewForUser.frame)+10, kImageViewForHeader.height - 55 - 48 - point.y / 2 + 5, knameButton.width, knameButton.height);
        
        [UIView animateWithDuration:0.5 animations:^{
                kUIBlurEffect.alpha = 0;
        }];
    
        
    }
    
    else if(0 < point.y && point.y < self.view.height * 2 / 7 - 64){
       NSLog(@"2");
        kImageViewForHeader.frame = CGRectMake(0, -48-point.y, self.view.width + point.y, self.view.height * 2 / 7 + 48 * 3);
        
        kImageViewForUser.frame = CGRectMake(10 + 20, kImageViewForHeader.height -55 -48, 45, 45);
        
        //
        kTitleLabel.frame = CGRectMake(kImageViewForUser.x, kImageViewForUser.y + kImageViewForUser.width, self.view.width - kImageViewForUser.x - kImageViewForUser.width - 10, 25);
        
        knameButton.frame = CGRectMake(CGRectGetMaxX(kImageViewForUser.frame)+10 , kImageViewForHeader.height -55-48+10, knameButton.width, knameButton.height);
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
        NSLog(@"3");
        
            kImageViewForHeader.frame = CGRectMake(0,  - (self.view.height * 2 / 7 - 64), self.view.width, self.view.height * 2 / 7 + 48 * 2);
            kImageViewForUser.frame = CGRectMake(10 + 20, kImageViewForHeader.height - 55 - 48, 45, 45);
            kTitleLabel.frame = CGRectMake(kImageViewForUser.x , kImageViewForUser.y + kImageViewForUser.width +55 - 35, self.view.width - kImageViewForUser.x - kImageViewForUser.width - 10, 25);
            knameButton.frame = CGRectMake(CGRectGetMaxX(kImageViewForUser.frame)+10, kImageViewForHeader.height - 55 - 48 +10, knameButton.width, knameButton.height);
            kUIBlurEffect.alpha = 0.6;
            //  self.tableView.tableHeaderView.frame = CGRectMake(0, 0,self.view.width, self.view.height * 2 / 7);
        // 动画不太好用
     /*
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            POPSpringAnimation * anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
            
            anim.fromValue = [NSValue valueWithCGRect:CGRectMake(0,  - (self.view.height * 2 / 7 - 64) - 100, self.view.width, self.view.height * 2 / 7 + 48 * 2)];
            
            anim.toValue = [NSValue valueWithCGRect:CGRectMake(0,  - (self.view.height * 2 / 7 - 64), self.view.width, self.view.height * 2 / 7 + 48 * 2)];
            
            anim.springSpeed = 5;
            anim.springBounciness = 5;
            anim.beginTime = CACurrentMediaTime();
            // anim.beginTime = CACurrentMediaTime() + 0.5 * i;
            [kImageViewForHeader pop_addAnimation:anim forKey:nil];
        });
      */
    }
}


@end
