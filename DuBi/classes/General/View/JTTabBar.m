//
//  JTTabBar.m
//  Bester
//
//  Created by lanou3g on 16/5/16.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "JTTabBar.h"

@interface JTTabBar ()

// 发布按钮
@property (strong,nonatomic)UIButton *publishButton;
@end
@implementation JTTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *publishButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:(UIControlStateNormal)];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:(UIControlStateHighlighted)];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
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
