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
@interface JTTabBarViewController ()<UITabBarControllerDelegate,DCPathButtonDelegate>

@end

@implementation JTTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    // 统一设定 tabbar 上各控件的显示属性
    //    UIViewController *VC01 = [UIViewController new];
    //    VC01.view .backgroundColor = [UIColor redColor];
    
    [self setTabBarVC];
    
    
}


-(void)addCenterButton
{
    
    DCPathButton *dcPathButton = [[DCPathButton alloc]initWithCenterImage:[UIImage imageNamed:@"chooser-button-tab"]
                                                         highlightedImage:[UIImage imageNamed:@"chooser-button-tab-highlighted"]];
    
    // dcPathButton.delegate = self;
    
    // Configure item buttons
    
    DCPathItemButton *itemButton_1 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-music"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-music-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    
    DCPathItemButton *itemButton_2 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-place"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-place-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_3 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-camera"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-camera-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_4 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-thought"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-thought-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_5 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-sleep"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-sleep-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    // Add the item button into the center button
    //
    [dcPathButton addPathItems:@[itemButton_1,
                                 itemButton_2,
                                 itemButton_3,
                                 itemButton_4,
                                 itemButton_5
                                 ]];
    
    // Change the bloom radius, default is 105.0f
    //
    dcPathButton.bloomRadius = 120.0f;
    
    // Change the DCButton's center
    //
    dcPathButton.dcButtonCenter = CGPointMake(self.view.bounds.size.width + 210, self.view.bounds.size.height + 20);
    
    // Setting the DCButton appearance
    //
    dcPathButton.allowSounds = YES;
    dcPathButton.allowCenterButtonRotation = YES;
    
    dcPathButton.bottomViewColor = [UIColor redColor];
    
    dcPathButton.bloomDirection =  kDCPathButtonBloomDirectionTop;
    
    [self.view addSubview:dcPathButton];
    
    
}









-(void)setTabBarVC
{
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    NSDictionary *normalTextAttr = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                     NSForegroundColorAttributeName:[UIColor blackColor]};
    [tabBarItem setTitleTextAttributes:normalTextAttr forState:(UIControlStateNormal)];
    NSDictionary *selectedTextAttr = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                       NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    [tabBarItem setTitleTextAttributes:selectedTextAttr forState:(UIControlStateHighlighted)];
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:THEME_COLOR imageSize:rect]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:THEME_COLOR imageSize:rect] forBarMetrics:(UIBarMetricsDefault)];
    
    // 精华
    [self setUpChildVCWithChildVC:[MainViewController new] title:@"段图" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    // 新帖
    [self setUpChildVCWithChildVC:[UIViewController new] title:@"视频" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    // 关注
    [self setUpChildVCWithChildVC:[[UINavigationController alloc] initWithRootViewController:[JTSessionViewController new]] title:@"圈子" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    // 我
    [self setUpChildVCWithChildVC:[UIViewController new] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    // 在自定义的 tabbar 里重新布局，然后替换掉系统的 tabbar
    [self setValue:[JTTabBar new] forKeyPath:@"tabBar"];
    [UIColor colorWithRed:0.9712 green:0.7187 blue:0.0345 alpha:1.0];
    [self addCenterButton];
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





#pragma  mark --- tabBarVC代理方法
// tabBar之间切换动画
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{

    CATransition * animation = [CATransition animation]; // 创建CATransition对象
    animation.duration = 0.55f; // 设置动画时间
    animation.type = kCATransitionPush; // 动画类型
    animation.subtype = kCATransitionFromLeft; // 设置子类
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut; // 设置运动速度
    [self.view.layer addAnimation:animation forKey:@"animation"];
    
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
