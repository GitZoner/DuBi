//
//  CustomNavigationController.m
//  DuBi
//
//  Created by lanou3g on 16/6/2.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "CustomNavigationController.h"

#import "UIView+XYWidthHeight.h"


@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

//// 此方法只会当第一次使用这个类的时候被调用一次
//+(void)initialize{
//
//    UINavigationBar * bar = [UINavigationBar appearance];
//    [bar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:(UIBarMetricsDefault)];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

/**
 *  在这个方法中可以拦截所有push进来的控制器
 */
//
//-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    // 如果push进来的不是第一个控制器
//    if (self.childViewControllers.count > 0) {
//        
//        UIButton * button = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        [button setTitle:@"返回" forState:(UIControlStateNormal)];
//        [button setTitleColor:[UIColor colorWithRed:0.6667 green:0.6667 blue:0.6667 alpha:0.826050646551724] forState:(UIControlStateNormal)];
//          [button setTitleColor:[UIColor colorWithRed:0.0 green:0.502 blue:0.0 alpha:0.843884698275862] forState:(UIControlStateHighlighted)];
//        
//        button.width = 70;
//        button.height = 30;
//        // 让按钮内部的所有内容左对齐
//        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        // 按钮大小根据内容大小变化
//        //        [button sizeToFit];
//        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
//        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
//        [button setTitleColor:[UIColor redColor] forState:(UIControlStateHighlighted)];
//        [button addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
//        // 隐藏tabBar
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
//    // 这句super的push要放在后面，让viewCotnroller可以覆盖上面设置的leftBarButtonItem
//    [super pushViewController:viewController animated:YES];
//    
//
//}
//-(void)back
//{
//    // [SVProgressHUD dismiss];
//    [self popViewControllerAnimated:YES];
//}
//
















@end
