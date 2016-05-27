//
//  ZYButton.m
//  DuBi
//
//  Created by lanou3g on 16/5/23.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZYButton.h"
#import "UIView+XYWidthHeight.h"
@implementation ZYButton


+ (instancetype)creatWithButton:(UIButton *)button Title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage target:(id)target action:(SEL)action frame:(CGRect)frame{
    
    button = [ZYButton buttonWithType:(UIButtonTypeCustom)];
    
    button.frame = frame;
    
    
    [button setImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    [button setImage:[UIImage imageNamed:selectImage] forState:(UIControlStateHighlighted)];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -button.titleLabel.bounds.size.width, 0, 0);
    
    
    
    [button setTitle:title forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor redColor] forState:(UIControlStateHighlighted)];
    button.titleEdgeInsets = UIEdgeInsetsMake(0,button.titleLabel.frame.size.width, 0, 0);
    
    [button addTarget:button action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    
    return button;
    
}


@end
