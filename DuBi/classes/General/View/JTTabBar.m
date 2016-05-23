//
//  JTTabBar.m
//  Bester
//
//  Created by lanou3g on 16/5/16.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "JTTabBar.h"
#import "ZDPublishView.h"
#import <POP.h>
#import "UIView+XYWidthHeight.h"
#define kWindow [UIApplication sharedApplication].keyWindow
#define kpingMuBounds [UIScreen mainScreen].bounds

@interface JTTabBar ()

// 发布按钮
@property (strong,nonatomic)UIButton *publishButton;
@property (strong,nonatomic)UIView * publishView;
@end
@implementation JTTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *publishButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [publishButton setBackgroundImage:[UIImage  imageNamed:@"tabBar_publish_icon"] forState:(UIControlStateNormal)];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:(UIControlStateHighlighted)];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
        
    }
    return self;
}
UIWindow * window;

-(void)publishClick
{
    ZDPublishView * publishView = [ZDPublishView publishView];
    
    
        
    
    
//    [UIView animateWithDuration:0.5 animations:^{
//        publishView.transform = CGAffineTransformRotate(publishView.transform, 0.2);
//    }];
    // [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];


    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    window.backgroundColor = [UIColor redColor];
    publishView.frame = window.frame;
    
    self.publishView = publishView;
    
    POPSpringAnimation * anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    anim.fromValue = [NSValue valueWithCGRect:CGRectMake(- kpingMuBounds.size.width, self.height * 2, publishView.width / 2, publishView.height / 2)];
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, publishView.width, publishView.height)];
     
//    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(- kpingMuBounds.size.width, self.height)];
//    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(kpingMuBounds.size.width / 2   , kpingMuBounds.size.height / 2)];
    anim.springSpeed = 10;
    anim.springBounciness = 10;
    // anim.beginTime = CACurrentMediaTime() + 0.5; // 在某些动画执行完毕多久才执行
    [publishView pop_addAnimation:anim forKey:nil];

    [window addSubview:publishView];
}
-(void)timeAction
{
    [UIView animateWithDuration:0.5 animations:^{
        self.publishView.transform = CGAffineTransformRotate(self.publishView.transform, M_2_PI);
    }];

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
