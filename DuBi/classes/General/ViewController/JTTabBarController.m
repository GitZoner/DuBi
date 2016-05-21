//
//  JTTabBarController.m
//  Bester
//
//  Created by lanou3g on 16/5/16.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "JTTabBarController.h"
#import "JTTabBar.h"
#import "UIImage+ImageContentWithColor.h"
#import "Color_marco.h"
#import "MainViewController.h"
@interface JTTabBarController ()

@end

@implementation JTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 统一设定 tabbar 上各控件的显示属性
    //    UIViewController *VC01 = [UIViewController new];
    //    VC01.view .backgroundColor = [UIColor redColor];
    
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    NSDictionary *normalTextAttr = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                     NSForegroundColorAttributeName:[UIColor blackColor]};
    [tabBarItem setTitleTextAttributes:normalTextAttr forState:(UIControlStateNormal)];
    NSDictionary *selectedTextAttr = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                       NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    [tabBarItem setTitleTextAttributes:selectedTextAttr forState:(UIControlStateHighlighted)];
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:THEME_COLOR imageSize:rect]];
    
    // 精华
    [self setUpChildVCWithChildVC:[MainViewController new] title:@"段图" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    // 新帖
    [self setUpChildVCWithChildVC:[UIViewController new] title:@"视频" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    // 关注
    [self setUpChildVCWithChildVC:[UIViewController new] title:@"圈子" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    // 我
    [self setUpChildVCWithChildVC:[UIViewController new] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    // 在自定义的 tabbar 里重新布局，然后替换掉系统的 tabbar
    [self setValue:[JTTabBar new] forKeyPath:@"tabBar"];
    [UIColor colorWithRed:0.9712 green:0.7187 blue:0.0345 alpha:1.0];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
