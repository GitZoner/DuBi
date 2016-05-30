//
//  ZDChangeView.m
//  DuBi
//
//  Created by lanou3g on 16/5/29.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDChangeView.h"

#import "UIView+XYWidthHeight.h"
#import "JTSignInChoiceViewController.h"
#import <Masonry.h>
@interface ZDChangeView ()

@property(strong,nonatomic)NSString * hasSign;
@end
@implementation ZDChangeView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
     
        [self drawView];
    }
    return self;
}


-(void)drawView{

   // 背景图片的设置
    [self addSubview:self.imageViewForHeader];
    // 头像的设置
    [self.imageViewForHeader addSubview:self.imageViewForUser];
    // 标题文字
    [self.imageViewForHeader addSubview:self.titleLabel];
    // 昵称
    [self.imageViewForHeader addSubview:self.nameButton];
    // 设置毛玻璃效果
    // [self fuzzyView];
}


// 背景图片的设置
-(UIImageView *)imageViewForHeader
{
    if (!_imageViewForHeader) {
      
        _imageViewForHeader = [[UIImageView alloc]initWithFrame:self.frame];
        _imageViewForHeader.userInteractionEnabled = YES;
        _imageViewForHeader.image = [UIImage imageNamed:@"beijingtu2"];
        [self addSubview:_imageViewForHeader];
        
    }
    return _imageViewForHeader;
}

-(UIImageView *)imageViewForUser
{
    if (!_imageViewForUser) {
        
        _imageViewForUser = [[UIImageView alloc]initWithFrame:CGRectMake(10 + 20, self.imageViewForHeader.height -55 - 55, 45, 45)];
        _imageViewForUser.userInteractionEnabled = YES;
        _imageViewForUser.image = [UIImage imageNamed:@"beijingtu2"];
        self.imageViewForUser.layer.cornerRadius = self.imageViewForUser.height / 2;
        self.imageViewForUser.layer.masksToBounds = YES;
//         [self.imageViewForHeader addSubview:self.imageViewForUser];
    }
    
    return _imageViewForUser;
}

// 设置标题label
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.imageViewForUser.x, CGRectGetMaxY(self.imageViewForUser.frame)+10,self.width - self.imageViewForUser.x - (10 + self.imageViewForUser.width) , 25)];
        self.titleLabel.text = @"别让现实挡住了你梦想的道路";
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.866460129310345];
        [self.imageViewForHeader addSubview:self.titleLabel];
    }
    
    return _titleLabel;
}

-(UIButton *)nameButton
{
    if (!_nameButton) {
     
        _nameButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
       
        _nameButton.frame = CGRectMake(CGRectGetMaxX(_imageViewForUser.frame) + 10-135, CGRectGetMinY(_imageViewForUser.frame) + 5, _titleLabel.width, _titleLabel.height);
        
        [_nameButton setTitle:@"登录/注册" forState:(UIControlStateNormal)];
       
        [_nameButton setTitleColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.866460129310345] forState:(UIControlStateNormal)];
        _nameButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nameButton addTarget:self action:@selector(nameButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
        //_nameButton.text = @"登录/注册";
        //_nameButton.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.866460129310345];
    }
    return _nameButton;
}
-(void)nameButtonAction
{
    NSLog(@"234");
}


// 毛玻璃方法
-(void)fuzzyView
{
    // 首先声明一个UIVisualEffectView 的对象
    self.visualEffectView = [[UIVisualEffectView alloc]initWithFrame:self.imageViewForHeader.frame];
    // 设置毛玻璃的效果
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:1];
    self.visualEffectView.effect = blur;
    // 透明度设置为0，后面会让它的透明度跟着tablkeView的偏移量改变，用来实现渐变模糊的效果
    self.visualEffectView.alpha = 0;
    
    [self insertSubview:self.visualEffectView atIndex:0];

}

@end
