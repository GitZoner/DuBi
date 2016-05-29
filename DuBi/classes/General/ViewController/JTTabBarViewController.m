//
//  JTTabBarViewController.m
//  Bester
//
//  Created by lanou3g on 16/5/16.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "JTTabBarViewController.h"
#import "JTTabBar.h"
#import "UIImage+ImageContentWithColor.h"
#import "Color_marco.h"
#import "MainViewController.h"
#import "JTSessionViewController.h"
#import <DCPathButton.h>
#import "ZYVideoViewController.h"
#import "ZDUserViewController.h"
#import "JTTabBar.h"
#import "ZDPublishController.h"
#import "EaseUI.h"
#import "JTCircleViewController.h"
#import "JTMainTestViewController.h"
#import "ZYTimeLineTableViewController.h"
@interface JTTabBarViewController ()<UITabBarControllerDelegate>





@end

@implementation JTTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
        self.delegate = self;
    
    // 统一设定 tabbar 上各控件的显示属性
    //    UIViewController *VC01 = [UIViewController new];
    //    VC01.view .backgroundColor = [UIColor redColor];
    [self setTabBarVC];
    
    // [self addCenterAction];
    
}

/*
-(void)presentView
{
    ZDPublishController * ZDpVc = [ZDPublishController new];
    ZDpVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:ZDpVc animated:YES completion:nil];
}
*/
-(void)setTabBarVC
{
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    NSDictionary *normalTextAttr = @{NSFontAttributeName:[UIFont systemFontOfSize:10],
                                     NSForegroundColorAttributeName:[UIColor grayColor]};
    [tabBarItem setTitleTextAttributes:normalTextAttr forState:(UIControlStateNormal)];
    NSDictionary *selectedTextAttr = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                       NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    [tabBarItem setTitleTextAttributes:selectedTextAttr forState:(UIControlStateHighlighted)];
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:THEME_COLOR imageSize:rect]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:THEME_COLOR imageSize:rect] forBarMetrics:(UIBarMetricsDefault)];
    
    // 精华
    [self setUpChildVCWithChildVC:[[UINavigationController alloc] initWithRootViewController:[JTMainTestViewController new]] title:@"精选" image:@"tabbar_jingxuan_nor" selectedImage:@"tabbar_jingxuan_h"];
    // 视频
    [self setUpChildVCWithChildVC:[[UINavigationController alloc] initWithRootViewController:[ZYVideoViewController new]] title:@"视频" image:@"tabbar_video_nor" selectedImage:@"tabbar_video_h"];
    // 圈子
    [self setUpChildVCWithChildVC:[[UINavigationController alloc] initWithRootViewController:[ZYTimeLineTableViewController new]] title:@"圈子" image:@"tabbar_circle_nor" selectedImage:@"tabbar_circle_h"];
    // 我
    [self setUpChildVCWithChildVC:[ZDUserViewController new] title:@"我" image:@"tabbar_me_nor" selectedImage:@"tabbar_me_h"];

    // 在自定义的 tabbar 里重新布局，然后替换掉系统的 tabbar
    [self setValue:[JTTabBar new] forKeyPath:@"tabBar"];
    [UIColor colorWithRed:0.702 green:0.702 blue:0.702 alpha:1.0];
}






/**
 *  @author Jason, 16-05-15 20:05:04
 *
 *  @brief 添加子控制的方法
 *
 *  @param childVC       子控制器
 *  @param title         标题
 *  @param image         正常情况下的按钮图片
 *  @param selectedImage 选中时的按钮图片
 *
 *  @since 1.0
 */

-(void)setUpChildVCWithChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    childVC.view .backgroundColor = [UIColor colorWithRed:arc4random_uniform(100) / 100.0 green:arc4random_uniform(100)/ 100.0 blue:arc4random_uniform(100) / 100.0 alpha:1.0];
    childVC.title = title;
    childVC.tabBarItem.image =[UIImage imageNamed:image ];
    childVC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self  addChildViewController:childVC];
}





/**
 *  JTTabBar的代理方法，帮它模态出一个控制器
 */



#pragma  mark --- tabBarVC代理方法
// tabBar之间切换动画
/*
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    // 给每个tabbar没个item设置tag值
//    for (UIView * subView in tabBar.subviews) {
//        for (int i = 0 ; i < tabBar.subviews.count; i++) {
//            subView.tag = i;
//        }
//    }
//    if (item.tag == 1) {
//        CATransition * animation = [CATransition animation]; // 创建CATransition对象
//        animation.duration = 0.55f; // 设置动画时间
//        animation.type = kCATransitionMoveIn; // 动画类型
//        animation.subtype = kCATransitionFromTop; // 设置子类
//        animation.timingFunction = UIViewAnimationOptionCurveEaseInOut; // 设置运动速度
//        
//        [self.view.layer addAnimation:animation forKey:@"animation"];
//
//    }else{
    
    CATransition * animation = [CATransition animation]; // 创建CATransition对象
    animation.duration = 0.55f; // 设置动画时间
    animation.type = kCATransitionPush; // 动画类型
    animation.subtype = kCATransitionFromLeft; // 设置子类
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut; // 设置运动速度
    [self.view.layer addAnimation:animation forKey:@"animation"];
    
}
*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
