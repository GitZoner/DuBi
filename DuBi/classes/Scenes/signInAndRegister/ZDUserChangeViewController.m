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
#import <SDImageCache.h>
#import "CustomNavigationController.h"
#import "ZDPersonInfo.h"
#import "JTCircleMainController.h"
#import "AppDelegate.h"
#import "Main_marco.h"
#import <HyphenateFullSDK/EMSDKFull.h>
#import <UIImageView+WebCache.h>
#import "SVProgressHUD.h"
#import "ZDVisitingIdViewCotnroller.h"
#import "JTSignInViewController.h"
#define kScreen_w [UIScreen mainScreen].bounds.size.width
#define kScreen_h [UIScreen mainScreen].bounds.size.height

@interface ZDUserChangeViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,JTAliasViewControllerDelegate>
// tableVIew
@property(strong,nonatomic)UITableView * tableView;
// 头部视图
@property(strong,nonatomic)ZDChangeView * ChangeView;

// 图标imgages
@property(strong,nonatomic)NSArray * images;

// 分类名字
@property(strong,nonatomic)NSArray * typeArray;

@property(strong,nonatomic)NSString * hasSign;

// 缓存大小
@property(assign,nonatomic)CGFloat size;

// 夜间模式用
@property(strong,nonatomic)UIView * drakView;

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
    
    
    // 图片缓存 // 图片缓存大小
//    NSUInteger size = [SDImageCache sharedImageCache].getSize;
    // 自己方法
    
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
    [self.view addSubview:self.ChangeView];
    
    self.ChangeView.imageViewForHeader.userInteractionEnabled = YES;
    self.ChangeView.imageViewForUser.userInteractionEnabled = YES;
    
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
    if ([self.hasSign isEqualToString:@"NO"] || self.hasSign == nil) {
        JTSignInChoiceViewController * jtscVC = [JTSignInChoiceViewController new];
//        [self presentViewController:jtscVC animated:YES completion:nil];
        [self.navigationController pushViewController:jtscVC animated:YES];
    }else {
        
        // 如果是已登录的状态，那么点击头像按钮，能够修改头像，或者浏览个人基本信息
        // 可以先简单实现上传个人头像的图片
        
    }

}

// 隐藏NavigationBar
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    if ([kUserDefaultGetValue(@"hasSign") isEqualToString:@"YES"]) {
        // 刷新数据
        [self reloadDataAction];
        [self.ChangeView.nameButton setTitle:[[NSUserDefaults standardUserDefaults]objectForKey:kUserInfoKey_userAlias] forState:(UIControlStateNormal)];
        [self.ChangeView.imageViewForUser sd_setImageWithURL:[[NSUserDefaults standardUserDefaults]objectForKey:kUserInfoKey_protrait] placeholderImage:[UIImage imageNamed:@"pro"]];
    }
    else
    {
        self.ChangeView.imageViewForUser.image = [UIImage imageNamed:@"touxiang"];
        [self.ChangeView.nameButton setTitle:@"登录/注册" forState:(UIControlStateNormal)];
    }
    
    
    
}

-(void)reloadView
{
    [self reloadDataAction];
}

#pragma mark --- 刷新uUI
-(void)reloadDataAction
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


#pragma mark --- 初始化TableView

-(void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,109,self.view.height , self.view.height - 64) style:(UITableViewStylePlain)];
    // self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
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
     self.tableView.tableHeaderView.hidden = YES;
    // self.tableView.tableHeaderView = self.ChangeView;
    [self.view insertSubview:self.tableView atIndex:0];
    //[self.view addSubview:self.tableView];
}





#pragma mark --- tableViewDelegate 
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"hasSign"] isEqualToString:@"YES"])
    {
        return 2;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"hasSign"] isEqualToString:@"YES"])
        {
            if (section == 0) {
                return self.images.count;
            }
            return 1;
        }
    return self.images.count;
}

#pragma mark -- TableViewCell设置

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZDCustomUserTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tableView"];
    
#pragma mark  -- 图标图片名字
    NSString * tupianStr = _images[indexPath.row];
    if (indexPath.section == 1 && indexPath.row == 0 ) {
        
        cell.tuBImg.image = nil;
    }else{
    
        cell.tuBImg.image = [UIImage imageNamed:tupianStr];
    }
    cell.contentlabel.text = self.typeArray[indexPath.row];
    
#pragma mark  -- 清除缓存的显示设置
    // 清楚缓存
    if (indexPath.section == 0 && indexPath.row == 3) {

        // 获取缓存
        self.size =[SDImageCache sharedImageCache].getSize/1000.0/1000;
        // 清楚缓存
        cell.contentlabel.text = [NSString stringWithFormat:@"清楚缓存(已使用%0.1fMB)",self.size];
    }
    
#pragma mark -- 夜间模式的显示
    // 夜间模式
    if (indexPath.section == 0 && indexPath.row == 2) {
        
                       UISwitch * swi = [[UISwitch alloc]initWithFrame:CGRectMake(kScreen_w - 60, 5, 50, 30)];
        // 设置颜色
        swi.onTintColor = [UIColor greenColor];
        swi.tag = indexPath.row;
        [swi addTarget:self action:@selector(changeOption:) forControlEvents:(UIControlEventValueChanged)];
        // [cell.contentView addSubview:swi];
    }
