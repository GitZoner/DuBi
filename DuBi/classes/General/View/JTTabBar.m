//
//  JTTabBar.m
//  Bester
//
//  Created by lanou3g on 16/5/16.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "JTTabBar.h"
#import <POP.h>
#import "UIView+XYWidthHeight.h"
#import <DCPathButton.h>
#import "ZDPublishController.h"
#import "ZDPublishHaflView.h"
#import "ZDPublishHaflViewControl.h"


#define kWindow [UIApplication sharedApplication].keyWindow
#define kpingMuBounds [UIScreen mainScreen].bounds

@interface JTTabBar ()<ZDPublishHaflViewDelegate>

// 发布按钮
@property (strong,nonatomic)UIButton *publishButton;
@property (strong,nonatomic)UIView * publishView;
@property (strong ,nonatomic) DCPathButton *dcPathButton;


@end

@implementation JTTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
 
        UIButton *publishButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [publishButton setBackgroundImage:[UIImage  imageNamed:@"tabbar_+"] forState:(UIControlStateNormal)];
        // [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:(UIControlStateHighlighted)];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
        
    }
    return self;
}


/**
 *  中间按钮的点击事件
 */
UIWindow const * window;
-(void)publishClick
{

   // [UIView animateWithDuration:1 animations:^{
       
        window = [[UIWindow alloc]init];
        window.frame = [UIScreen mainScreen].bounds;
        window.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.8];
        window.hidden = NO;
    // ZDPublishHaflViewControl * phVC = [ZDPublishHaflViewControl new];
    // window.rootViewController = phVC;
    
    
         ZDPublishHaflView  * publishView = [[ZDPublishHaflView alloc]initWithFrame:CGRectMake(0,self.window.height + self.window.height / 3 * 2, self.window.width, self.window.height / 3)];
    publishView.myDelegate = self;
   
    //  [publishView.button addTarget:self action:@selector(buttonsAction:) forControlEvents:(UIControlEventTouchUpInside)];
    // 返回按钮
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(publishView.width /2, publishView.height - 23 ,15, 15)];
       //  [button setTitle:@"x" forState:(UIControlStateNormal)];
        button.titleLabel.font = [UIFont systemFontOfSize:30];
    [button setBackgroundImage:[UIImage imageNamed:@"signIn_cancel"] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:(UIControlEventTouchUpInside)];
         [window addSubview:publishView];
        //  self.block(window);
         [publishView addSubview:button];
  
#pragma mark --- 弹出视图的相关动画
    POPSpringAnimation * animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];

    animation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, kpingMuBounds.size.height + 10, self.window.width, self.window.height / 3)];
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, kpingMuBounds.size.height - self.window.height / 3, self.window.width, self.window.height / 3)];
    animation.springSpeed = 10;
    animation.springBounciness = 10;
    [publishView pop_addAnimation:animation forKey:nil];
}


// 点击button执行
//-(void)buttonsAction:(UIButton *)button
//{
//    if (button.tag == 101) {
//      
//        ZDSendJokesControllerViewController * sendJokesVC = [ZDSendJokesControllerViewController new];
//        
//        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:sendJokesVC animated:YES completion:nil];
//
//          NSLog(@"button1");
//        
////        if (_wodeDelegate && [_wodeDelegate respondsToSelector:@selector(presentView:)]) {
////            [_wodeDelegate presentView:button];
////        }
////
////        ZDPublishHaflViewControl * phVC = [[ZDPublishHaflViewControl alloc]init];
////
////        ZDSendJokesControllerViewController * sendJokesVC = [ZDSendJokesControllerViewController new];
////        [phVC presentViewController:sendJokesVC animated:YES completion:nil];
//        
//    }else if (button.tag == 102){
//        NSLog(@"button2");
//    }else if (button.tag == 103){
//        NSLog(@"button3");
//    }else{
//        NSLog(@"button4");
//    }
//}

// 点击返回x号 的事件
-(void)buttonAction
{
    [window removeFromSuperview];
    window.hidden = YES;
}


-(void)timeAction
{
    [UIView animateWithDuration:0.5 animations:^{
        self.publishView.transform = CGAffineTransformRotate(self.publishView.transform, M_2_PI);
    }];

}

-(void)hidderWindow
{
    window.hidden = YES;
}






-(void)layoutSubviews {
    [super layoutSubviews];
    // 设置发布按钮的 frame
    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    // 设置其他 UITabBarButton 的 frame
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttomW = self.frame.size.width / 5;
    CGFloat buttomH = self.frame.size.height;
    
    // 添加一个索引，用于跳过中间的按钮
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        // 如果不是UITabBarButton 这个类就跳过
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        // 计算按钮的 X 值
        buttonX = buttomW * ((index > 1)? (index + 1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttomW, buttomH);
        // 增加索引
        index ++;
    }
    
}

@end