#pragma mark  --  退出登录
    // 退出登录
    if (indexPath.section == 1 && indexPath.row == 0)
    {
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 2, self.view.width - 10, cell.height - 4)];
          [cell addSubview:titleLabel];
        titleLabel.text = @"退出登录";
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor colorWithRed:0.502 green:0.0 blue:0.0 alpha:1.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.layer.cornerRadius = 10;
      
        
//        cell.backgroundColor = [UIColor redColor];
//        cell.contentlabel.textColor = [UIColor whiteColor];
//        cell.contentlabel.text = @"退出登录";
////        cell.contentlabel.center = cell.center;
//        cell.contentlabel.textAlignment = NSTextAlignmentCenter;
//        cell.contentlabel.font = [UIFont systemFontOfSize:17];
//        // cell.contentlabel.frame = CGRectMake(5, 2, cell.width - 10, cell.height - 4);
//        cell.contentlabel.layer.cornerRadius = 10;
        // cell.contentlabel.center = cell.center;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }
    
//     cell.backgroundColor = [UIColor clearColor];
    return cell;
}

static UIWindow * window;
// 实现swi方法(设置夜间模式)
-(void)changeOption:(UISwitch *)swi
{

    //    UIApplication * app = [UIApplication sharedApplication];
    //    AppDelegate * delegate = app.delegate;
    if(swi.on == NO)
    {
        [self.drakView removeFromSuperview];
    window.hidden = YES;
    }
    if(swi.on) {
        
       
        window  = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        // 设置view的背景色
        self.drakView = [[UIView alloc]initWithFrame:self.view.bounds];
        self.drakView.backgroundColor = [UIColor blackColor];
        self.drakView.userInteractionEnabled = NO;
        window.hidden = NO;
        window.userInteractionEnabled = NO;
        self.drakView.alpha = 0.3;
        [window addSubview:self.drakView];
    }

}


/**
 *  cell的点击事件
 *
 *  @param tableView
 *  @param indexPath
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
#pragma mark  --- 清楚缓存
    // 清楚缓存
    if (indexPath.section == 0 && indexPath.row == 3) {
        
        [[SDImageCache sharedImageCache]clearDisk];
      
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"清楚缓存" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDestructive) handler:nil];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
        [alert addAction:action];
        [alert addAction:action1];
        
        [self presentViewController:alert animated:YES completion:nil];
#pragma mark --- 个人资料
    }else if(indexPath.section == 0 && indexPath.row == 0 ){
        
        self.hasSign = [[NSUserDefaults standardUserDefaults] objectForKey:@"hasSign"];
        if ([self.hasSign isEqualToString:@"YES"]) {
            
//            [self.navigationController pushViewController:[ZDVisitingIdViewController new] animated:YES];
            
            [self presentViewController:[ZDVisitingIdViewCotnroller new]  animated:YES completion:nil];
        }else{
            
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"请先登录" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
    
#pragma mark  --- DUBI圈
    }else if(indexPath.section == 0 && indexPath.row == 1){
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"hasSign"] isEqualToString:@"YES"]) {
            JTCircleMainController * jtclVC = [JTCircleMainController new];
            // [self.navigationController pushViewController:jtclVC animated:YES];
        }else if(indexPath.section == 0 && indexPath.row == 1){
           
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"请先登录" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
#pragma mark --- 退出登录
    
    else if (indexPath.row == 0 && indexPath.section == 1)
    {
     
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确认退出" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
            
            // 退出登录
            [SVProgressHUD show];
            kUserDefaultSetValue(@"NO", kUserInfoKey_hasSign);
            
            kUserDefaultSetValue(kUserDefaultValue_void, kUserInfoKey_telNum);
            kUserDefaultSetValue(kUserDefaultValue_void, kUserInfoKey_userAlias);
            kUserDefaultSetValue(kUserDefaultValue_void, kUserInfoKey_protrait);
            kUserDefaultSetValue(kUserDefaultValue_void, kUserInfoKey_gender);
            kUserDefaultSetValue(kUserDefaultValue_void, kUserInfoKey_userID);
            kUserDefaultSetValue(kUserDefaultValue_void, kUserInfoKey_passWord);
            
            EMError *error = [[EMClient sharedClient] logout:YES];
            if (!error) {
                NSLog(@"退出成功");
            }
            [self viewWillAppear:YES];
            // 添加通知中心
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOutNotification" object:nil];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                [self.tableView reloadData];
                
                // [self.ChangeView.imageViewForUser setNeedsDisplay];
            });

        }];
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:nil];
        [alert addAction:okAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        
}

#pragma mark --- 有待开发的功能
    else{
    
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"此功能有待开发，敬请期待" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];

    }
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
   // NSLog(@"%zd",point.y);
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
     //  NSLog(@"2");
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
       // NSLog(@"3");
        
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
